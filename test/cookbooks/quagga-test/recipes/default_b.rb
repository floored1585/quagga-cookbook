#
# Cookbook Name:: quagga-test
# Recipe:: default_b
#

node.set['quagga']['router_id'] = '127.0.0.1'
node.set['quagga']['enable_reload'] = false
node.set['quagga']['max_instances'] = 10

include_recipe "quagga-test::ospf_b"
include_recipe "quagga-test::bgp_b"
