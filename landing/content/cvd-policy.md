+++
title = "Coordinated Vulnerability Disclosure (CVD) Policy"
+++

<!--
Copyright lowRISC contributors (OpenTitan project).

SPDX-License-Identifier: CC-BY-SA-4.0
-->

We are dedicated to maintaining the security, integrity and reliability of our hardware and software designs, and we actively encourage responsible security vulnerability reporting from the security research and user community.

This policy applies to any vulnerabilities you believe you have discovered in OpenTitan’s hardware design, documentation, firmware, infrastructure, or associated materials ("Project Materials").

{{ cvd_process_overview() }}

# How to Report a Vulnerability?

## 1 - Preparation

Please contact our security team by sending an initial message to `security@opentitan.org`.
Please do not include a detailed report at this point, since this initial contact will be unencrypted.
Please also do not report security vulnerabilities through public GitHub issues.
You will receive a response from a member of our security team within 3 working days.
This response will contain a public PGP key.
We kindly ask you to use this key to encrypt subsequent messages (although it is not mandatory).
The key can be verified by comparing it with the key fingerprints listed below or in the [SECURITY.md](https://github.com/lowRISC/opentitan/blob/master/SECURITY.md) file in our GitHub repository.

## 2 - Submitting a Report

The next step is to provide us with a detailed summary of the vulnerability, including the following:
* Description of the vulnerability and its potential impact.
* Steps to reproduce the vulnerability or provide a proof-of-concept.
* Any relevant tools, scripts, logs, or outputs.

Please encrypt your message using the previously provided public PGP key to ensure its confidentiality.

# What to Expect After Submitting a Report?

After submitting your vulnerability report:
1. Acknowledgement receipt of your report within 3 working days.
1. Investigation of the reported vulnerability and verification of its validity.
1. Communication throughout our investigation, providing the reporter with updates.
1. We will work to resolve the vulnerability in accordance with our public security incident response policy.
   This includes notifying the open-source community at an appropriate time and addressing the concern in a public release if appropriate.
1. To encourage open collaboration, we will publicly acknowledge your contribution(s) to improving the security of projects covered by this policy once the issue is resolved.
   If you prefer to remain anonymous, please let us know.

# Public Disclosure

We understand the importance of transparency and will disclose the details of any security vulnerability in a timely manner once it has been addressed.
We request that the community follow responsible disclosure practices and refrain from publicly disclosing the vulnerability until:
* The issue has been fully investigated and a fix or mitigation is in place.
* Users have been provided with a reasonable period to apply the fix or mitigation.

Public disclosure prior to this may place users at risk and potentially be harmful to the community.

# Thanks

We sincerely appreciate the assistance of security researchers and users in keeping OpenTitan safe, secure, and trusted by the community.

# Policy Updates

This policy may be updated from time to time. We recommend revisiting this page occasionally to ensure you are aware of any changes.
