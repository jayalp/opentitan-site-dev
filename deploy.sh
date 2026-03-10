#!/usr/bin/env bash

# Copyright lowRISC contributors (OpenTitan project).
# Licensed under the Apache License, Version 2.0, see LICENSES for details.
# SPDX-License-Identifier: Apache-2.0

##########################################################
#
# Script to automate site deployment tasks to Gcloud
#
# You will require authentication to perform Gcloud actions
# against the project id's specified.
# If you have been granted appropriate permissions, you can
# authenticate locally by running `gcloud auth login`, and
# after that the commands here should execute as-intended.
#
##########################################################

set -e

# Get the project directory from Git.
root="$(git rev-parse --show-toplevel)"
public="${root}/landing/public"

declare PROJECT           # Gcloud project
declare INSTANCE_GROUP    # Gcloud compute instance group

# docs.opentitan.org
DOCS_OPENTITAN_ORG_ID=active-premise-257318

# opentitan.org
OPENTITAN_ORG_ID=gold-hybrid-255313

################
# DEPENDENCIES #
################

# Check for gcloud-sdk
if ! command -v gcloud >/dev/null; then
    echo "E: gcloud not found." >&2
    echo "E: See instructions at https://cloud.google.com/sdk/docs/install, or:" >&2
    echo "E:   $ nix shell nixpkgs#google-cloud-sdk" >&2
    exit 1
fi

############
# BUILDING #
############

deploy_redirector () {
    PROJECT="$OPENTITAN_ORG_ID"
    INSTANCE_GROUP=opentitan-dot-org-redirector

    # Note that it can take a while for the instance group to catch up with the
    # update, and then up to twelve hours for the CDN cache to expire. If you
    # need to do a faster push: wait until the rolling restart is complete and
    # manually invalidate the CDN.

    gcloud config set project "$PROJECT"
    gcloud builds submit --tag "gcr.io/${PROJECT}/redirector_v2" "${root}/redirector/landing"
    gcloud compute instance-groups managed rolling-action replace --max-surge=3 --region=us-central1 "$INSTANCE_GROUP"
}

deploy_docs_redirector () {
    PROJECT="$DOCS_OPENTITAN_ORG_ID"
    INSTANCE_GROUP=docs-redirector

    # Note that it can take a while for the instance group to catch up with the
    # update, and then up to twelve hours for the CDN cache to expire. If you
    # need to do a faster push: wait until the rolling restart is complete and
    # manually invalidate the CDN.

    gcloud config set project "$PROJECT"
    gcloud builds submit --tag "gcr.io/${PROJECT}/redirector_v2" "${root}/redirector/docs"
    gcloud compute instance-groups managed rolling-action replace --max-surge=3 --region=us-central1 "$INSTANCE_GROUP"
}

deploy_staging () {
    PROJECT="$OPENTITAN_ORG_ID"
    BUCKET="${PROJECT}-staging"
    LOAD_BALANCER_NAME="opentitan-dot-org"

    # Build site.
    rm -rf "$public"
    zola -r landing build --base-url "https://staging.opentitan.org"

    gcloud config set project "$PROJECT"

    # Upload uncompressed files (only compressed in flight).
    gcloud storage cp -R --gzip-in-flight=js,css,html "$public"/* "gs://${BUCKET}"

    # Invalidate CDN cache.
    gcloud compute url-maps invalidate-cdn-cache "$LOAD_BALANCER_NAME" \
        --host "staging.opentitan.org" \
        --path "/*" \
        --async
}

# Build and deploy the landing page to the `opentitan.org` bucket.
deploy_prod () {
    PROJECT="$OPENTITAN_ORG_ID"
    BUCKET="${PROJECT}-prod"
    LOAD_BALANCER_NAME="opentitan-dot-org"

    # Build site.
    rm -rf "$public"
    zola -r landing build

    gcloud config set project "$PROJECT"

    # Upload uncompressed files (only compressed in flight).
    gcloud storage cp -R --gzip-in-flight=js,css,html "$public"/* "gs://${BUCKET}"

    # Invalidate CDN cache.
    gcloud compute url-maps invalidate-cdn-cache "$LOAD_BALANCER_NAME" \
        --host "opentitan.org" \
        --path "/*" \
        --async
}

#######
# CLI #
#######
case "$1" in
    "redirector") deploy_redirector ;;
    "redirector-docs") deploy_docs_redirector ;;
    "site-builder") deploy_site_builder ;;
    "staging") deploy_staging ;;
    "prod") deploy_prod ;; # DO NOT USE
    "help"|*)
        echo "USAGE: $0 <command>"
        echo ""
        echo "commands:"
        echo "  help             prints this message."
        echo "  site-builder     build and deploy the site-builder container image"
        echo "  staging          build and deploy the site to staging.opentitan.org"
        echo "  redirector       build and deploy the redirector instances for production"
        echo "  redirector-docs  build and deploy the redirector instances for docs.opentitan.org"
        exit 0
        ;;
esac
