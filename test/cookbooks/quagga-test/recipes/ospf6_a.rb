#
# Cookbook Name:: quagga-test
# Recipe:: ospf6_a
#

node.set[:quagga][:ospf6][:redistribute] = ["static"]
node.set[:quagga][:ospf6][:router_id] = "127.0.0.1"
node.set[:quagga][:ospf6][:areas]['0.0.0.1'][:interfaces] = {'spw1', 'swp2'}
node.set[:quagga][:ospf6][:areas]['1.1.1.1'][:interfaces] = {'swp4', 'swp5'}

include_recipe 'quagga::ospf6d'
