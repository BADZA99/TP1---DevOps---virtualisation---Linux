#!/bin/bash
# Script d'installation de Tomcat 9 sur Ubuntu
# TP1 DEVOPS - M2 GL

set -euo pipefail

echo "=========================================="
echo "Installation de Tomcat 9"
echo "=========================================="

sudo apt-get update
sudo apt-get install -y tomcat9 tomcat9-admin

# Compatibilité avec les scripts du TP qui utilisent /opt/tomcat
sudo ln -sfn /var/lib/tomcat9 /opt/tomcat

# Activation et démarrage du service
sudo systemctl enable tomcat9
sudo systemctl start tomcat9

echo "=========================================="
echo "Tomcat 9 installé et démarré!"
echo "Accès: http://192.168.56.10:8080"
echo "=========================================="
