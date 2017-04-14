#
# Author:: Bao Nguyen <opensource-cookbooks@ooyala.com>
# Current Maintainer:: Ian Clark <ian@f85.net>
# Cookbook Name:: quagga
# Provider:: zebra
#
# Copyright 2014, Ooyala
# Copyright 2015, Ian Clark
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :add do
  integrated_config = node['quagga']['integrated_vtysh_config']

  zebra_path = "#{node['quagga']['dir']}/zebra.conf"
  Chef::Log.info "Adding #{new_resource.name}: interface to #{zebra_path}"

  template zebra_path do
    cookbook 'quagga'
    source 'zebra.conf.erb'
    owner node['quagga']['user']
    group node['quagga']['group']
    mode '0644'
    variables(
      interfaces: node['quagga']['interfaces'],
      static_routes: node['quagga']['static_routes'],
      prefix_lists: node['quagga']['prefix_lists'],
      route_maps: node['quagga']['route_maps']
    )
    if integrated_config
      notifies :create, 'template[integrated_config]', :delayed
    else
      notifies :restart, 'service[quagga]', :delayed
    end
  end
end

action :remove do
  zebra_path = "#{node['quagga']['dir']}/#{new_resource.name}"
  if ::File.exist?(zebra_path)
    Chef::Log.info "Removing #{new_resource.file_type}: interface from #{zebra_path}"
    file zebra_path do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end
