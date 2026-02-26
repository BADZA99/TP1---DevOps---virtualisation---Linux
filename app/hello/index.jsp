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
