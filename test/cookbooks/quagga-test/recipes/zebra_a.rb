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
node.set[:quagga][:prefix_lists][:LIST_A2]['5'][:ge] = 8
node.set[:quagga][:prefix_lists][:LIST_A2]['5'][:action] = 'deny'

include_recipe 'quagga::zebra'
