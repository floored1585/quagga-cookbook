require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

describe file("#{cfg_dir}/ospfd.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/ospfd.conf") do
  its(:content) { should contain('router ospf') }
  its(:content) { should contain('redistribute bgp') }
  its(:content) { should contain('redistribute isis') }
  its(:content) { should_not contain('redistribute test') }
  its(:content) { should contain('ospf router-id 1.2.3.4') }
  its(:content) { should contain('passive-interface pas_3') }
  its(:content) { should contain('network 172.16.0.0/12 area 4.3.2.1') }
end
