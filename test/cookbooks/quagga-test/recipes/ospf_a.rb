#
# Cookbook Name:: quagga-test
# Recipe:: ospf_a
#

node.set['quagga']['ospf']['passive_ints'] = ["pas_1", "pas_2"]
node.set['quagga']['ospf']['redistribute'] = "static"
node.set['quagga']['ospf']['reference_bandwidth'] = 1000
node.set['quagga']['ospf']['areas']['0.0.0.1']['networks'] = ['10.0.0.0/8', '192.168.0.0/16']
node.set['quagga']['ospf']['areas']['1.1.1.1']['networks'] = '172.16.0.0/12'
node.set['quagga']['ospf']['areas']['2.2.2.2']['stub_area'] = true

include_recipe 'quagga::ospfd'
