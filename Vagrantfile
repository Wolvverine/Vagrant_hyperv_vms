# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
	
	# Variables for all VMs
	SecSwitch = 'Private Switch'
	SMBPASSWORD = ENV['SMBPASSWORD']
	SMBUSER = 'vagrant'
	
	# Define first vm
	config.vm.define "test1" do |test1|
		VMNAME1 = 'Test-Vagrant1'
		test1.vm.box = "wolvverine/LinuxMintCinnamon"
		test1.vm.box_version = "1.2"
		test1.vm.hostname = VMNAME1
		test1.vm.network 'public_network', bridge: 'Default Switch', type: "dhcp"
		test1.vm.guest = :linux
		test1.vm.box_architecture = 'amd64'
		
		# mount shared folder on VM
		test1.vm.synced_folder './shared', '/vagrant',type: "smb", disabled: false, smb_username: SMBUSER, smb_password: SMBPASSWORD, mount_options: ['vers=3.0', "username=\"#{SMBUSER}\"","password=\"#{SMBPASSWORD}\""]
		
		test1.vm.provider 'hyperv' do |hyperv1,override|
			# Set vmname
			hyperv1.vmname = VMNAME1
			
			# WORKAROUND for all LIMITATIONS OF VAGRANT (execute a powershell script to handle hyper-v actions before startup of instance)
			# will be executed before the hyper-Instance will be started  
			override.trigger.before :'VagrantPlugins::HyperV::Action::StartInstance', type: :action do |trigger|
				trigger.run = { inline: "./scripts/hyperv-config-node.ps1 -VmName \"'#{VMNAME1}'\" -SwitchName \"'#{SecSwitch}'\" " }
			end
			# END WORKAROUND
			hyperv1.cpus = 2,
			hyperv1.enable_virtualization_extensions = false,
			hyperv1.enable_enhanced_session_mode = true,
			hyperv1.enable_checkpoints = true,
			hyperv1.enable_automatic_checkpoints = true,
			hyperv1.vm_integration_services = {
				guest_service_interface: true,
				CustomVMSRV: true,
				heartbeat: true
			}
		end
		
		# Add user ssh public keys to VM
		ssh_pub_key = File.readlines("#{Dir.home}/.ssh/authorized_keys")
		config.vm.provision 'shell', inline: "echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys", privileged: false
		# Make some work in VM - run script in VM
		test1.vm.provision :shell, :path => "./scripts/test1.sh"
		# Make some work in VM - run command in VM shell
		test1.vm.provision :shell, :inline => "printf '%s\n' vagrant #{SMBPASSWORD} #{SMBPASSWORD} | passwd vagrant"
		# Make some work in VM - run command in VM shell
		test1.vm.provision :shell, :inline => "printf \"vagrant\n#{SMBPASSWORD}\n#{SMBPASSWORD}\n\" | passwd vagrant"
	end
	# End definition for first VM
	# Add second vm
end