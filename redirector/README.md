<!--
Copyright lowRISC contributors (OpenTitan project).
Licensed under the Apache License, Version 2.0, see LICENSES for details.
SPDX-License-Identifier: Apache-2.0
-->

# `redirector`
The redirector container is a minimal nginx deployment that is responsible for upgrading HTTP connections to HTTPS via a redirect and for redirecting requests to the top-level domain if they arrive on a subdomain (like www).
