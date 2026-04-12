<%-- 
    Document   : crear-evento
    Created on : Apr 9, 2026, 9:37:10 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crear Evento</title>
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

        <h4 class="mb-4">Nuevo evento</h4>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="CrearEventoServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Descripción</label>
                <textarea name="descripcion" class="form-control" rows="3" required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Fecha y hora</label>
                <input type="datetime-local" name="fecha" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Ubicación</label>
                <input type="text" name="ubicacion" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">URL de imagen</label>
                <input type="text" name="foto" class="form-control" placeholder="https://...">
            </div>
            <div class="mb-3">
                <label class="form-label">Categoría</label>
                <select name="categoria" class="form-control" required>
                    <option value="Deportes">Deportes</option>
                    <option value="Conciertos">Conciertos</option>
                </select>
            </div>
            <div class="row">
                <div class="col mb-3">
                    <label class="form-label">Entradas totales</label>
                    <input type="number" name="entradasTotales" class="form-control" min="1" required>
                </div>
                <div class="col mb-3">
                    <label class="form-label">Precio (₡)</label>
                    <input type="number" name="precio" class="form-control" min="0" step="0.01" required>
                </div>
            </div>
            <div class="d-grid mt-2">
                <button type="submit" class="btn btn-primary">Crear evento</button>
            </div>
        </form>

    </div>
</div>

</body>
</html>
