#
# Cookbook Name:: quagga-test
# Recipe:: bgp_a
#

node.set['quagga']['bgp']['64512']['log_neighbor_changes'] = true
node.set['quagga']['bgp']['64512']['redistribute'] = 'static'
node.set['quagga']['bgp']['64512']['multipath_relax'] = true
node.set['quagga']['bgp']['64512']['compare_routerid'] = true
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['remote_as'] = 64512
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['default_originate'] = true
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['peer_group'] = true
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['peer_group_range'] = '10.0.0.0/8'
node.set['quagga']['bgp']['64512']['neighbors']['swp1']['peer_type'] = 'interface'
node.set['quagga']['bgp']['64512']['neighbors']['swp1']['remote_as'] = 64511
node.set['quagga']['bgp']['64512']['neighbors']['swp1']['soft_reconfig_in'] = true
node.set['quagga']['bgp']['64512']['neighbors']['swp1']['ipv6'] = true
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['remote_as'] = 23456
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['default_originate'] = true
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['default_originate_map'] = 'do_map'
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['soft_reconfig_in'] = true
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['prefix_list_in'] = "TEST_IN"
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['prefix_list_out'] = "TEST_OUT"
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['route_map_in'] = "TEST_IN"
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['route_map_out'] = "TEST_OUT"
node.set['quagga']['bgp']['64512']['neighbors']['192.168.52.1']['connect_timer'] = "5"
node.set['quagga']['bgp']['64512']['neighbors']['hosts_v6']['remote_as'] = 1111
node.set['quagga']['bgp']['64512']['neighbors']['hosts_v6']['default_originate_v6'] = true
node.set['quagga']['bgp']['64512']['neighbors']['hosts_v6']['peer_type'] = 'peer-group'
node.set['quagga']['bgp']['64512']['neighbors']['hosts_v6']['prefix_list_in_v6'] = "TEST_IN_V6"
node.set['quagga']['bgp']['64512']['neighbors']['hosts_v6']['prefix_list_out_v6'] = "TEST_OUT_V6"
node.set['quagga']['bgp']['64512']['neighbors']['hosts_v6']['peer_group_range'] = ['2600::/64', '1000:1::/64']
node.set['quagga']['bgp']['64512']['max_paths'] = 5
node.set['quagga']['bgp']['64512']['keepalive_interval'] = 10
node.set['quagga']['bgp']['64512']['hold_time'] = 30
node.set['quagga']['bgp']['64512']['address_family']['ipv6']['redistribute'] = "connected"

include_recipe 'quagga::bgpd'
