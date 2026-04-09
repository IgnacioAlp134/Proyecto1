<%-- 
    Document   : eventos
    Created on : Apr 8, 2026, 7:14:18 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.pckg.myapp.Evento"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eventos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .navbar { background-color: #2c3e50; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); }
        .card-img-top { border-radius: 12px 12px 0 0; height: 180px; object-fit: cover; }
        .btn-primary { background-color: #2c3e50; border: none; }
        .btn-primary:hover { background-color: #1a252f; }
        .badge-disponible { background-color: #27ae60; }
        .badge-agotado { background-color: #e74c3c; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark px-4 py-3">
    <span class="navbar-brand fw-bold">Sistema de Eventos</span>
    <div>
        <span class="text-white me-3">Hola, <%= ((modelos.pckg.myapp.Usuario)session.getAttribute("usuario")).getNombre() %></span>
        <a href="MisReservasServlet" class="btn btn-outline-light btn-sm me-2">Mis reservas</a>
        <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
    </div>
</nav>

<div class="container py-4">
    <h4 class="mb-4">Eventos disponibles</h4>

    <div class="row g-4">
        <%
            ArrayList<Evento> eventos = (ArrayList<Evento>) request.getAttribute("eventos");
            if (eventos != null) {
                for (Evento e : eventos) {
        %>
        <div class="col-md-4">
            <div class="card h-100">
                <img src="<%= e.getFoto() != null ? e.getFoto() : "img/default.jpg" %>" class="card-img-top">
                <div class="card-body">
                    <h5 class="card-title"><%= e.getNombre() %></h5>
                    <p class="text-muted" style="font-size: 13px;"><%= e.getFecha() %> — <%= e.getUbicacion() %></p>
                    <p class="card-text" style="font-size: 14px;"><%= e.getDescripcion() %></p>
                    <p class="fw-bold">₡<%= e.getPrecio() %></p>
                    <% if (e.getEntradasDisponibles() > 0) { %>
                        <span class="badge badge-disponible mb-2"><%= e.getEntradasDisponibles() %> entradas disponibles</span>
                    <% } else { %>
                        <span class="badge badge-agotado mb-2">Agotado</span>
                    <% } %>
                </div>
                <div class="card-footer bg-white border-0">
                    <a href="EventoDetalleServlet?id=<%= e.getIdEvento() %>" class="btn btn-primary w-100">Ver detalle</a>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p class="text-muted">No hay eventos disponibles.</p>
        <% } %>
    </div>
</div>

</body>
</html>
