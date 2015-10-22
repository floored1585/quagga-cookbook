require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

describe file("#{cfg_dir}/bgpd.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/bgpd.conf") do
  its(:content) { should contain('router bgp 64512') }
  its(:content) { should contain('bgp log-neighbor-changes') }
  its(:content) { should contain('bgp router-id 127.0.0.1') }
  its(:content) { should contain('neighbor hosts peer-group') }
  its(:content) { should contain('neighbor hosts remote-as 64512') }
  its(:content) { should contain('neighbor hosts default-originate') }
  its(:content) { should contain('bgp listen range 10.0.0.0/8 peer-group hosts') }
  its(:content) { should contain('neighbor 192.168.52.1 default-originate route-map do_map') }
end

describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/bgpd.conf")) }
end
