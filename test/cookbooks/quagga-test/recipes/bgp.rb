#
# Cookbook Name:: cumulus-test
# Recipe:: ports
#
# Copyright 2015, Cumulus Networks
#
# All rights reserved - Do Not Redistribute
#

cumulus_ports 'speeds' do
  speed_10g ['swp1']
  speed_40g ['swp3','swp5-10', 'swp12']
  speed_40g_div_4 ['swp15','swp16']
  speed_4_by_10g ['swp20-32']
end
