#
# Cookbook Name:: quagga-test
# Recipe:: bgp_b
#

node.set['quagga']['bgp']['64512']['router_id'] = '1.1.1.1'
node.set['quagga']['bgp']['64512']['hold_time'] = '30'
node.set['quagga']['bgp']['64512']['redistribute'] = ['connected', 'ospf']
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['remote_as'] = 64512
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['peer_group'] = true
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['peer_group_range'] = ['10.0.0.0/8', '192.168.0.0/16']
node.set['quagga']['bgp']['64512']['address_family']['ipv6']['max_paths'] = 5

include_recipe 'quagga::bgpd'
