package dao.pckg.myapp;

import db.pckg.myapp.Conexion;
import modelos.pckg.myapp.Usuario;
import java.sql.ResultSet;

public class UsuarioDAO {

    public boolean registrar(Usuario u) {
        Conexion con = new Conexion();
        try {
            String sqlCheck = "SELECT * FROM Usuarios WHERE correo='" + u.getCorreo() + "'";
            ResultSet rs = con.ExecuteQuery(sqlCheck);
            if (rs != null && rs.next()) {
                return false;
            }

            ResultSet rsId = con.ExecuteQuery("SELECT COALESCE(MAX(id_usuario), 0) + 1 FROM Usuarios");
            int nuevoId = 1;
            if (rsId != null && rsId.next()) {
                nuevoId = rsId.getInt(1);
            }

            String sql = "INSERT INTO Usuarios (id_usuario, nombre, correo, contrasena, rol) VALUES ("
                    + nuevoId + ", '"
                    + u.getNombre() + "', '"
                    + u.getCorreo() + "', '"
                    + u.getContrasena() + "', 'usuario')";
            con.ExecuteUpdate(sql);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            con.Close();
        }
    }

    public Usuario login(String correo, String contrasena) {
    Conexion con = new Conexion();
    try {
        String sql = "SELECT * FROM Usuarios WHERE correo='" + correo + "' AND contrasena='" + contrasena + "'";
        System.out.println("SQL: " + sql);
        ResultSet rs = con.ExecuteQuery(sql);

        if (rs != null && rs.next()) {
            System.out.println("ROL: " + rs.getString("rol"));
            Usuario u = new Usuario();
            u.setIdUsuario(rs.getInt("id_usuario"));
            u.setNombre(rs.getString("nombre"));
            u.setCorreo(rs.getString("correo"));
            u.setRol(rs.getString("rol"));
            return u;
        } else {
            System.out.println("No encontró el usuario");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.Close();
    }
    return null;
}
}