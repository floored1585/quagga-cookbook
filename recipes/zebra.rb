#
# Cookbook Name:: quagga
# Recipe:: zebra
#

include_recipe 'quagga'

quagga_zebra 'zebra' do
  not_if { node['quagga']['prefix_lists'].empty? &&
         node['quagga']['interfaces'].empty? &&
         node['quagga']['static_routes'].empty? }
end
