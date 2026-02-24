#!/bin/bash
# Script de déploiement avec menu interactif
# TP1 DEVOPS - M2 GL

# Variables
TOMCAT_DIR="/opt/tomcat"
WEBAPPS_DIR="${TOMCAT_DIR}/webapps"
WAR_FILE="/vagrant/app/hello.war"

# Couleurs pour le menu
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction pour afficher le menu
afficher_menu() {
    clear
    echo "=========================================="
    echo "     MENU DE GESTION TOMCAT - TP1"
    echo "=========================================="
    echo ""
    echo "  1) Démarrer Tomcat"
    echo "  2) Arrêter Tomcat"
    echo "  3) Redémarrer Tomcat"
    echo "  4) Statut de Tomcat"
    echo "  5) Déployer l'application"
    echo "  6) Voir les logs"
    echo "  7) Quitter"
    echo ""
    echo "=========================================="
}

# Fonction pour démarrer Tomcat
demarrer_tomcat() {
    echo -e "${GREEN}Démarrage de Tomcat...${NC}"
    sudo systemctl start tomcat
    sleep 2
    sudo systemctl status tomcat --no-pager
}

# Fonction pour arrêter Tomcat
arreter_tomcat() {
    echo -e "${YELLOW}Arrêt de Tomcat...${NC}"
    sudo systemctl stop tomcat
    echo -e "${GREEN}Tomcat arrêté.${NC}"
}

# Fonction pour redémarrer Tomcat
redemarrer_tomcat() {
    echo -e "${YELLOW}Redémarrage de Tomcat...${NC}"
    sudo systemctl restart tomcat
    sleep 2
    sudo systemctl status tomcat --no-pager
}

# Fonction pour voir le statut
statut_tomcat() {
    echo -e "${GREEN}Statut de Tomcat:${NC}"
    sudo systemctl status tomcat --no-pager
}

# Fonction pour déployer l'application
deployer_app() {
    echo -e "${YELLOW}Déploiement de l'application...${NC}"
    
    # Vérifier si le WAR existe
    if [ ! -f "${WAR_FILE}" ]; then
        echo -e "${RED}Erreur: Fichier ${WAR_FILE} non trouvé!${NC}"
        echo "Création de l'application de test..."
        bash /vagrant/app/build-app.sh
    fi
    
    # Arrêter Tomcat
    sudo systemctl stop tomcat
    
    # Supprimer l'ancienne version
    sudo rm -rf ${WEBAPPS_DIR}/hello
    sudo rm -f ${WEBAPPS_DIR}/hello.war
    
    # Copier le nouveau WAR
    sudo cp ${WAR_FILE} ${WEBAPPS_DIR}/
    sudo chown tomcat:tomcat ${WEBAPPS_DIR}/hello.war
    
    # Redémarrer Tomcat
    sudo systemctl start tomcat
    
    echo -e "${GREEN}Application déployée!${NC}"
    echo "Accès: http://192.168.56.10:8080/hello/"
}

# Fonction pour voir les logs
voir_logs() {
    echo -e "${GREEN}Dernières lignes des logs Tomcat:${NC}"
    sudo tail -50 ${TOMCAT_DIR}/logs/catalina.out
}

# Boucle principale du menu
while true; do
    afficher_menu
    read -p "Votre choix [1-7]: " choix
    
    case $choix in
        1) demarrer_tomcat ;;
        2) arreter_tomcat ;;
        3) redemarrer_tomcat ;;
        4) statut_tomcat ;;
        5) deployer_app ;;
        6) voir_logs ;;
        7) echo "Au revoir!"; exit 0 ;;
        *) echo -e "${RED}Choix invalide!${NC}" ;;
    esac
    
    echo ""
    read -p "Appuyez sur Entrée pour continuer..."
done
