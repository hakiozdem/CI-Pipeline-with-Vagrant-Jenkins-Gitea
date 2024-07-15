Vagrant.configure("2") do |config|
    config.vm.define "jenkins" do |jenkins|
      jenkins.vm.box = "ubuntu/focal64"
      jenkins.vm.hostname = "jenkins"
      jenkins.vm.network "private_network", ip: "192.168.56.10"
      jenkins.vm.synced_folder './jenkins-backup', '/vagrant/jenkins-backup'
      jenkins.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = "2"
      end
      jenkins.vm.provision "shell", path: "jenkins-setup.sh"
    end
  
    config.vm.define "gitea" do |gitea|
      gitea.vm.box = "generic/centos8"
      gitea.vm.hostname= "git.mypipeline.local"
      gitea.vm.network "private_network", ip: "192.168.56.12"
      gitea.vm.synced_folder './jenkins-backup', '/vagrant', disabled: true
      gitea.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = "1"
      end
      gitea.vm.provision "shell", path: "gitea-setup.sh"
    end
      
    config.vm.define "sonarqube" do |sonarqube|
      sonarqube.vm.box = "ubuntu/focal64"
      sonarqube.vm.hostname = "sonarqube"
      sonarqube.vm.network "private_network", ip: "192.168.56.11"
      sonarqube.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "1"
      end
      sonarqube.vm.provision "shell", path: "sonar-setup.sh"
    end

    config.vm.define "build_agent" do |build_agent|
      build_agent.vm.box = "ubuntu/focal64"
      build_agent.vm.hostname = "buildagent"
      build_agent.vm.network "private_network", ip: "192.168.56.13"
      build_agent.ssh.username = "vagrant"
      build_agent.ssh.password = "vagrant"
      build_agent.ssh.insert_key = false
      build_agent.vm.provider "virtualbox" do |vb|
        vb.memory  = "1024"
        vb.cpus = "1"
      end
      build_agent.vm.provision "shell", path: "buildagent-setup.sh"
    end
  end
  