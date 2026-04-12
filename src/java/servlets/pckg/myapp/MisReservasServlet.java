package servlets.pckg.myapp;

import dao.pckg.myapp.ReservaDAO;
import modelos.pckg.myapp.Reserva;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/MisReservasServlet")
public class MisReservasServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ReservaDAO dao = new ReservaDAO();
        ArrayList<Reserva> reservas = dao.listarPorUsuario(usuario.getIdUsuario());

        request.setAttribute("reservas", reservas);
        request.getRequestDispatcher("panel-usuario.jsp").forward(request, response);
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