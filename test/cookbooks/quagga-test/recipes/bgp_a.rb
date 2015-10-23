#
# Cookbook Name:: quagga-test
# Recipe:: bgp_a
#

node.set[:quagga][:bgp]['64512'][:log_neighbor_changes] = true
node.set[:quagga][:bgp]['64512'][:redistribute] = 'static'
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:remote_as] = 64512
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:default_originate] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['hosts'][:peer_group_range] = '10.0.0.0/8'
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:remote_as] = 23456
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:default_originate] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:default_originate_map] = 'do_map'
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:soft_reconfig_in] = true
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:prefix_list_in] = "TEST_IN"
node.set[:quagga][:bgp]['64512'][:neighbors]['192.168.52.1'][:prefix_list_out] = "TEST_OUT"
node.set[:quagga][:bgp][:prefix_lists][:TEST_IN]['10'][:action] = "permit"
node.set[:quagga][:bgp][:prefix_lists][:TEST_OUT]['10'][:action] = "deny"

include_recipe 'quagga::bgpd'
