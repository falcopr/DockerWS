Vagrant.configure("2") do |config|
  config.ssh.shell = "sh"
  config.ssh.username = "docker"
  config.ssh.password = "tcuser"

  # Disable synced folders because guest additions aren't available
  # config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder ".", "/vagrant"

  # Naming the box
  config.vm.box = "mylinuxcontainerhost"

  # Expose the Docker port
  config.vm.network "forwarded_port", guest: 2376, host: 2376,
    host_ip: "127.0.0.1", auto_correct: true, id: "docker"

  # b2d doesn't support NFS
  config.nfs.functional = false

  # b2d doesn't persist filesystem between reboots
  if config.ssh.respond_to?(:insert_key)
    config.ssh.insert_key = false
  end

  # Attach the ISO for Virtual Box
  config.vm.provider "virtualbox" do |v|
    v.customize "pre-boot", [
      "storageattach", :id,
      "--storagectl", "IDE Controller",
      "--port", "0",
      "--device", "1",
      "--type", "dvddrive",
      "--medium", File.expand_path("../boot2docker_v1.13.0-rc7.iso", __FILE__)
    ]

    # On VirtualBox, we don't have guest additions or a functional vboxsf
    # in TinyCore Linux, so tell Vagrant that so it can be smarter.
    # v.check_guest_additions = false
    # v.functional_vboxsf     = false
  end

  # Attach the ISO for Hyper-V
end