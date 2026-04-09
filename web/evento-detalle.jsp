<%-- 
    Document   : evento-detalle
    Created on : Apr 8, 2026, 7:14:25 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelos.pckg.myapp.Evento"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle del Evento</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .navbar { background-color: #2c3e50; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); }
        .img-evento { width: 100%; height: 300px; object-fit: cover; border-radius: 12px; }
        .btn-primary { background-color: #2c3e50; border: none; }
        .btn-primary:hover { background-color: #1a252f; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark px-4 py-3">
    <span class="navbar-brand fw-bold">Sistema de Eventos</span>
    <div>
        <a href="EventosServlet" class="btn btn-outline-light btn-sm me-2">Volver a eventos</a>
        <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
    </div>
</nav>

<div class="container py-4">
    <%
        Evento e = (Evento) request.getAttribute("evento");
        if (e != null) {
    %>

    <div class="row g-4">
        <div class="col-md-6">
            <img src="<%= e.getFoto() != null ? e.getFoto() : "img/default.jpg" %>" class="img-evento">
        </div>

        <div class="col-md-6">
            <div class="card p-4 h-100">
                <h3><%= e.getNombre() %></h3>
                <p class="text-muted"><%= e.getFecha() %> — <%= e.getUbicacion() %></p>
                <p><%= e.getDescripcion() %></p>
                <p class="fw-bold fs-5">₡<%= e.getPrecio() %> por entrada</p>

                <% if (e.getEntradasDisponibles() > 0) { %>
                    <p class="text-success">Entradas disponibles: <%= e.getEntradasDisponibles() %></p>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                    <% } %>
                    <% if (request.getAttribute("exito") != null) { %>
                        <div class="alert alert-success"><%= request.getAttribute("exito") %></div>
                    <% } %>

                    <form action="ReservaServlet" method="post">
                        <input type="hidden" name="idEvento" value="<%= e.getIdEvento() %>">
                        <div class="mb-3">
                            <label class="form-label">Cantidad de entradas</label>
                            <input type="number" name="cantidad" class="form-control"
                                   min="1" max="<%= e.getEntradasDisponibles() %>" value="1" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Confirmar reserva</button>
                        </div>
                    </form>

                <% } else { %>
                    <div class="alert alert-danger">Este evento está agotado.</div>
                <% } %>
            </div>
        </div>
    </div>

    <% } else { %>
        <p class="text-muted">Evento no encontrado.</p>
    <% } %>
</div>

</body>
</html>