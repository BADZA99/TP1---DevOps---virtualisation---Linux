#!/bin/bash
# Script d'installation de Tomcat 9 sur Ubuntu
# TP1 DEVOPS - M2 GL

echo "=========================================="
echo "Installation de Tomcat 9"
echo "=========================================="

# Variables
TOMCAT_VERSION="9.0.88"
TOMCAT_USER="tomcat"
TOMCAT_DIR="/opt/tomcat"

# Création du groupe et utilisateur tomcat
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d ${TOMCAT_DIR} tomcat

# Téléchargement de Tomcat
cd /tmp
wget -q https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

# Installation
sudo mkdir -p ${TOMCAT_DIR}
sudo tar xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C ${TOMCAT_DIR} --strip-components=1

# Permissions
sudo chown -R tomcat:tomcat ${TOMCAT_DIR}
sudo chmod -R g+r ${TOMCAT_DIR}/conf
sudo chmod g+x ${TOMCAT_DIR}/conf

# Création du service systemd
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat 9
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat

Environment=JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Activation et démarrage du service
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

echo "=========================================="
echo "Tomcat 9 installé et démarré!"
echo "Accès: http://192.168.56.10:8080"
echo "=========================================="
