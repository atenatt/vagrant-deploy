Vagrant.configure("2") do |config|
  config.vm.define "srv-dev" do |vm|
    config.vm.box = "ubuntu/trusty64"
    config.vm.box_version = "20191107.0.0"
    config.vm.network "forwarded_port", guest: 80, host: 8001, host_ip: "127.0.0.1"
    config.vm.provision "shell", path: "provision.sh"
  end
end