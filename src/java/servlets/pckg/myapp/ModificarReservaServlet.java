package servlets.pckg.myapp;

import dao.pckg.myapp.ReservaDAO;
import modelos.pckg.myapp.Reserva;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ModificarReservaServlet")
public class ModificarReservaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Si es GET carga el formulario
        if (request.getMethod().equals("GET")) {
            int idReserva = Integer.parseInt(request.getParameter("id"));
            ReservaDAO dao = new ReservaDAO();
            Reserva r = dao.obtenerPorId(idReserva);
            request.setAttribute("reserva", r);
            request.getRequestDispatcher("modificar-reserva.jsp").forward(request, response);
            return;
        }

        // Si es POST guarda los cambios
        int idReserva    = Integer.parseInt(request.getParameter("idReserva"));
        int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));

        ReservaDAO dao = new ReservaDAO();
        dao.modificar(idReserva, nuevaCantidad);

        response.sendRedirect("MisReservasServlet");
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