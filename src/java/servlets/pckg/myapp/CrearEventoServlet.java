package servlets.pckg.myapp;

import dao.pckg.myapp.EventoDAO;
import modelos.pckg.myapp.Evento;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/CrearEventoServlet")
public class CrearEventoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !usuario.getRol().equals("Administrador")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String nombre          = request.getParameter("nombre");
        String descripcion     = request.getParameter("descripcion");
        String fecha           = request.getParameter("fecha");
        String ubicacion       = request.getParameter("ubicacion");
        String foto            = request.getParameter("foto");
        String categoria       = request.getParameter("categoria");
        int entradasTotales    = Integer.parseInt(request.getParameter("entradasTotales"));
        double precio          = Double.parseDouble(request.getParameter("precio"));

        Evento e = new Evento();
        e.setNombre(nombre);
        e.setDescripcion(descripcion);
        e.setFecha(fecha);
        e.setUbicacion(ubicacion);
        e.setFoto(foto);
        e.setCategoria(categoria);
        e.setEntradasTotales(entradasTotales);
        e.setEntradasDisponibles(entradasTotales);
        e.setPrecio(precio);

        EventoDAO dao = new EventoDAO();
        dao.insertar(e);

        response.sendRedirect("AdminServlet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}