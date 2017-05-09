#
# Cookbook Name:: quagga-test
# Recipe:: ospf_b
#

node.set['quagga']['ospf']['router_id'] = '1.2.3.4'
node.set['quagga']['ospf']['redistribute'] = ['bgp', 'isis', 'test']
node.set['quagga']['ospf']['passive_ints'] = 'pas_3'
node.set['quagga']['ospf']['areas']['4.3.2.1']['networks'] = '172.16.0.0/12'

include_recipe 'quagga::ospfd'
