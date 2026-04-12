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
        .evento-card { background-color: #fff; border: none; border-radius: 12px; box-shadow: 0 2px 12px rgba(0,0,0,0.1); overflow: hidden; transition: transform 0.2s; }
        .evento-card:hover { transform: translateY(-5px); }
        .evento-card img { width: 100%; height: 180px; object-fit: cover; }
        .evento-card .card-body { padding: 1rem; }
        .evento-card .card-title { font-size: 16px; font-weight: bold; }
        .evento-card .card-text { font-size: 13px; color: #666; }
        .badge-disponible { background-color: #27ae60; color: #fff; padding: 3px 8px; border-radius: 6px; font-size: 12px; }
        .badge-agotado { background-color: #e74c3c; color: #fff; padding: 3px 8px; border-radius: 6px; font-size: 12px; }
        .btn-ver { background-color: #2c3e50; color: #fff; border: none; width: 100%; border-radius: 8px; padding: 8px; }
        .btn-ver:hover { background-color: #1a252f; color: #fff; }
        .precio { font-size: 18px; font-weight: bold; color: #2c3e50; }
        .nav-pills .nav-link.active { background-color: #2c3e50; }
        .nav-pills .nav-link { color: #2c3e50; }
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
    <h4 class="mb-3">Eventos disponibles</h4>

    <ul class="nav nav-pills mb-4">
        <li class="nav-item">
            <a class="nav-link active" onclick="filtrar('todos')" href="#">Todos</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" onclick="filtrar('Deportes')" href="#">Deportes</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" onclick="filtrar('Conciertos')" href="#">Conciertos</a>
        </li>
    </ul>

    <div class="row g-4" id="lista-eventos">
        <%
            ArrayList<Evento> eventos = (ArrayList<Evento>) request.getAttribute("eventos");
            if (eventos != null && !eventos.isEmpty()) {
                for (Evento e : eventos) {
        %>
        <div class="col-md-4 evento-item" data-categoria="<%= e.getCategoria() %>">
            <div class="evento-card">
                <img src="<%= e.getFoto() != null && !e.getFoto().isEmpty() ? e.getFoto() : "https://placehold.co/400x180?text=Sin+imagen" %>" alt="<%= e.getNombre() %>">
                <div class="card-body">
                    <h5 class="card-title"><%= e.getNombre() %></h5>
                    <p class="card-text"><%= e.getFecha() %> — <%= e.getUbicacion() %></p>
                    <p class="card-text"><%= e.getDescripcion().length() > 80 ? e.getDescripcion().substring(0, 80) + "..." : e.getDescripcion() %></p>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="precio">₡<%= e.getPrecio() %></span>
                        <% if (e.getEntradasDisponibles() > 0) { %>
                            <span class="badge-disponible"><%= e.getEntradasDisponibles() %> disponibles</span>
                        <% } else { %>
                            <span class="badge-agotado">Agotado</span>
                        <% } %>
                    </div>
                    <a href="EventoDetalleServlet?id=<%= e.getIdEvento() %>" class="btn btn-ver">Ver detalle</a>
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

<script>
function filtrar(categoria) {
    document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
    event.target.classList.add('active');

    document.querySelectorAll('.evento-item').forEach(item => {
        if (categoria === 'todos' || item.dataset.categoria === categoria) {
            item.style.display = '';
        } else {
            item.style.display = 'none';
        }
    });
}
</script>

</body>
</html>
