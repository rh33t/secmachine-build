Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"
  config.vm.network "private_network", ip: "192.168.56.100"
  config.vm.synced_folder "storage", "bind_workspace"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "4096"
    vb.name = "hackingbox"
    vb.cpus = 4
  end
end

