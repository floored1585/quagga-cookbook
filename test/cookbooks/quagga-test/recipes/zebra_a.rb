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
node.set[:quagga][:route_maps][:MAP_A1]['10'][:action] = 'permit'
node.set[:quagga][:route_maps][:MAP_A1]['10']['set'][:aggregator][:as] = 1234
node.set[:quagga][:route_maps][:MAP_A1]['10']['set'][:aggregator][:ip] = '12.34.56.78'
node.set[:quagga][:route_maps][:MAP_A1]['10']['set'][:local_preference] = 100
node.set[:quagga][:route_maps][:MAP_A1]['20'][:action] = 'deny'
node.set[:quagga][:route_maps][:MAP_A2]['5'][:action] = 'permit'
node.set[:quagga][:route_maps][:MAP_A2]['5']['set'][:local_preference] = 100
node.set[:quagga][:interfaces]['test1']['no ipv6 nd suppress-ra']
node.set[:quagga][:interfaces]['test2']['ipv6 ospf6 passive']
node.set[:quagga][:interfaces]['test3']['ipv6 ospf6 network point-to-point']
node.set[:quagga][:interfaces]['test4'] = []
node.set[:quagga][:static_routes]['10.0.0.0/24'] = '172.16.1.1'
node.set[:quagga][:static_routes]['10.0.0.0/24'] = '172.16.1.1 table 12'

include_recipe 'quagga::zebra'
