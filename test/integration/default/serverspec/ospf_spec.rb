require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

# The recipe should have created the .d directory
describe file(cfg_dir) do
  it { should be_directory }
end

# Should exist
describe file("/etc/default/quagga") do
  it { should be_file }
end
describe file("#{cfg_dir}/ospfd.conf") do
  it { should be_file }
end

describe file("#{cfg_dir}/ospfd.conf") do
  its(:content) { should match(/router ospf/) }
  its(:content) { should match(/ospf router-id 127\.0\.0\.1/) }
  its(:content) { should match(/network 192.168.0.0\/16/) }
  its(:content) { should match(/passive-interface pas_1/) }
  its(:content) { should match(/passive-interface pas_2/) }
end
