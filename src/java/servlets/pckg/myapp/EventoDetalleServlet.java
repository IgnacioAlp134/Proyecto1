package servlets.pckg.myapp;

import dao.pckg.myapp.EventoDAO;
import modelos.pckg.myapp.Evento;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/EventoDetalleServlet")
public class EventoDetalleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        EventoDAO dao = new EventoDAO();
        Evento e = dao.obtenerPorId(id);

        request.setAttribute("evento", e);
        request.getRequestDispatcher("evento-detalle.jsp").forward(request, response);
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