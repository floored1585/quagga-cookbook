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

  its(:content) { should contain("neighbor hosts peer-group").before("peer-group hosts") }
  its(:content) { should contain("neighbor hosts remote-as 64512") }
  its(:content) { should contain("neighbor hosts default-originate").after(/neighbor hosts (peer-group$|remote-as|interface)/) }
  its(:content) { should contain("bgp listen range 10.0.0.0/8 peer-group hosts").after("neighbor hosts peer-group") }

  its(:content) { should contain("neighbor swp1 interface") }
  its(:content) { should contain("neighbor swp1 remote-as 64511") }
  its(:content) { should contain("neighbor swp1 local-as 12345").after(/neighbor swp1 (peer-group$|remote-as|interface)/).before('address-family ipv6') }
  its(:content) { should contain("neighbor swp1 soft-reconfiguration inbound").after(/neighbor swp1 (peer-group$|remote-as|interface)/).after('address-family ipv6') }
  its(:content) { should contain("neighbor swp1 capability dynamic").after(/neighbor swp1 (peer-group$|remote-as|interface)/).before('address-family ipv6') }
  its(:content) { should contain("neighbor swp1 capability extended-nexthop").after(/neighbor swp1 (peer-group$|remote-as|interface)/).before('address-family ipv6') }
  its(:content) { should contain("neighbor swp1 next-hop-self").after(/neighbor swp1 (peer-group$|remote-as|interface)/).after('address-family ipv6') }
  its(:content) { should contain("neighbor swp1 activate").after('address-family ipv6') }

  its(:content) { should contain("neighbor 192.168.52.1 remote-as 23456") }
  its(:content) { should contain("neighbor 192.168.52.1 default-originate route-map do_map").after(/neighbor 192.168.52.1 (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain("neighbor 192.168.52.1 soft-reconfiguration inbound").after(/neighbor 192.168.52.1 (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain("neighbor 192.168.52.1 prefix-list TEST_IN in").after(/neighbor 192.168.52.1 (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain("neighbor 192.168.52.1 prefix-list TEST_OUT out").after(/neighbor 192.168.52.1 (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain("neighbor 192.168.52.1 route-map TEST_IN in").after(/neighbor 192.168.52.1 (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain("neighbor 192.168.52.1 route-map TEST_OUT out").after(/neighbor 192.168.52.1 (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain("neighbor 192.168.52.1 timers connect 5").after(/neighbor 192.168.52.1 (peer-group\s+\S+|remote-as|interface)/) }

  its(:content) { should contain("neighbor 192.168.99.1 peer-group hosts") }
  its(:content) { should contain("neighbor 192.168.99.1 description peer-group-test-peer").after(/neighbor 192.168.99.1 (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain(%r{neighbor 192.168.99.1 default-originate\s*$}) }

  its(:content) { should contain("neighbor hosts_v6 peer-group").before("peer-group hosts_v6") }
  its(:content) { should contain("neighbor hosts_v6 activate") }
  its(:content) { should contain("neighbor hosts_v6 remote-as 1111") }
  its(:content) { should contain("neighbor hosts_v6 prefix-list TEST_IN_V6 in").after(/address-family ipv6/) }
  its(:content) { should contain("neighbor hosts_v6 prefix-list TEST_OUT_V6 out").after(/address-family ipv6/) }
  its(:content) { should contain("bgp listen range 2600::/64 peer-group hosts_v6").after(/neighbor hosts_v6 peer-group\s*$/).before(/address-family ipv6/) }
  its(:content) { should contain("bgp listen range 1000:1::/64 peer-group hosts_v6").after(/neighbor hosts_v6 peer-group\s*$/).before(/address-family ipv6/) }

  its(:content) { should contain("neighbor 2001:db8::abcd peer-group hosts_v6").after('hosts_v6 peer-group').before('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::abcd activate").after('address-family ipv6').after(/neighbor 2001:db8::abcd (peer-group\s+\S+|remote-as|interface)/) }
  its(:content) { should contain("neighbor 2001:db8::abcd description IPV6 DOC").after(/neighbor 2001:db8::abcd (peer-group\s+\S+|remote-as|interface)/).before('address-family ipv6') }

  its(:content) { should contain("neighbor 2001:db8::dead ebgp-multihop 5").before('address-family ipv6') }
  # 2001:db8::dead has lots of entries that are for the v6 mode only.
  its(:content) { should contain("neighbor 2001:db8::dead soft-reconfiguration inbound").after('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::dead capability orf prefix-list both").after('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::dead prefix-list TEST_IN_V6 in").after('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::dead prefix-list TEST_OUT_V6 out").after('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::dead route-map TEST_IN_V6 in").after('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::dead route-map TEST_OUT_V6 out").after('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::dead route-map TEST_IMPORT_V6 import").after('address-family ipv6') }
  its(:content) { should contain("neighbor 2001:db8::dead route-map TEST_EXPORT_V6 export").after('address-family ipv6') }

  its(:content) { should contain('aggregate-address 100::/64') }
  its(:content) { should match %r{aggregate-address 100::/64\s*$} }
  its(:content) { should contain('aggregate-address 200::/64 summary-only') }
  its(:content) { should contain('maximum-paths 5').before('address-family ipv6') }
  its(:content) { should contain('maximum-paths 9').after('address-family ipv6') }
  its(:content) { should contain('timers bgp 10 30') }
  its(:content) { should contain('address-family ipv6') }
end

describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/bgpd.conf")) }
end
