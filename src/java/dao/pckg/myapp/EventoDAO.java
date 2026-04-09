package dao.pckg.myapp;

import db.pckg.myapp.Conexion;
import modelos.pckg.myapp.Evento;
import java.sql.ResultSet;
import java.util.ArrayList;

public class EventoDAO {

    private Conexion con;

    public EventoDAO() {
        con = new Conexion();
    }

    public ArrayList<Evento> listar() {
        ArrayList<Evento> lista = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Eventos";
            ResultSet rs = con.ExecuteQuery(sql);
            while (rs != null && rs.next()) {
                Evento e = new Evento();
                e.setIdEvento(rs.getInt("id_evento"));
                e.setNombre(rs.getString("nombre"));
                e.setDescripcion(rs.getString("descripcion"));
                e.setFecha(rs.getString("fecha"));
                e.setFoto(rs.getString("foto"));
                e.setUbicacion(rs.getString("ubicacion"));
                e.setEntradasTotales(rs.getInt("entradas_totales"));
                e.setEntradasDisponibles(rs.getInt("entradas_disponibles"));
                e.setPrecio(rs.getDouble("precio"));
                lista.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.Close();
        }
        return lista;
    }

    public Evento obtenerPorId(int id) {
        try {
            String sql = "SELECT * FROM Eventos WHERE id_evento=" + id;
            ResultSet rs = con.ExecuteQuery(sql);
            if (rs != null && rs.next()) {
                Evento e = new Evento();
                e.setIdEvento(rs.getInt("id_evento"));
                e.setNombre(rs.getString("nombre"));
                e.setDescripcion(rs.getString("descripcion"));
                e.setFecha(rs.getString("fecha"));
                e.setFoto(rs.getString("foto"));
                e.setUbicacion(rs.getString("ubicacion"));
                e.setEntradasTotales(rs.getInt("entradas_totales"));
                e.setEntradasDisponibles(rs.getInt("entradas_disponibles"));
                e.setPrecio(rs.getDouble("precio"));
                return e;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.Close();
        }
        return null;
    }

    public void insertar(Evento e) {
        try {
            ResultSet rsId = con.ExecuteQuery("SELECT COALESCE(MAX(id_evento), 0) + 1 FROM Eventos");
            int nuevoId = 1;
            if (rsId != null && rsId.next()) {
                nuevoId = rsId.getInt(1);
            }

            String sql = "INSERT INTO Eventos (id_evento, nombre, descripcion, fecha, foto, ubicacion, entradas_totales, entradas_disponibles, precio) VALUES ("
                    + nuevoId + ", '"
                    + e.getNombre() + "', '"
                    + e.getDescripcion() + "', '"
                    + e.getFecha() + "', '"
                    + e.getFoto() + "', '"
                    + e.getUbicacion() + "', "
                    + e.getEntradasTotales() + ", "
                    + e.getEntradasTotales() + ", "
                    + e.getPrecio() + ")";

            con.ExecuteUpdate(sql);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.Close();
        }
    }

    public void actualizar(Evento e) {
        try {
            String sql = "UPDATE Eventos SET nombre='" + e.getNombre()
                    + "', descripcion='" + e.getDescripcion()
                    + "', fecha='" + e.getFecha()
                    + "', foto='" + e.getFoto()
                    + "', ubicacion='" + e.getUbicacion()
                    + "', entradas_totales=" + e.getEntradasTotales()
                    + ", entradas_disponibles=" + e.getEntradasDisponibles()
                    + ", precio=" + e.getPrecio()
                    + " WHERE id_evento=" + e.getIdEvento();
            con.ExecuteUpdate(sql);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.Close();
        }
    }

    public void eliminar(int id) {
        try {
            con.ExecuteUpdate("DELETE FROM Eventos WHERE id_evento=" + id);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            con.Close();
        }
    }
}