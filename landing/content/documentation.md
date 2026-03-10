+++
title = "Documentation"
+++

<!--
Copyright lowRISC contributors (OpenTitan project).

SPDX-License-Identifier: CC-BY-SA-4.0
-->

[OpenTitan](https://opentitan.org/) is an open source silicon Root of Trust (RoT) project. 
OpenTitan will make the silicon RoT design and implementation more transparent, trustworthy, and secure for enterprises, platform providers, and chip manufacturers. 

## OpenTitan Documentation 

- [Getting Started](/book/doc/getting_started) 
- [Project Governance](../book/doc/project_governance)
- [Contributing](../book/doc/contributing)
- [Hardware](../book/hw)
- [Software](../book/sw)
- [Tools](../book/util)
- [Security](../book/doc/security/)

## OpenTitan Subsystems

The [OpenTitan Earl Grey](../book/hw/top_earlgrey/doc/datasheet.html) chip is a low-power secure microcontroller that is designed for several use cases requiring hardware security. 

{{ earlgrey_block_diagram() }}

[OpenTitan Darjeeling](../book/hw/top_darjeeling/doc/datasheet.html) is a system-on-a-chip Secure Execution Environment, capable of serving as a root of trust (RoT) for measurement and attestation among other applications, for instantiation within a larger system.

{{ darjeeling_block_diagram() }}


