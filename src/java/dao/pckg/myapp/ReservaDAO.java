package dao.pckg.myapp;

import db.pckg.myapp.Conexion;
import modelos.pckg.myapp.Reserva;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReservaDAO {

    public boolean insertar(Reserva r) {
        Conexion con = new Conexion();
        try {
            // Verificar disponibilidad
            ResultSet rsDisp = con.ExecuteQuery("SELECT entradas_disponibles FROM Eventos WHERE id_evento=" + r.getIdEvento());
            if (rsDisp != null && rsDisp.next()) {
                int disponibles = rsDisp.getInt("entradas_disponibles");
                if (disponibles < r.getCantidad()) {
                    return false;
                }
            }

            // Obtener nuevo ID
            ResultSet rsId = con.ExecuteQuery("SELECT COALESCE(MAX(id_reserva), 0) + 1 FROM Reservas");
            int nuevoId = 1;
            if (rsId != null && rsId.next()) {
                nuevoId = rsId.getInt(1);
            }

            // Generar código de confirmación
            String codigo = "EVT-" + nuevoId + "-" + System.currentTimeMillis();

            String sql = "INSERT INTO Reservas (id_reserva, id_usuario, id_evento, cantidad, codigo_confirmacion, estado) VALUES ("
                    + nuevoId + ", "
                    + r.getIdUsuario() + ", "
                    + r.getIdEvento() + ", "
                    + r.getCantidad() + ", '"
                    + codigo + "', 'activa')";
            con.ExecuteUpdate(sql);

            // Actualizar entradas disponibles
            con.ExecuteUpdate("UPDATE Eventos SET entradas_disponibles = entradas_disponibles - " + r.getCantidad()
                    + " WHERE id_evento=" + r.getIdEvento());

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            con.Close();
        }
    }

    public ArrayList<Reserva> listarPorUsuario(int idUsuario) {
        Conexion con = new Conexion();
        ArrayList<Reserva> lista = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Reservas WHERE id_usuario=" + idUsuario;
            ResultSet rs = con.ExecuteQuery(sql);
            while (rs != null && rs.next()) {
                Reserva r = new Reserva();
                r.setIdReserva(rs.getInt("id_reserva"));
                r.setIdUsuario(rs.getInt("id_usuario"));
                r.setIdEvento(rs.getInt("id_evento"));
                r.setCantidad(rs.getInt("cantidad"));
                r.setFechaReserva(rs.getString("fecha_reserva"));
                r.setCodigoConfirmacion(rs.getString("codigo_confirmacion"));
                r.setEstado(rs.getString("estado"));
                lista.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.Close();
        }
        return lista;
    }

    public void cancelar(int idReserva) {
        Conexion con = new Conexion();
        try {
            // Obtener la reserva para devolver entradas
            ResultSet rs = con.ExecuteQuery("SELECT * FROM Reservas WHERE id_reserva=" + idReserva);
            if (rs != null && rs.next()) {
                int idEvento = rs.getInt("id_evento");
                int cantidad = rs.getInt("cantidad");

                // Cancelar reserva
                con.ExecuteUpdate("UPDATE Reservas SET estado='cancelada' WHERE id_reserva=" + idReserva);

                // Devolver entradas
                con.ExecuteUpdate("UPDATE Eventos SET entradas_disponibles = entradas_disponibles + " + cantidad
                        + " WHERE id_evento=" + idEvento);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.Close();
        }
    }

    public Reserva obtenerPorId(int idReserva) {
        Conexion con = new Conexion();
        try {
            ResultSet rs = con.ExecuteQuery("SELECT * FROM Reservas WHERE id_reserva=" + idReserva);
            if (rs != null && rs.next()) {
                Reserva r = new Reserva();
                r.setIdReserva(rs.getInt("id_reserva"));
                r.setIdUsuario(rs.getInt("id_usuario"));
                r.setIdEvento(rs.getInt("id_evento"));
                r.setCantidad(rs.getInt("cantidad"));
                r.setFechaReserva(rs.getString("fecha_reserva"));
                r.setCodigoConfirmacion(rs.getString("codigo_confirmacion"));
                r.setEstado(rs.getString("estado"));
                return r;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.Close();
        }
        return null;
    }

    public void modificar(int idReserva, int nuevaCantidad) {
        Conexion con = new Conexion();
        try {
            ResultSet rs = con.ExecuteQuery("SELECT * FROM Reservas WHERE id_reserva=" + idReserva);
            if (rs != null && rs.next()) {
                int idEvento      = rs.getInt("id_evento");
                int cantidadVieja = rs.getInt("cantidad");
                int diferencia    = nuevaCantidad - cantidadVieja;

                con.ExecuteUpdate("UPDATE Reservas SET cantidad=" + nuevaCantidad
                        + ", estado='modificada' WHERE id_reserva=" + idReserva);

                con.ExecuteUpdate("UPDATE Eventos SET entradas_disponibles = entradas_disponibles - " + diferencia
                        + " WHERE id_evento=" + idEvento);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            con.Close();
        }
    }
}