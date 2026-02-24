#!/bin/bash
# Script de création d'une application web Java simple
# TP1 DEVOPS - M2 GL

echo "=========================================="
echo "Création de l'application Hello World"
echo "=========================================="

APP_DIR="/vagrant/app/hello"
WAR_FILE="/vagrant/app/hello.war"

# Création de la structure de l'application
mkdir -p ${APP_DIR}/WEB-INF

# Création de la page d'accueil (JSP)
cat > ${APP_DIR}/index.jsp << 'EOF'
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>TP1 DevOps - Hello World</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f0f0f0; }
        .container { background: white; padding: 30px; border-radius: 10px; max-width: 600px; margin: auto; }
        h1 { color: #2c3e50; }
        .info { background: #ecf0f1; padding: 15px; border-radius: 5px; margin: 10px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1> TP1 DevOps - Application Web Java</h1>
        <div class="info">
            <p><strong>Message:</strong> Hello World depuis Tomcat!</p>
            <p><strong>Date/Heure:</strong> <%= new java.util.Date() %></p>
            <p><strong>Serveur:</strong> <%= application.getServerInfo() %></p>
            <p><strong>Java Version:</strong> <%= System.getProperty("java.version") %></p>
        </div>
        <p> Application déployée avec succès!</p>
    </div>
</body>
</html>
EOF

# Création du fichier web.xml (descripteur de déploiement)
cat > ${APP_DIR}/WEB-INF/web.xml << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee 
         http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    
    <display-name>Hello World App</display-name>
    
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>
    
</web-app>
EOF

# Création du fichier WAR
cd ${APP_DIR}
jar -cvf ${WAR_FILE} .

echo "=========================================="
echo "Application créée: ${WAR_FILE}"
echo "=========================================="
