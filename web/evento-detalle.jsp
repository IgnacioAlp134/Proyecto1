<%-- 
    Document   : evento-detalle
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
            <p class="text-muted mb-1" style="font-size:13px;">
                <%= e.getFecha() %> — <%= e.getUbicacion() %>
            </p>
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

            <form action="ReservaServlet" method="post" onsubmit="return validarZona()">

                <input type="hidden" name="idEvento" value="<%= e.getIdEvento() %>">

               
                <div class="mb-3">
                    <label class="form-label">Zona</label>

                    <input type="hidden" name="zona" id="zonaSeleccionada">

                    <svg viewBox="0 0 500 420" xmlns="http://www.w3.org/2000/svg" style="width:100%;cursor:pointer;">
                        <ellipse cx="250" cy="210" rx="240" ry="195" fill="#d0cfc8"/>

                        <path onclick="selZona('Norte','#F5A623',this)" d="M 105,100 A 175,155 0 0 1 395,100 L 355,135 A 130,110 0 0 0 145,135 Z" fill="#F5A623"/>
                        <path onclick="selZona('Sur','#F5A623',this)" d="M 105,320 A 175,155 0 0 0 395,320 L 355,285 A 130,110 0 0 1 145,285 Z" fill="#F5A623"/>
                        <text x="250" y="118" text-anchor="middle" font-size="11" fill="#fff" font-weight="bold">NORTE</text>
                        <text x="250" y="312" text-anchor="middle" font-size="11" fill="#fff" font-weight="bold">SUR</text>

                        <path onclick="selZona('Sombra Primer Piso','#C0392B',this)" d="M 105,100 L 145,135 L 145,285 L 105,320 A 240,195 0 0 1 105,100 Z" fill="#C0392B"/>
                        <path onclick="selZona('Sombra Primer Piso','#C0392B',this)" d="M 395,100 L 355,135 L 355,285 L 395,320 A 240,195 0 0 0 395,100 Z" fill="#C0392B"/>
                        <text x="128" y="214" text-anchor="middle" font-size="9" fill="#fff">1°P</text>
                        <text x="372" y="214" text-anchor="middle" font-size="9" fill="#fff">1°P</text>

                        <path onclick="selZona('Sombra Segundo Piso','#2C3E8C',this)" d="M 75,115 L 105,100 L 105,320 L 75,305 A 240,195 0 0 1 75,115 Z" fill="#2C3E8C"/>
                        <path onclick="selZona('Sombra Segundo Piso','#2C3E8C',this)" d="M 425,115 L 395,100 L 395,320 L 425,305 A 240,195 0 0 0 425,115 Z" fill="#2C3E8C"/>
                        <text x="88" y="214" text-anchor="middle" font-size="9" fill="#fff">2°P</text>
                        <text x="412" y="214" text-anchor="middle" font-size="9" fill="#fff">2°P</text>

                        <path onclick="selZona('Sombra Tercer Piso','#1A237E',this)" d="M 10,152 L 75,115 L 75,305 L 10,268 A 240,195 0 0 1 10,152 Z" fill="#1A237E"/>
                        <path onclick="selZona('Sombra Tercer Piso','#1A237E',this)" d="M 490,152 L 425,115 L 425,305 L 490,268 A 240,195 0 0 0 490,152 Z" fill="#1A237E"/>
                        <text x="40" y="214" text-anchor="middle" font-size="9" fill="#fff">3°P</text>
                        <text x="460" y="214" text-anchor="middle" font-size="9" fill="#fff">3°P</text>
                        
                        

                        <ellipse cx="250" cy="210" rx="115" ry="88" fill="#2d7a2d"/>
                    </svg>

                    <div id="zonaLabel" style="margin-top:8px;font-size:14px;color:#555;">
                        Hacé clic en un sector del estadio
                    </div>
                </div>

                
                <div class="mb-3">
                    <label class="form-label">Cantidad de entradas</label>
                    <input type="number" name="cantidad" class="form-control"
                           min="1" max="<%= e.getEntradasDisponibles() %>" value="1" required>
                </div>

                
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">
                        Confirmar reserva
                    </button>
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


<script>
function selZona(nombre, color, el) {
    document.getElementById('zonaSeleccionada').value = nombre;

    document.getElementById('zonaLabel').innerHTML =
        'Zona seleccionada: <strong style="color:' + color + '">' + nombre + '</strong>';

    document.querySelectorAll('svg path').forEach(p => p.style.opacity = '0.5');
    el.style.opacity = '1';
}

function validarZona() {
    const zona = document.getElementById('zonaSeleccionada').value;

    if (!zona) {
        alert('Seleccioná una zona primero');
        return false;
    }
    return true;
}
</script>

</body>
</html>