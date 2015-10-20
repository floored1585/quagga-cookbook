#
# Author:: Bao Nguyen <ngqbao@gmail.com>
# Cookbook Name:: quagga
# Recipe:: ospfd
#
# Copyright 2014, Bao Nguyen
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

include_recipe 'quagga'

node.set[:quagga][:daemons][:ospfd] = true

unless node.quagga.ospf.area.empty?
  quagga_ospf "#{node.quagga.ospf.area}" do
    ospf = node.quagga['ospf']
    router_id ospf['router_id']
    networks ospf['networks']
    protocols ospf['protocols']
    interfaces ospf['interfaces']
    passive_ints ospf['passive_ints']
    passive_default ospf['passive_default']
  end
end
