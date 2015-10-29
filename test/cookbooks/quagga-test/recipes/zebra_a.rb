#
# Cookbook Name:: quagga-test
# Recipe:: zebra_a
#

node.set[:quagga][:prefix_lists][:LIST_A1]['10'][:prefix] = '172.18.0.0/24'
node.set[:quagga][:prefix_lists][:LIST_A1]['10'][:action] = 'permit'
node.set[:quagga][:prefix_lists][:LIST_A1]['10'][:ge] = 24
node.set[:quagga][:prefix_lists][:LIST_A1]['10'][:le] = 30
node.set[:quagga][:prefix_lists][:LIST_A1]['10'][:action] = 'permit'
node.set[:quagga][:prefix_lists][:LIST_A1]['20'][:action] = 'deny'
node.set[:quagga][:static_routes]['10.0.0.0/24'] = '172.16.1.1'
node.set[:quagga][:static_routes]['10.0.0.0/24'] = '172.16.1.1 table 12'

include_recipe 'quagga::zebra'
