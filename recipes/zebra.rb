#
# Cookbook Name:: quagga
# Recipe:: zebra
#

include_recipe 'quagga'

config_zebra = true unless
  node.quagga.prefix_lists.empty? &&
  node.quagga.interfaces.empty? &&
  node.quagga.static_routes.empty?

if config_zebra
  quagga_zebra 'zebra' do
    interfaces node.quagga.interfaces
    static_routes node.quagga.static_routes
    prefix_lists node.quagga.prefix_lists
  end
end
