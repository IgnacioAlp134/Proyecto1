package servlets.pckg.myapp;

import dao.pckg.myapp.UsuarioDAO;
import modelos.pckg.myapp.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre   = request.getParameter("nombre");
        String email    = request.getParameter("correo");
        String password = request.getParameter("contrasena");

        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setCorreo(email);
        usuario.setContrasena(password);

        UsuarioDAO dao = new UsuarioDAO();
        boolean ok = dao.registrar(usuario);

        if (ok) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "El correo ya está registrado");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }
}