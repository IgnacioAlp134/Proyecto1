package servlets.pckg.myapp;

import dao.pckg.myapp.ReservaDAO;
import modelos.pckg.myapp.Reserva;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ReservaServlet")
public class ReservaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idEvento = Integer.parseInt(request.getParameter("idEvento"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));

        Reserva r = new Reserva();
        r.setIdUsuario(usuario.getIdUsuario());
        r.setIdEvento(idEvento);
        r.setCantidad(cantidad);

        ReservaDAO dao = new ReservaDAO();
        boolean exito = dao.insertar(r);

        if (exito) {
            response.sendRedirect("MisReservasServlet");
        } else {
            request.setAttribute("error", "No hay suficientes entradas disponibles");
            request.getRequestDispatcher("EventoDetalleServlet?id=" + idEvento).forward(request, response);
        }
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