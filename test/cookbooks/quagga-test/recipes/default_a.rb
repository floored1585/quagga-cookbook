#
# Cookbook Name:: quagga-test
# Recipe:: default_a
#

node.set['quagga']['router_id'] = '127.0.0.1'
node.set['quagga']['integrated_vtysh_config'] = true
node.set['quagga']['multiple_instance'] = true

include_recipe "quagga-test::ospf_a"
include_recipe "quagga-test::ospf6_a"
include_recipe "quagga-test::bgp_a"
include_recipe "quagga-test::zebra_a"
