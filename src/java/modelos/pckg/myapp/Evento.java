package modelos.pckg.myapp;

public class Evento {
    private int idEvento;
    private String nombre;
    private String descripcion;
    private String fecha;
    private String foto;
    private String ubicacion;
    private int entradasTotales;
    private int entradasDisponibles;
    private double precio;

    public Evento() {}

    public Evento(int idEvento, String nombre, String descripcion, String fecha,
                  String foto, String ubicacion, int entradasTotales,
                  int entradasDisponibles, double precio) {
        this.idEvento = idEvento;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.foto = foto;
        this.ubicacion = ubicacion;
        this.entradasTotales = entradasTotales;
        this.entradasDisponibles = entradasDisponibles;
        this.precio = precio;
    }

    public int getIdEvento() { 
        return idEvento; }
    public void setIdEvento(int idEvento) { 
        this.idEvento = idEvento; }

    public String getNombre() { 
        return nombre; }
    public void setNombre(String nombre) { 
        this.nombre = nombre; }

    public String getDescripcion() { 
        return descripcion; }
    public void setDescripcion(String descripcion) { 
        this.descripcion = descripcion; }

    public String getFecha() { 
        return fecha; }
    public void setFecha(String fecha) { 
        this.fecha = fecha; }

    public String getFoto() { 
        return foto; }
    public void setFoto(String foto) { 
        this.foto = foto; }

    public String getUbicacion() { 
        return ubicacion; }
    public void setUbicacion(String ubicacion) { 
        this.ubicacion = ubicacion; }

    public int getEntradasTotales() { 
        return entradasTotales; }
    public void setEntradasTotales(int entradasTotales) { 
        this.entradasTotales = entradasTotales; }

    public int getEntradasDisponibles() { 
        return entradasDisponibles; }
    public void setEntradasDisponibles(int entradasDisponibles) { 
        this.entradasDisponibles = entradasDisponibles; }

    public double getPrecio() { 
        return precio; }
    public void setPrecio(double precio) { 
        this.precio = precio; }
}