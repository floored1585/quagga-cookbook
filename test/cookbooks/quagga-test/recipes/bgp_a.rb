#
# Cookbook Name:: quagga-test
# Recipe:: bgp_a
#

node.set[:quagga][:bgp]['64512'][:log_neighbor_changes] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:remote_as] = 64512
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:default_originate] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group_range] = '10.0.0.0/8'
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:remote_as] = 23456
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:default_originate] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:default_originate_map] = 'do_map'

include_recipe 'quagga::bgpd'
