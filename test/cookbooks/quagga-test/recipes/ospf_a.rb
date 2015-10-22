#
# Cookbook Name:: quagga-test
# Recipe:: ospf_a
#

node.set[:quagga][:ospf][:passive_ints] = ["pas_1", "pas_2"]
node.set[:quagga][:ospf][:areas]['0.0.0.1'][:networks] = ['10.0.0.0/8', '192.168.0.0/16']

include_recipe 'quagga::ospfd'
