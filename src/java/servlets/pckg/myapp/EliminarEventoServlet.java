package servlets.pckg.myapp;

import dao.pckg.myapp.EventoDAO;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/EliminarEventoServlet")
public class EliminarEventoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !usuario.getRol().equals("Administrador")) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idEvento = Integer.parseInt(request.getParameter("id"));

        EventoDAO dao = new EventoDAO();
        dao.eliminar(idEvento);

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