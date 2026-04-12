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

        System.out.println("EMAIL: " + email);
        System.out.println("PASSWORD: " + password);

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.login(email, password);

        System.out.println("USUARIO: " + (usuario != null ? usuario.getRol() : "null"));

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("rol", usuario.getRol());

            if (usuario.getRol().equals("Administrador")) {
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