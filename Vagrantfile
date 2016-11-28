Vagrant.configure("2") do |config|
  config.vm.define "ubuntu16" do |dev|
    dev.vm.box = "ubuntu/xenial64"
    dev.vm.network "private_network", ip: "192.168.50.11"
    dev.vm.provider :virtualbox do |v|
      v.memory = 1024
      v.cpus = 1
    end
    dev.vm.provision "shell", path: "setup_ubuntu16.sh", :args => []
  end
end
