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
        .img-evento { width: 100%; height: 260px; object-fit: cover; border-radius: 12px; }
        .btn-primary { background-color: #2c3e50; border: none; }
        .btn-primary:hover { background-color: #1a252f; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark px-4 py-3">
    <span class="navbar-brand fw-bold">Sistema de Eventos</span>
    <div>
        <a href="EventosServlet" class="btn btn-outline-light btn-sm me-2">Volver</a>
        <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
    </div>
</nav>

<div class="container py-4">
<%
    Evento e = (Evento) request.getAttribute("evento");
    if (e != null) {
%>
<div class="row g-4">
    <div class="col-md-5">
        <img src="<%= e.getFoto() != null && !e.getFoto().isEmpty() ? e.getFoto() : "https://placehold.co/400x260?text=Sin+imagen" %>" class="img-evento">
        <div class="card p-3 mt-3">
            <h5><%= e.getNombre() %></h5>
            <p class="text-muted mb-1" style="font-size:13px;"><%= e.getFecha() %> — <%= e.getUbicacion() %></p>
            <p style="font-size:14px;"><%= e.getDescripcion() %></p>
            <p class="fw-bold">₡<%= e.getPrecio() %> por entrada</p>
            <% if (e.getEntradasDisponibles() > 0) { %>
                <span class="text-success">Disponibles: <%= e.getEntradasDisponibles() %></span>
            <% } else { %>
                <span class="text-danger fw-bold">Agotado</span>
            <% } %>
        </div>
    </div>

    <div class="col-md-7">
        <div class="card p-4">
            <h5 class="mb-3">Reservar entradas</h5>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>

            <% if (e.getEntradasDisponibles() > 0) { %>
            <form action="ReservaServlet" method="post">
                <input type="hidden" name="idEvento" value="<%= e.getIdEvento() %>">

                <div class="mb-3">
                    <label class="form-label">Zona</label>
                    <select name="zona" class="form-control" required>
                        <option value="">-- Seleccioná una zona --</option>
                        <option value="Norte">Norte</option>
                        <option value="Sur">Sur</option>
                        <option value="Sombra Primer Piso">Sombra Primer Piso</option>
                        <option value="Sombra Segundo Piso">Sombra Segundo Piso</option>
                        <option value="Sombra Tercer Piso">Sombra Tercer Piso</option>
                    </select>
                </div>

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