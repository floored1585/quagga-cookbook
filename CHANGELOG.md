## 0.4.2 (2017-08-04)

Breaking:

  - Removed `ipv6 = true` support for BGP neighbors and changed how address-family is handled.  See README for details.

## 0.3.14 (unreleased)

Features:

  - Added support for: (@robbat2)
    - capability
    - ebgp-multihop
    - local-as
    - neighbor N route-map RM export
    - neighbor N route-map RM import
    - address-family F neighbor N route-map RM ...
    - address-family F neighbor N prefix-list PL ...
  - Easier to use neighbor properties within a specific address-family (@robbat2)
  - Improved test coverage for existing code.

Bugfixes:

  - (POTENTIALLY BREAKING CHANGE) peer-group membership needs to be re-applied
	to peer inside each address-family, otherwise any peer-group properties in
	that address-family scope are not used (@robbat2).

## 0.3.13 (2017-06-20)

Features

  - Added in support for aggregate-address (@robbat2)
  - Added in support for neighbor description, next-hop-self, peer-group member (@robbat2)

## 0.3.10 (2017-05-26)

Features:

  - Added in support for ospf and ospf6 stub areas (@nertwork)
  - Added in support for ospf and ospf6 reference bandwidth (@nertwork)

## 0.3.9 (2017-05-15)

Features:

  - Used default attribute scope for daemons (@robbat2)

## 0.3.8 (2017-05-09)

Features:

  - Added in support for bgp compare router-id (@nertwork)

## 0.3.7 (2017-04-28)

Features:

  - Added in support for bgp multipath-relax (@nertwork)

## 0.3.6 (2017-04-25)

Features:

  - Added in support for multi-path bgp for different address-family routes (@nertwork)

## 0.3.5 (2017-04-13)

Features:

  - Added in support for ipv6 bgp and static routes (@nertwork)

## 0.3.4 (2017-02-01)

No changes made just version bump

## 0.3.3 (2017-02-01)

Features:

  - Added in support for ospf3 or ospfv6 (@nertwork)

## 0.3.2 (2016-07-11)

Features:

  - Added in support BGP connect_timer (@fzylogic)

## 0.3.1 (2016-05-18)

Bugfixes:

  - Fixing route_map bug (@nertwork)

## 0.3.0 (2016-05-18)

Features:

  - Added in support for Travis CI Testing (@nertwork)

  - Added in support for route-mapping (@nertwork)

  - Added in support for CodeClimate (@nertwork)

Bugfixes:

  - Some code cleanup (@nertwork)

## 0.2.10 (2016-04-20)

No changes made, just a version bump

## 0.2.9 (2016-04-15)

Bugfixes:

  - fix issues with override attributes and the LWRPs (removed new_resource attribute passing)

## 0.2.8 (2016-02-22)

Features:

  - add global BGP timer attributes (@floored1585)

## 0.2.7 (2016-02-18)

Features:

  - add BGP maximum-paths support (@floored1585)

## 0.2.6 (2016-02-17)

Bugfixes:

  - fix multiple lint issues / improve code consistency (@floored1585)

## 0.2.4 (2015-11-04)

Features:

  - add Ubuntu 14.04 platform testing (@floored1585)

Bugfixes:

  - remove duplicate service in recipies/default.rb (@floored1585)

## 0.2.3 (2015-11-02)

Features:

  - add multiple instance support for BGP (@nertwork)
  - add static route tests (@nertwork)
  - add route redistribution support for OSPF (@floored1585)
  - add prefix list support (@floored1585)
  
Bugfixes:

  - fix style issues (@floored1585)
