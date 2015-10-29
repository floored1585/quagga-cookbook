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
  its(:content) { should contain('ip route 10.0.0.0/24 172.16.1.1') }
end

describe file("#{cfg_dir}/Quagga.conf") do
  its(:content) { should include(File.read("#{cfg_dir}/bgpd.conf")) }
end
