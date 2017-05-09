require 'serverspec'

set :backend, :exec
set :path, '/bin:/usr/bin:/sbin/usr/sbin'

cfg_dir = File.join('', 'etc', 'quagga')

# The recipe should have created the .d directory
describe file(cfg_dir) do
  it { should be_directory }
end

describe file('/etc/default/quagga') do
  it { should be_file }
end

describe file("#{cfg_dir}/vtysh.conf") do
  it { should be_file }
end

describe file('/etc/default/quagga') do
  its(:content) { should contain('MAX_INSTANCES=5') }
end
describe file('/etc/default/quagga'), unless: os[:family] == 'ubuntu' do
  its(:content) { should contain('ENABLE_RELOAD=yes') }
end

describe file("#{cfg_dir}/vtysh.conf") do
  its(:content) { should contain('service integrated-vtysh-config') }
  its(:content) { should contain('bgp multiple-instance') }
  its(:content) { should contain('hostname') }
  its(:content) { should contain('username root nopassword') }
  its(:content) { should contain('enable password quagga') }
  its(:content) { should contain('password quagga') }
  its(:content) { should contain('log file /var/log/quagga/vtysh.log') }
end

describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/zebra.conf")) }
  its(:content) { should include(File.read("#{cfg_dir}/vtysh.conf")) }
end
