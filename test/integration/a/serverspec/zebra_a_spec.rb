require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

describe file("#{cfg_dir}/zebra.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/zebra.conf") do
  its(:content) { should contain('ip prefix-list LIST_A1 seq 10 permit 172.18.0.0/24 ge 24 le 30') }
  its(:content) { should contain('ip prefix-list LIST_A1 seq 20 deny any') }
  its(:content) { should contain('ip prefix-list LIST_A2 seq 5 deny any ge 8') }
  its(:content) { should contain('ipv6 prefix-list LIST_A3 seq 15 permit 1::1/64 ge 128') }
  its(:content) { should contain('ipv6 prefix-list LIST_A3 seq 25 deny any ge 64') }
  its(:content) { should contain('route-map MAP_A1 permit 10') }
  its(:content) { should contain('set aggregator as 1234 12.34.56.78') }
  its(:content) { should contain('set local-preference 100') }
  its(:content) { should contain('route-map MAP_A1 deny 20') }
  its(:content) { should contain('route-map MAP_A2 permit 5') }
  its(:content) { should match("interface test1\n no ipv6 nd suppress-ra") }
  its(:content) { should match("interface test2\n ipv6 ospf6 passive") }
  its(:content) { should match("interface test3\n ipv6 ospf6 network point-to-point") }
  its(:content) { should match("interface test4\n ipv6 nd suppress-ra") }
  its(:content) { should match("interface test5\n no ipv6 nd suppress-ra") }
  its(:content) { should match("interface test6\n ipv6 nd suppress-ra") }
  its(:content) { should match("interface test7\n ip address 192.168.1.1/32") }
  # Might have to watch out for order of items in this test in the future:
  its(:content) { should match("interface test8\n ipv6 address 2001:db8::1/128") }
  its(:content) { should match("interface test9\n ipv6 nd suppress-ra") }
  its(:content) { should contain('route-map MAP_A2 permit 5') }
  its(:content) { should contain('ip route 10.0.0.0/24 172.16.1.1') }
  its(:content) { should contain('ip route 10.0.0.0/24 172.16.1.1 table 12') }
  its(:content) { should contain('ipv6 route 1::1/128 lo') }
end

describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/bgpd.conf")) }
end
