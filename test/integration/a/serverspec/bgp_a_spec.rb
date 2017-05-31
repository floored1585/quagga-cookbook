require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

describe file("#{cfg_dir}/bgpd.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/bgpd.conf") do
  its(:content) { should contain('router bgp 64512') }
  its(:content) { should contain('redistribute static') }
  its(:content) { should contain('aggregate-address 10.0.0.0/8') }
  its(:content) { should match %r{aggregate-address 10\.0\.0\.0/8\s*$} }
  its(:content) { should contain('aggregate-address 192.168.0.0/16') }
  its(:content) { should contain('bgp log-neighbor-changes') }
  its(:content) { should contain('bgp bestpath as-path multipath-relax') }
  its(:content) { should contain('bgp bestpath compare-routerid') }
  its(:content) { should contain('bgp router-id 127.0.0.1') }
  its(:content) { should contain('neighbor hosts peer-group') }
  its(:content) { should contain('neighbor hosts remote-as 64512') }
  its(:content) { should contain('neighbor hosts default-originate') }
  its(:content) { should contain('bgp listen range 10.0.0.0/8 peer-group hosts') }
  its(:content) { should contain('neighbor swp1 interface') }
  its(:content) { should contain('neighbor swp1 remote-as 64511') }
  its(:content) { should contain('neighbor swp1 soft-reconfiguration inbound') }
  its(:content) { should contain('neighbor 192.168.52.1 default-originate route-map do_map') }
  its(:content) { should contain('neighbor 192.168.52.1 soft-reconfiguration inbound') }
  its(:content) { should contain('neighbor 192.168.52.1 prefix-list TEST_IN in') }
  its(:content) { should contain('neighbor 192.168.52.1 prefix-list TEST_OUT out') }
  its(:content) { should contain('neighbor 192.168.52.1 route-map TEST_IN in') }
  its(:content) { should contain('neighbor 192.168.52.1 route-map TEST_OUT out') }
  its(:content) { should contain('neighbor 192.168.52.1 timers connect 5') }
  its(:content) { should contain('neighbor hosts_v6 peer-group') }
  its(:content) { should contain('neighbor hosts_v6 remote-as 1111') }
  its(:content) { should contain('neighbor hosts_v6 prefix-list TEST_IN_V6 in') }
  its(:content) { should contain('neighbor hosts_v6 prefix-list TEST_OUT_V6 out') }
  its(:content) { should contain('aggregate-address 100::/64') }
  its(:content) { should match %r{aggregate-address 100::/64\s*$} }
  its(:content) { should contain('aggregate-address 200::/64 summary-only') }
  its(:content) { should contain('bgp listen range 2600::/64 peer-group hosts_v6') }
  its(:content) { should contain('bgp listen range 1000:1::/64 peer-group hosts_v6') }
  its(:content) { should contain('maximum-paths 5') }
  its(:content) { should contain('timers bgp 10 30') }
  its(:content) { should contain('address-family ipv6') }
  its(:content) { should contain('neighbor swp1 activate') }
end

describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/bgpd.conf")) }
end
