package servlets.pckg.myapp;

import dao.pckg.myapp.EventoDAO;
import modelos.pckg.myapp.Evento;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/EditarEventoServlet")
public class EditarEventoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !usuario.getRol().equals("Administrador")) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Si es GET carga el formulario
        if (request.getMethod().equals("GET")) {
            int id = Integer.parseInt(request.getParameter("id"));
            EventoDAO dao = new EventoDAO();
            Evento e = dao.obtenerPorId(id);
            request.setAttribute("evento", e);
            request.getRequestDispatcher("editar-evento.jsp").forward(request, response);
            return;
        }

        // Si es POST guarda los cambios
        int idEvento              = Integer.parseInt(request.getParameter("idEvento"));
        String nombre             = request.getParameter("nombre");
        String descripcion        = request.getParameter("descripcion");
        String fecha              = request.getParameter("fecha");
        String ubicacion          = request.getParameter("ubicacion");
        String foto               = request.getParameter("foto");
        int entradasTotales       = Integer.parseInt(request.getParameter("entradasTotales"));
        int entradasDisponibles   = Integer.parseInt(request.getParameter("entradasDisponibles"));
        double precio             = Double.parseDouble(request.getParameter("precio"));

        Evento e = new Evento();
        e.setIdEvento(idEvento);
        e.setNombre(nombre);
        e.setDescripcion(descripcion);
        e.setFecha(fecha);
        e.setUbicacion(ubicacion);
        e.setFoto(foto);
        e.setEntradasTotales(entradasTotales);
        e.setEntradasDisponibles(entradasDisponibles);
        e.setPrecio(precio);

        EventoDAO dao = new EventoDAO();
        dao.actualizar(e);

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