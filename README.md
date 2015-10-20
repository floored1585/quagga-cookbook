Description
===========

This cookbook provide an interface via Provider to serveral Quagga daemons. It's written with
the intention of deploying Quagga on Cumulus OS running on compatible [1] OEM switches.

It's currently supporting the following daemons:

Zebra (interfaces)
OSPF
BGP

[1] http://cumulusnetworks.com/support/linux-hardware-compatibility-list/

Requirements
============

Linux

Attributes
==========

__TODO__

Usage
=====

Simply set the desired attributes (see Attributes section above) then call the proper recipe (quagga::bgpd, quagga::ospfd).  There is also a provider for zebra, but no recipe as of yet.

Author and License
===================

__Original Author__ Bao Nguyen <opensource-cookbooks@ooyala.com>  
__Current Author (0.2.0 onwards)__ Ian Clark <ian@f85.net>

Copyright 2014, Ooyala Inc.  
Copyright 2015, Ian Clark

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
