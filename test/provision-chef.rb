Vagrant.configure("2") do |config|
  config.vm.provision :shell, inline: "apt-get update && apt-get install chef"
end
