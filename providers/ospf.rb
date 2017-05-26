#
# Original Author:: Bao Nguyen <opensource-cookbooks@ooyala.com>
# Current Maintainer:: Ian Clark <ian@f85.net>
# Cookbook Name:: quagga
# Provider:: ospf
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

  ospfd_path = "#{node['quagga']['dir']}/ospfd.conf"
  Chef::Log.info "Adding #{new_resource.name}: ospf to #{ospfd_path}"

  template ospfd_path do
    cookbook 'quagga'
    source 'ospfd.conf.erb'
    owner node['quagga']['user']
    group node['quagga']['group']
    mode '0644'
    variables(
      areas: node['quagga']['ospf']['areas'],
      reference_bandwidth: node['quagga']['ospf']['reference_bandwidth'] || node['quagga']['reference_bandwidth'],
      router_id: node['quagga']['ospf']['router_id'] || node['quagga']['router_id'],
      interfaces: node['quagga']['ospf']['interfaces'],
      passive_ints: node['quagga']['ospf']['passive_ints'],
      redistribute: node['quagga']['ospf']['redistribute'],
      passive_default: node['quagga']['ospf']['passive_default']
    )
    if integrated_config
      notifies :create, 'template[integrated_config]', :delayed
    else
      notifies :restart, 'service[quagga]', :delayed
    end
  end
end

action :remove do
  ospfd_path = "#{node['quagga']['dir']}/ospfd.conf"
  if ::File.exist?(ospfd_path)
    Chef::Log.info "Removing #{new_resource.file_type}: ospf from #{ospfd_path}"
    file ospfd_path do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end
