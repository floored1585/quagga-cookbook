require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

describe file("#{cfg_dir}/ospfd.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/ospfd.conf") do
  its(:content) { should contain('router ospf') }
  its(:content) { should contain('ospf router-id 127.0.0.1') }
  its(:content) { should contain('redistribute static') }
  its(:content) { should contain('auto-cost reference-bandwidth 1000') }
  its(:content) { should contain('network 192.168.0.0/16 area 0.0.0.1') }
  its(:content) { should contain('network 10.0.0.0/8 area 0.0.0.1') }
  its(:content) { should contain('network 172.16.0.0/12 area 1.1.1.1') }
  its(:content) { should contain('passive-interface pas_1') }
  its(:content) { should contain('passive-interface pas_2') }
  its(:content) { should contain('area 2.2.2.2 stub') }
end
describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/ospfd.conf")) }
end
