#
# Cookbook Name:: quagga-test
# Recipe:: bgp_c
#

node.set['quagga']['bgp']['64512']['router_id'] = '1.1.1.1'
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['remote_as'] = 64512
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['peer_type'] = 'peer-group'
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['ipv6'] = true
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['default_originate_v6'] = true
node.set['quagga']['bgp']['64512']['neighbors']['hosts']['peer_group_range'] = ['2600::/64', '1000:1::/64']
node.set['quagga']['bgp']['64512']['address_family']['ipv6'] = {}

include_recipe 'quagga::bgpd'
