#
# Cookbook Name:: quagga-test
# Recipe:: zebra_a
#

node.set['quagga']['prefix_lists']['LIST_A1']['10']['prefix'] = '172.18.0.0/24'
node.set['quagga']['prefix_lists']['LIST_A1']['10']['action'] = 'permit'
node.set['quagga']['prefix_lists']['LIST_A1']['10']['ge'] = 24
node.set['quagga']['prefix_lists']['LIST_A1']['10']['le'] = 30
node.set['quagga']['prefix_lists']['LIST_A1']['10']['action'] = 'permit'
node.set['quagga']['prefix_lists']['LIST_A1']['20']['action'] = 'deny'
node.set['quagga']['prefix_lists']['LIST_A2']['5']['ge'] = 8
node.set['quagga']['prefix_lists']['LIST_A2']['5']['action'] = 'deny'
node.set['quagga']['prefix_lists']['LIST_A3']['15']['prefix'] = '1::1/64'
node.set['quagga']['prefix_lists']['LIST_A3']['15']['ge'] = 128
node.set['quagga']['prefix_lists']['LIST_A3']['15']['action'] = 'permit'
node.set['quagga']['prefix_lists']['LIST_A3']['25']['ge'] = 64
node.set['quagga']['prefix_lists']['LIST_A3']['25']['prefix'] = 'any_v6'
node.set['quagga']['prefix_lists']['LIST_A3']['25']['action'] = 'deny'
node.set['quagga']['route_maps']['MAP_A1']['10']['action'] = 'permit'
node.set['quagga']['route_maps']['MAP_A1']['10']['set']['aggregator']['as'] = 1234
node.set['quagga']['route_maps']['MAP_A1']['10']['set']['aggregator']['ip'] = '12.34.56.78'
node.set['quagga']['route_maps']['MAP_A1']['10']['set']['local_preference'] = 100
node.set['quagga']['route_maps']['MAP_A1']['20']['action'] = 'deny'
node.set['quagga']['route_maps']['MAP_A2']['5']['action'] = 'permit'
node.set['quagga']['route_maps']['MAP_A2']['5']['set']['local_preference'] = 100
node.set['quagga']['interfaces']['test1'] = ['no ipv6 nd suppress-ra']
node.set['quagga']['interfaces']['test2'] = ['ipv6 ospf6 passive']
node.set['quagga']['interfaces']['test3'] = ['ipv6 ospf6 network point-to-point']
node.set['quagga']['interfaces']['test4'] = []
node.set['quagga']['interfaces']['test5'] = {'no ipv6 nd suppress-ra' => true}
node.set['quagga']['interfaces']['test6'] = {'no ipv6 nd suppress-ra' => false}
node.set['quagga']['interfaces']['test7'] = {'ip address 192.168.1.1/32' => true}
node.set['quagga']['interfaces']['test8'] = {'ipv6 address 2001:db8::1/128' => true}
node.set['quagga']['interfaces']['test9'] = []
node.set['quagga']['static_routes']['10.0.0.0/24'] = '172.16.1.1'
node.set['quagga']['static_routes']['10.0.0.0/24'] = '172.16.1.1 table 12'
node.set['quagga']['static_routes']['1::1/128'] = 'lo'

include_recipe 'quagga::zebra'
