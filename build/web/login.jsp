<%-- 
    Document   : login
    Created on : Apr 8, 2026, 7:06:17 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Sistema de Eventos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        }
        .btn-primary {
            background-color: #2c3e50;
            border: none;
        }
        .btn-primary:hover {
            background-color: #1a252f;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card p-4" style="width: 100%; max-width: 400px;">

        <h4 class="text-center mb-4">Iniciar Sesión</h4>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Correo electrónico</label>
                <input type="email" name="correo" class="form-control" placeholder="correo@ejemplo.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" name="contrasena" class="form-control" placeholder="••••••••" required>
            </div>
            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-primary">Entrar</button>
            </div>
        </form>

        <hr>

        <p class="text-center mb-0" style="font-size: 14px;">
            ¿No tenés cuenta? <a href="registro.jsp">Registrate</a>
        </p>

    </div>
</div>

</body>
</html>
