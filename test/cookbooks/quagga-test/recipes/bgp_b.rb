#
# Cookbook Name:: quagga-test
# Recipe:: bgp_b
#

node.set[:quagga][:bgp]['64512'][:router_id] = '1.1.1.1'
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:remote_as] = 64512
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group_range] = '10.0.0.0/8'

include_recipe 'quagga::bgpd'
