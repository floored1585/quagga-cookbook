#
# Original Author:: Bao Nguyen <ngqbao@gmail.com>
# Current Maintainer:: Ian Clark <ian@f85.net>
#
# Copyright 2014, Bao Nguyen
# Copyright 2015, Ian Clark
# Copyright 2017, Robin H. Johnson <robbat2@gentoo.org>
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

# This provides consistent ordering for BGP neighbors.
def sort_by_bgp_neighbor(hashelem)
  key, value = hashelem
  # Newer way to use peer-group
  is_peer_group = value.include?('peer_group') && value['peer_group'].is_a?(TrueClass)
  # Older, but should not break those user configurations.
  is_peer_group |= value.include?('peer_type') && value['peer_type'] == 'peer-group'
  # 0 comes before 1.
  [is_peer_group ? 0 : 1, key, value]
end
