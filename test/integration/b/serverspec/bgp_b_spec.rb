require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

describe file("#{cfg_dir}/bgpd.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/bgpd.conf") do
  its(:content) { should contain('router bgp 64512') }
  its(:content) { should contain('redistribute connected') }
  its(:content) { should contain('redistribute ospf') }
  its(:content) { should contain('bgp router-id 1.1.1.1') }
  its(:content) { should contain('neighbor hosts peer-group') }
  its(:content) { should contain('neighbor hosts remote-as 64512') }
  its(:content) { should contain('bgp listen range 10.0.0.0/8 peer-group hosts') }
  its(:content) { should contain('bgp listen range 192.168.0.0/16 peer-group hosts') }
  its(:content) { should_not contain('neighbor hosts default-originate') }
  its(:content) { should_not contain('timers') }
  its(:content) { should contain('address-family ipv6') }
  its(:content) { should contain('maximum-paths 5') }
end
