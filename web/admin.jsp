<%-- 
    Document   : admin
    Created on : Apr 8, 2026, 7:14:40 PM
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
    <title>Panel Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .navbar { background-color: #2c3e50; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); }
        .btn-primary { background-color: #2c3e50; border: none; }
        .btn-primary:hover { background-color: #1a252f; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark px-4 py-3">
    <span class="navbar-brand fw-bold">Panel de Administración</span>
    <div>
        <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
    </div>
</nav>

<div class="container py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">Gestión de eventos</h4>
        <a href="crear-evento.jsp" class="btn btn-primary">+ Nuevo evento</a>
    </div>

    <% if (request.getAttribute("exito") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("exito") %></div>
    <% } %>

    <div class="card">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Nombre</th>
                        <th>Fecha</th>
                        <th>Ubicación</th>
                        <th>Precio</th>
                        <th>Disponibles</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    ArrayList<Evento> eventos = (ArrayList<Evento>) request.getAttribute("eventos");
                    if (eventos != null) {
                        for (Evento e : eventos) {
                %>
                    <tr>
                        <td><%= e.getIdEvento() %></td>
                        <td><%= e.getNombre() %></td>
                        <td><%= e.getFecha() %></td>
                        <td><%= e.getUbicacion() %></td>
                        <td>₡<%= e.getPrecio() %></td>
                        <td><%= e.getEntradasDisponibles() %> / <%= e.getEntradasTotales() %></td>
                        <td>
                            <a href="EditarEventoServlet?id=<%= e.getIdEvento() %>"
                               class="btn btn-sm btn-warning">Editar</a>
                            <a href="EliminarEventoServlet?id=<%= e.getIdEvento() %>"
                               class="btn btn-sm btn-danger ms-1"
                               onclick="return confirm('¿Eliminar este evento?')">Eliminar</a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">No hay eventos registrados.</td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
