#
# Original Author:: Bao Nguyen <ngqbao@gmail.com>
# Current Maintainer:: Ian Clark <ian@f85.net>
# Cookbook Name:: quagga
# Recipe:: ospfd
#
# Copyright 2014, Bao Nguyen
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

node.default['quagga']['daemons']['ospfd'] = true

include_recipe 'quagga'

quagga_ospf 'ospf' do
  not_if { node['quagga']['ospf']['areas'].empty? }
end
