package db.pckg.myapp;

import java.sql.*;

public class Conexion {

    Connection conn;

    public Conexion() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost/db_eventos", "root", "Admin$1234");
        } catch (ClassNotFoundException | SQLException ex) {
            System.getLogger(Conexion.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }

    public ResultSet ExecuteQuery(String sql) {
        try {
            Statement cmd = conn.createStatement();
            return cmd.executeQuery(sql);
        } catch (SQLException ex) {
            System.getLogger(Conexion.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
            return null;
        }
    }

    public void ExecuteUpdate(String sql) {
        try {
            Statement cmd = conn.createStatement();
            cmd.executeUpdate(sql);
        } catch (SQLException ex) {
            System.getLogger(Conexion.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }
    public Connection getConnection() {
    return conn;
}

    public void Close() {
        try {
            conn.close();
        } catch (SQLException ex) {
            System.getLogger(Conexion.class.getName()).log(System.Logger.Level.ERROR, (String) null, ex);
        }
    }
}