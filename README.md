[![Build Status](https://travis-ci.org/nertwork/quagga-cookbook.svg?branch=master)](https://travis-ci.org/nertwork/quagga-cookbook)

Description
===========

This is a fork of [https://github.com/ooyala/quagga-cookbook](https://github.com/ooyala/quagga-cookbook).  The functionality here is much different, and this cookbook is not backwards comptaible.

This cookbook provides an interface via attributes to serveral Quagga daemons. It's written with
the intention of deploying Quagga on [Cumulus](http://cumulusnetworks.com) switches, and managing
router configuration as code.

This cookbook currently supports the following daemons:

* BGP
* OSPF
* Zebra

Requirements
============

Tested on:
* Cumulus Linux 1.5.3
* Ubuntu 14.04

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
`node[:quagga][:multiple_instance]` | Must be set to true in order to support multiple routing-instances or vrfs. Supported in Cumulus Linux 2.5.3SE and adopted in Cumulus Linux 3.0. | Boolean | `false`

### BGP

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:bgp]` | A hash containing the BGP processes and their configuration.  Keys are the local ASNs/processes (Integer), values are the data for that process (Hash). | Hash | `{}`
`node[:quagga][:bgp][$LOCAL_ASN][:router_id]` | Sets the router-id for this BGP process. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:redistribute]` | Route types to redistribute into BGP (eg: `["connected","ospf"]`. | String or Array | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:hold_time]` | BGP hold time (must also set `keepalive_interval`). | Integer | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:keepalive_interval]` | BGP keepalive interval (must also set `hold_time`). | Integer | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:max_paths]` | Maximum number of ECMP paths. | Integer | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors]` | A hash containing neighbors and their configuration.  Keys are the neighbor IPs or group names (String), values are the data for that neighbor or group (Hash). | Hash | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:remote_as]` | The remote-as for this neighbor. | Integer | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:default_originate]` | Set to `true` to advertise a default route to this neighbor. | Boolean | `false`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:default_originate_map]` | The name of the route-map to use with default-originate. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:peer_group]` | Set to `true` if this is a peer-group. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:peer_group_range]` | The IP range(s) to permit for this group (BGP Dynamic Neighbors). | String or Array | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:soft_reconfig_in]` | Enable soft-reconfiguration-inbound (to enable dispaly of received routes). | Boolean | `false`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:prefix_list_in]` | Name of the prefix-list to use for filtering incoming routes. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:prefix_list_out]` | Name of the prefix-list to use for filtering outgoing routes. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:route_map_in]` | Name of the route-map to use for filtering incoming routes. | String | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors][$NEIGHBOR][:route_map_out]` | Name of the route-map to use for filtering outgoing routes. | String | `nil`

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

### Route Maps

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:route_maps]` | A hash containing all of the route-maps to configure in quagga.  Keys are the route-map names, values are hashes filled with the entries. | Hash | `{}`
`node[:quagga][:route_maps][$LIST]` | A hash containing all of the entries in a particular $LIST.  Keys are sequence numbers, values are hashes filled with the details of the entry. | Hash | `{}`
`node[:quagga][:route_maps][$LIST][$SEQ][:action]` | The action to take (either 'permit' or 'deny'). | String | `nil`
`node[:quagga][:route_maps][$LIST][$SEQ][:set]` | A hash containing all the actions to set when mapping the route (must be a identified below). If left out the rule will not do anything  | Hash | `{}`
`node[:quagga][:route_maps][$LIST][$SEQ][:set][:aggregator]` | The aggregator AS as well as the aggregator IP address | Hash | `{}`
`node[:quagga][:route_maps][$LIST][$SEQ][:set][:aggregator]` | Hash containing the aggregator AS and IP address | Hash | `{}`
`node[:quagga][:route_maps][$LIST][$SEQ][:set][:aggregator][:as]` | The aggregator AS | Integer | `nil`
`node[:quagga][:route_maps][$LIST][$SEQ][:set][:aggregator][:ip]` | The aggregator IP address | String | `nil`
`node[:quagga][:route_maps][$LIST][$SEQ][:set][:local_preference]` | The local prefernce to set on the route | Integer | `nil`

### Static Routes

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:static_routes]` | A hash containing static routes to configure.  Keys are the prefixes, values are the next-hop addresses.  | Hash | `nil`
`node[:quagga][:static_routes][$ROUTE]` | The next-hop address for given $ROUTE | String | `any`

### Multiple Routing Instances (VRFs)

Attribute        | Description |Type | Default
-----------------|-------------|-----|--------
`node[:quagga][:multiple_instance]` | Must be set to true in order to support multiple routing-instances or vrfs. Supported in Cumulus Linux 2.5.3SE and adopted in Cumulus Linux 3.0. | Boolean | `false`
`node[:quagga][:interfaces][$IF_NAME]` | The interface you wish to assign to a routing table followed by a specific table. | Array | `nil`
`node[:quagga][:bgp][$LOCAL_ASN][:neighbors]` | A hash containing neighbors and their configuration. Local ASN need to have the table specified. Keys are the neighbor IPs or group names followed by (String) values for that neighbor or group (Hash). | Hash | `nil`
`node[:quagga][:static_routes][$ROUTE]` |  A hash, with a specified table, containing static routes to configure.  Keys are the prefixes, values are the next-hop addresses.  | Hash | `nil`

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
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:remote_as] = 64512
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

### Static Route Example

The following example will create a static route to 10.0.0.0/24 using the next hop of 172.16.1.1

```ruby
node.set[:quagga][:static_routes]['10.0.0.0/24'] = '172.16.1.1'

include_recipe 'quagga::zebra'
```
### Mutliple Routing-Instaces (VRFs) Example

The following example will create a routing table with a static route, a bgp neighbor and a specific interface all on table 100.  

```ruby
node.set[:quagga][:multiple_instance] = true
node.set[:quagga][:interfaces]['swp1 table 100'] = []
node.set[:quagga][:bgp]['64512 table 100'][:neighbors]['1.1.1.1'][:remote_as] = 64512
node.set[:quagga][:static_routes]['10.0.0.0/24'] = '172.16.1.1 table 100'
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
* Docker

To run the tests (after installing prerequisites):
* `bundle install`
* `rake rubocop`
* `bundle exec rake integration:vagrant` #Vagrant Tests
* `bundle exec rake integration:docker` #Docker Tests
* `foodcritic .`

Author and License
===================
### Maintainer, Authors and Contributors


| Role			| Individual
|:----------------------|:-----------------------------------------|
| **Author** (pre-0.2)  | [Ooyala Inc.](https://github.com/ooyala)
| **Maintainer** (0.2+) | [Ian Clark](https://github.com/floored1585)
| **Contributor**       | [James Farr](https://github.com/nertwork)

Copyright 2014, Ooyala Inc.  
Copyright 2015, Contributers

### License

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
