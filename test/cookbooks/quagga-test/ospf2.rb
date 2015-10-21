#
# Cookbook Name:: quagga-test
# Recipe:: ospf
#
# Copyright 2015, Ian Clark
#

node.set[:quagga] = {
  router_id: '127.0.0.1',
  integrated_vtysh_config: true,
  ospf: {
    passive_ints: [ "pas_1", "pas_2" ],
    areas: {
      '0.0.0.1' => {
        networks: [ '10.0.0.0/8', '192.168.0.0/16' ]
      }
    }
  }
}

include_recipe 'quagga::ospfd'
