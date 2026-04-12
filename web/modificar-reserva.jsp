<%-- 
    Document   : modificar-reserva
    Created on : Apr 9, 2026, 10:12:52 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelos.pckg.myapp.Reserva"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Reserva</title>
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
    <span class="navbar-brand fw-bold">Sistema de Eventos</span>
    <a href="MisReservasServlet" class="btn btn-outline-light btn-sm">Volver</a>
</nav>

<div class="container py-4">
    <div class="card p-4" style="max-width: 400px; margin: auto;">

        <h4 class="mb-4">Modificar reserva</h4>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <%
            Reserva r = (Reserva) request.getAttribute("reserva");
        %>

        <p><strong>Código:</strong> <%= r.getCodigoConfirmacion() %></p>
        <p><strong>Cantidad actual:</strong> <%= r.getCantidad() %></p>

        <form action="ModificarReservaServlet" method="post">
            <input type="hidden" name="idReserva" value="<%= r.getIdReserva() %>">
            <div class="mb-3">
                <label class="form-label">Nueva cantidad</label>
                <input type="number" name="cantidad" class="form-control" min="1" value="<%= r.getCantidad() %>" required>
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary">Guardar cambios</button>
            </div>
        </form>

    </div>
</div>

</body>
</html>