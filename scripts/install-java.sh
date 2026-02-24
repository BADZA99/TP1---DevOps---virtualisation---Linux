#!/bin/bash
# Script d'installation de Java (JDK 8, 11, 17) sur Ubuntu
# TP1 DEVOPS - M2 GL

echo "=========================================="
echo "Installation des JDK 8, 11 et 17"
echo "=========================================="

# Mise à jour des paquets
sudo apt-get update

# Installation des 3 versions de JDK
sudo apt-get install -y openjdk-8-jdk
sudo apt-get install -y openjdk-11-jdk
sudo apt-get install -y openjdk-17-jdk

# Configuration de Java 11 par défaut
sudo update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-11-openjdk-amd64/bin/javac

# Configuration de JAVA_HOME dans /etc/environment
echo 'JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"' | sudo tee -a /etc/environment

# Chargement de la variable
source /etc/environment

echo "=========================================="
echo "Installation Java terminée!"
echo "Version par défaut:"
java -version
echo "=========================================="
