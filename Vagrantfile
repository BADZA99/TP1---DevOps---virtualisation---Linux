# -*- mode: ruby -*-
# vi: set ft=ruby :

# TP1 DEVOPS - VM srv-web avec Tomcat 9 et JDK
# Auteur: Etudiant M2 GL

Vagrant.configure("2") do |config|
  
  # Configuration de la VM srv-web
  config.vm.define "srv-web" do |web|
    web.vm.box = "ubuntu/jammy64"
    web.vm.hostname = "srv-web"
    
    # Désactive la vérification des mises à jour de la box
    web.vm.box_check_update = false
    
    # Port forwarding: Tomcat 8080 -> host 8080
    web.vm.network "forwarded_port", guest: 8080, host: 8080
    
    # Réseau privé avec IP fixe
    web.vm.network "private_network", ip: "192.168.56.10"
    
    # Configuration VirtualBox
    web.vm.provider "virtualbox" do |vb|
      vb.name = "srv-web"
      vb.memory = "2048"
      vb.cpus = 2
    end
    
    # Scripts de provisioning (exécutés automatiquement au vagrant up)
    web.vm.provision "shell", path: "scripts/install-java.sh"
    web.vm.provision "shell", path: "scripts/install-tomcat.sh"
  end

end
