<%-- 
    Document   : editar-evento
    Created on : Apr 9, 2026, 10:01:41 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelos.pckg.myapp.Evento"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Evento</title>
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
    <a href="AdminServlet" class="btn btn-outline-light btn-sm">Volver</a>
</nav>

<div class="container py-4">
    <div class="card p-4" style="max-width: 600px; margin: auto;">

        <h4 class="mb-4">Editar evento</h4>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <%
            Evento e = (Evento) request.getAttribute("evento");
        %>

        <form action="EditarEventoServlet" method="post">
            <input type="hidden" name="idEvento" value="<%= e.getIdEvento() %>">
            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" name="nombre" class="form-control" value="<%= e.getNombre() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Descripción</label>
                <textarea name="descripcion" class="form-control" rows="3" required><%= e.getDescripcion() %></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Fecha y hora</label>
                <input type="datetime-local" name="fecha" class="form-control" value="<%= e.getFecha() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Ubicación</label>
                <input type="text" name="ubicacion" class="form-control" value="<%= e.getUbicacion() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">URL de imagen</label>
                <input type="text" name="foto" class="form-control" value="<%= e.getFoto() != null ? e.getFoto() : "" %>">
            </div>
            <div class="row">
                <div class="col mb-3">
                    <label class="form-label">Entradas totales</label>
                    <input type="number" name="entradasTotales" class="form-control" value="<%= e.getEntradasTotales() %>" min="1" required>
                </div>
                <div class="col mb-3">
                    <label class="form-label">Entradas disponibles</label>
                    <input type="number" name="entradasDisponibles" class="form-control" value="<%= e.getEntradasDisponibles() %>" min="0" required>
                </div>
            </div>
            <div class="mb-3">
                <label class="form-label">Precio (₡)</label>
                <input type="number" name="precio" class="form-control" value="<%= e.getPrecio() %>" min="0" step="0.01" required>
            </div>
            <div class="d-grid mt-2">
                <button type="submit" class="btn btn-primary">Guardar cambios</button>
            </div>
        </form>

    </div>
</div>

</body>
</html>
