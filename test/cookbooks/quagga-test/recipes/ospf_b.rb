#
# Cookbook Name:: quagga-test
# Recipe:: ospf
#
# Copyright 2015, Ian Clark
#

node.set[:quagga] = {
  enable_reload: false,
  max_instances: 10,
  router_id: '127.0.0.1',
  ospf: {
    router_id: '1.2.3.4',
    areas: {
      '4.3.2.1' => {
        networks: [ '172.16.0.0/12' ]
      }
    }
  }
}

include_recipe 'quagga::ospfd'
