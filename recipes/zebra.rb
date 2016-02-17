#
# Cookbook Name:: quagga
# Recipe:: zebra
#

include_recipe 'quagga'

quagga_zebra 'zebra' do
  interfaces node['quagga']['interfaces']
  static_routes node['quagga']['static_routes']
  prefix_lists node['quagga']['prefix_lists']
  not_if node['quagga']['prefix_lists'].empty? &&
    node['quagga']['interfaces'].empty? &&
    node['quagga']['static_routes'].empty?
end
