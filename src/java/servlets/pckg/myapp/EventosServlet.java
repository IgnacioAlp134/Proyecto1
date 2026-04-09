package servlets.pckg.myapp;

import dao.pckg.myapp.EventoDAO;
import modelos.pckg.myapp.Evento;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/EventosServlet")
public class EventosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EventoDAO dao = new EventoDAO();
        ArrayList<Evento> eventos = dao.listar();

        request.setAttribute("eventos", eventos);
        request.getRequestDispatcher("eventos.jsp").forward(request, response);
    }
}