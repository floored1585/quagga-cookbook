#
# Original Author:: Bao Nguyen <opensource-cookbooks@ooyala.com>
# Current Maintainer:: Ian Clark <ian@f85.net>
# Cookbook Name:: quagga
# Provider:: bgp
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

  # This allows us to iterate through address_family to catch all the neighbor options instead
  # of having to repeat everything for ipv6.
  node['quagga']['bgp'].keys.each do |asn|
    node.default['quagga']['bgp'][asn]['address_family']['ipv4 unicast'] = node['quagga']['bgp'][asn]
  end

  bgpd_path = "#{node['quagga']['dir']}/bgpd.conf"
  Chef::Log.info "Adding #{new_resource.name}: acl to #{bgpd_path}"

  template bgpd_path do
    cookbook 'quagga'
    source 'bgpd.conf.erb'
    owner node['quagga']['user']
    group node['quagga']['group']
    mode '0644'
    variables(
      local_asns: node['quagga']['bgp']
    )
    if integrated_config
      notifies :create, 'template[integrated_config]', :delayed
    else
      notifies :restart, 'service[quagga]', :delayed
    end
  end
end

action :remove do
  bgpd_path = "#{node['quagga']['dir']}/#{new_resource.name}"
  if ::File.exist?(bgpd_path)
    Chef::Log.info "Removing #{new_resource.file_type}: bgp from #{bgpd_path}"
    file bgpd_path do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end
