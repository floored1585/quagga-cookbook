Description
===========

This is a fork of [https://github.com/ooyala/quagga-cookbook](https://github.com/ooyala/quagga-cookbook).

This cookbook provides an interface via attributes to serveral Quagga daemons. It's written with
the intention of deploying Quagga on [Cumulus](http://cumulusnetworks.com) switches, and managing
router configuration as code.

This cookbook currently supports the following daemons:

* BGP
* OSPF
* Zebra

Requirements
============

Linux (only tested on recent versions of Debian and Ubuntu)

Attributes
==========

NOTE! Where you see "String or Array" for type, a String may be used _only_ for single values.  Use 
an Array of Strings for multiple values.

### General

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:router_id]` | Router-id to use for all protocols. This is superseded by protocol-specific router-ids, if they are defined. | String | `nil`
`node[:quagga][:enable_reload]` | Must be true in to enable reloading the quagga service (only applies to certain versions). | Boolean | `true`
`node[:quagga][:max_instances]` | Sets /etc/defaults/quagga "MAX_INSTANCES" value. | Integer | `5`
`node[:quagga][:integrated_vtysh_config]` | Must be set to true in order to reload quagga (vs restart) on config changes. Details [here](http://www.nongnu.org/quagga/docs/docs-multi/VTY-shell-integrated-configuration.html) and [here](http://docs.cumulusnetworks.com/display/DOCS/Configuring+Quagga). | Boolean | `false`

### BGP

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:bgp]` | A hash containing the BGP processes and their configuration.  Keys are the local ASNs/processes (Integer), values are the data for that process (Hash). | Hash | `{}`
`node[:quagga][:bgp][$LOCAL_ASN][:router_id]` | Sets the router-id for this BGP process. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:redistribute]` | Route types to redistribute into BGP (eg: `["connected","ospf"]`. | String or Array | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors]` | A hash containing neighbors and their configuration.  Keys are the neighbor IPs or group names (String), values are the data for that neighbor or group (Hash). | Hash | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:remote_as]` | The remote-as for this neighbor. | Integer | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:default_originate]` | Set to `true` to advertise a default route to this neighbor. | Boolean | `false`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:default_originate_map]` | The name of the route-map to use with default-originate. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:peer_group]` | Set to `true` if this is a peer-group. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:peer_group_range]` | The IP range(s) to permit for this group (BGP Dynamic Neighbors). | String or Array | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:soft_reconfig_in]` | Enable soft-reconfiguration-inbound (to enable dispaly of received routes). | Boolean | `false`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:prefix_list_in]` | Name of the prefix-list to use for filtering incoming routes. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:prefix_list_out]` | Name of the prefix-list to use for filtering outgoing routes. | String | `nil`

### OSPF

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:ospf][:router_id]` | Sets the router-id for OSPF. | String | `nil`
`node[:quagga][:ospf][:redistribute]` | Route types to redistribute into OSPF (eg: `["connected","bgp"]`. | String or Array | `[]`
`node[:quagga][:ospf][:passive_default]` | Set passive-interface default (Active interfaces must be defined). ***needs tests*** | Boolean | `true`
`node[:quagga][:ospf][:passive_ints]` | Names of passive interfaces. | String or Array | `nil`
`node[:quagga][:ospf][:areas]` | A Hash containing areas and their configurations.  Keys are the area IDs (eg: 0.0.0.0), values are the data for that area. | Hash | `{}`
`node[:quagga][:ospf][:areas][$AREA][:networks]` | Networks to include in the area. | String or Array | `nil`
`node[:quagga][:ospf][:networks]` | ***needs description & tests***. | String or Array | `[]`

### Prefix Lists

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:prefix_lists]` | A hash containing all of the prefix-lists to configure in quagga.  Keys are the prefix-list names, values are hashes filled with the entries. | Hash | `{}`
`node[:quagga][:prefix_lists][$LIST]` | A hash containing all of the entries in a particular $LIST.  Keys are sequence numbers, values are hashes filled with the details of the entry. | Hash | `{}`
`node[:quagga][:prefix_lists][$LIST][$SEQ][:prefix]` | The prefix affected by this rule (must be `x.x.x.x/x`). If left out, rule will match any prefix | String | `any`
`node[:quagga][:prefix_lists][$LIST][$SEQ][:ge]` | The minimum prefix length to accept (eg: `24`) | Integer | `nil`
`node[:quagga][:prefix_lists][$LIST][$SEQ][:le]` | The maximum prefix length to accept (eg: `24`) | Integer | `nil`
`node[:quagga][:prefix_lists][$LIST][$SEQ][:action]` | The action to take (either 'permit' or 'deny'). | String | `nil`

Usage
=====

Simply set the desired attributes (see Attributes section above) then call the proper recipe (quagga::bgpd, quagga::ospfd).  There is also a provider for zebra, but no recipe as of yet.

### BGP Example

The following example will create BGP process 64512 with dynamic neighbors.  Devices in the 10.0.0.0/8 range ('hosts' peer-group) will be able to peer with this process.  A regular neighbor 192.168.52.1 is configured here also.  Neighbors in the group and the normal neighbor will receive a default route when peered with this instance.

```ruby
node.set[:quagga][:bgp]['64512'][:log_neighbor_changes] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:remote_as] = 64512
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:default_originate] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group_range] = '10.0.0.0/8'
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:remote_as] = 23456
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:default_originate] = true

include_recipe 'quagga::bgpd'
```

### OSPF Example

The following example will create an OSPF area 0, with quagga reload enabled and an OSPF-specific router-id.  All interfaces with addresses in 10.0.0.0/8 will actively participate in OSPF, except for the ones explicitly listed as `:passive_ints`.

```ruby
node.set[:quagga][:integrated_vtysh_config] = true
node.set[:quagga][:ospf][:router-id] = 10.0.0.1
node.set[:quagga][:ospf][:passive_default] = false
node.set[:quagga][:ospf][:areas][0.0.0.0][:networks] = '10.0.0.0/8'
node.set[:quagga][:ospf][:passive_ints] = ['lo', 'br-access']

include_recipe 'quagga::ospfd'
```

Contributing
============

Any form of contribution is welcome!  Feature requests, bug reports, pull requests, whatever!
If you add features, make sure there are tests for them, and if you change any code, make sure
the existing tests all pass _before_ creating a pull request.

Tests are run on a [Cumulus VX](https://cumulusnetworks.com/cumulus-vx) VM using serverspec.

Testing requirements:
* Vagrant
* VirtualBox

To run the tests (after installing prerequisites):
* `bundle install`
* `rake rubocop`
* `rake test`

Author and License
===================

__Original Author__ Bao Nguyen <opensource-cookbooks@ooyala.com>  
__Current Maintainer (0.2.0 onwards)__ Ian Clark <ian@f85.net>

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
