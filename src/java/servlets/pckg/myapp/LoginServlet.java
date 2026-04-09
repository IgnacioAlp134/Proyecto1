package servlets.pckg.myapp;

import dao.pckg.myapp.UsuarioDAO;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("correo");
        String password = request.getParameter("contrasena");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.login(email, password);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("rol", usuario.getRol());

            if (usuario.getRol().equals("administrador")) {
                response.sendRedirect("AdminServlet");
            } else {
                response.sendRedirect("EventosServlet");
            }
        } else {
            request.setAttribute("error", "Correo o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}