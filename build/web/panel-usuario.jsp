<%-- 
    Document   : panel-usuario
    Created on : Apr 8, 2026, 7:14:35 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.pckg.myapp.Reserva"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Reservas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .navbar { background-color: #2c3e50; }
        .card { border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); }
        .btn-primary { background-color: #2c3e50; border: none; }
        .btn-primary:hover { background-color: #1a252f; }
        .badge-activa { background-color: #27ae60; }
        .badge-cancelada { background-color: #e74c3c; }
        .badge-modificada { background-color: #e67e22; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark px-4 py-3">
    <span class="navbar-brand fw-bold">Sistema de Eventos</span>
    <div>
        <a href="EventosServlet" class="btn btn-outline-light btn-sm me-2">Ver eventos</a>
        <a href="LogoutServlet" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
    </div>
</nav>

<div class="container py-4">
    <h4 class="mb-4">Mis reservas</h4>

    <% if (request.getAttribute("exito") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("exito") %></div>
    <% } %>

    <%
        ArrayList<Reserva> reservas = (ArrayList<Reserva>) request.getAttribute("reservas");
        if (reservas != null && !reservas.isEmpty()) {
    %>
    <div class="card">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th>Código</th>
                        <th>Evento</th>
                        <th>Cantidad</th>
                        <th>Fecha reserva</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (Reserva r : reservas) {
                %>
                    <tr>
                        <td><%= r.getCodigoConfirmacion() %></td>
                        <td><%= r.getIdEvento() %></td>
                        <td><%= r.getCantidad() %></td>
                        <td><%= r.getFechaReserva() %></td>
                        <td>
                            <span class="badge badge-<%= r.getEstado() %>">
                                <%= r.getEstado() %>
                            </span>
                        </td>
                        <td>
                            <% if (r.getEstado().equals("activa")) { %>
                                <a href="CancelarReservaServlet?id=<%= r.getIdReserva() %>"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('¿Cancelar esta reserva?')">Cancelar</a>
                                <a href="modificar-reserva.jsp?id=<%= r.getIdReserva() %>"
                                   class="btn btn-sm btn-warning ms-1">Modificar</a>
                            <% } %>
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <% } else { %>
        <div class="card p-4 text-center text-muted">
            No tenés reservas aún. <a href="EventosServlet">Ver eventos disponibles</a>
        </div>
    <% } %>
</div>

</body>
</html>
