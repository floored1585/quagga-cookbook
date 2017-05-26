require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

describe file("#{cfg_dir}/ospf6d.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/ospf6d.conf") do
  its(:content) { should contain('router ospf6') }
  its(:content) { should contain('router-id 127.0.0.1') }
  its(:content) { should contain('redistribute static') }
  its(:content) { should contain('auto-cost reference-bandwidth 100000') }
  its(:content) { should contain('interface swp1 area 0.0.0.1') }
  its(:content) { should contain('interface swp2 area 0.0.0.1') }
  its(:content) { should contain('interface swp4 area 1.1.1.1') }
  its(:content) { should contain('interface swp5 area 1.1.1.1') }
  its(:content) { should contain('area 2.2.2.2 stub') }
end

describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/ospf6d.conf")) }
end
