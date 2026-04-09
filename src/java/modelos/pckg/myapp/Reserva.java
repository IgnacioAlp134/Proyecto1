package modelos.pckg.myapp;

public class Reserva {
    private int idReserva;
    private int idUsuario;
    private int idEvento;
    private int cantidad;
    private String fechaReserva;
    private String codigoConfirmacion;
    private String estado;

    public Reserva() {}

    public Reserva(int idReserva, int idUsuario, int idEvento, int cantidad,
                   String fechaReserva, String codigoConfirmacion, String estado) {
        this.idReserva = idReserva;
        this.idUsuario = idUsuario;
        this.idEvento = idEvento;
        this.cantidad = cantidad;
        this.fechaReserva = fechaReserva;
        this.codigoConfirmacion = codigoConfirmacion;
        this.estado = estado;
    }

    public int getIdReserva() { 
        return idReserva; }
    public void setIdReserva(int idReserva) { 
        this.idReserva = idReserva; }

    public int getIdUsuario() { 
        return idUsuario; }
    public void setIdUsuario(int idUsuario) { 
        this.idUsuario = idUsuario; }

    public int getIdEvento() { 
        return idEvento; }
    public void setIdEvento(int idEvento) { 
        this.idEvento = idEvento; }

    public int getCantidad() { 
        return cantidad; }
    public void setCantidad(int cantidad) { 
        this.cantidad = cantidad; }

    public String getFechaReserva() { 
        return fechaReserva; }
    public void setFechaReserva(String fechaReserva) { 
        this.fechaReserva = fechaReserva; }

    public String getCodigoConfirmacion() { 
        return codigoConfirmacion; }
    public void setCodigoConfirmacion(String codigoConfirmacion) { 
        this.codigoConfirmacion = codigoConfirmacion; }

    public String getEstado() { 
        return estado; }
    public void setEstado(String estado) { 
        this.estado = estado; }
}