<!--
Copyright lowRISC contributors (OpenTitan project).
Licensed under the Apache License, Version 2.0, see LICENSES for details.
SPDX-License-Identifier: Apache-2.0
-->

# OpenTitan site

This repository contains the source for the <https://opentitan.org> site.

In this repository, you will find:

* `deploy.sh`: script for deploying to Google Cloud.
* `landing/`: Zola static site for the <https://opentitan.org> landing page.
* `redirector/`: configurations for HTTP redirectors.
  * `redirector/docs/`: redirects `docs.opentitan.org` -> `opentitan.org/book`.
  * `redirector/landing/`: redirects HTTP -> HTTPS.

## Building the landing page

The site is built with Zola. See [Zola's installation guide].

Spawn a development server using:

```sh
zola -r landing serve
```

## Deploying the landing page

The site is deployed to `opentitan.org` automatically by CI.

To manually deploy to `staging.opentitan.org`, use:

```sh
./deploy.sh staging
```

You will need access to the staging bucket within the OpenTitan Google Cloud.
Use `gcloud auth login` to connect the CLI to your OpenTitan account.

## License

This repository follows the [REUSE spec](https://reuse.software/spec-3.2/).

Every file must have a copyright and license assignment. Files which cannot
contain comments such as images can be accounted for in `REUSE.toml`.

See the [`LICENSES/`](./LICENSES) directory for all licenses used in this repository.

[Zola's installation guide]: https://www.getzola.org/documentation/getting-started/installation/
