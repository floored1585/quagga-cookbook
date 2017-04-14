#
# Author:: Bao Nguyen <opensource-cookbooks@ooyala.com>
# Cookbook Name:: quagga
# Resource:: interface
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

actions :add, :remove

default_action :add

# resources for interfaces
attribute :name, kind_of: String, name_attribute: true
attribute :interfaces, kind_of: Hash, default: {}
attribute :static_routes, kind_of: Hash, default: {}
attribute :prefix_lists, kind_of: Hash, default: {}
attribute :route_maps, kind_of: Hash, default: {}
attribute :set, kind_of: Hash, default: {}
