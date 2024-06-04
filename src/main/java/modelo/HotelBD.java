package modelo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

/**
 * Esta clase representa un hotel en la base de datos.
 * @author Grupo 5
 * @since 2024
 */
@Entity
@Table(name = "hotel", schema = "gestion_viajes")
public class HotelBD implements Serializable{

    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "id_hotel")
    private String id_hotel;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_direccion")
    private Direccion direccion;

    @Column(name = "nombre_hotel")
    private String nombre_hotel;
    
    @Column(name = "latitud_hotel")
    private BigDecimal latitud;

    @Column(name = "longitud_hotel")
    private BigDecimal longitud;  
    
    @OneToMany(mappedBy = "hotel", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Habitacion> habitaciones = new ArrayList<>();

    /**
     * Constructor por defecto de la clase HotelBD.
     */
    public HotelBD() {
    }

    /**
     * Constructor de la clase HotelBD con parámetros.
     * @param id_hotel String El ID del hotel.
     * @param nombreHotel String El nombre del hotel.
     * @param latitud BigDecimal La latitud del hotel.
     * @param longitud BigDecimal La longitud del hotel.
     */
    public HotelBD(String id_hotel, String nombreHotel, BigDecimal latitud, BigDecimal longitud) {
        super();
        this.id_hotel = id_hotel;
        this.nombre_hotel = nombreHotel;
        this.latitud = latitud;
        this.longitud = longitud;
    }

    /**
     * Devuelve el ID del hotel.
     * @return String del ID del hotel. Ejemplo "BWLON799"
     */
    public String getId_hotel() {
        return id_hotel;
    }

    /**
     * Actualiza el ID del hotel.
     * @param id_hotel Deber ser un String. Ejemplo "MNCH423V"
     */
    public void setId_hotel(String id_hotel) {
        this.id_hotel = id_hotel;
    }

    /**
     * Devuelve la dirección del hotel.
     * @return Instancia de Direccion.
     */
    public Direccion getDireccion() {
        return direccion;
    }

    /**
     * Actualiza la dirección del hotel.
     * @param direccion Debe ser una instancia de Direccion.
     */
    public void setDireccion(Direccion direccion) {
        this.direccion = direccion;
    }

    /**
     * Devuelve el nombre del hotel.
     * @return String nombre del hotel. Ejemplo "BEST WESTERN PREMIER BAYER HOF"
     */
    public String getNombre_hotel() {
        return nombre_hotel;
    }

    /**
     * Actualiza el nombre del hotel.
     * @param nombre_hotel Debe ser un String. Ejemplo "AC BY MARRIOTT AVENIDA AMERICA"
     */
    public void setNombre_hotel(String nombre_hotel) {
        this.nombre_hotel = nombre_hotel;
    }
    
    /**
     * Devuelve la latitud del hotel.
     * @return BigDecimal latitud del hotel. Ejemplo 43.235231
     */
    public BigDecimal getLatitud() {
        return latitud;
    }

    /**
     * Actualiza la latitud del hotel.
     * @param latitud Debe ser un Big Decimal. Ejemplo -2.353453
     */
    public void setLatitud(BigDecimal latitud) {
        this.latitud = latitud;
    }

    /**
     * Devuelve la longitud del hotel.
     * @return BigDecimal longitud del hotel. Ejemplo 23.13456432
     */
    public BigDecimal getLongitud() {
        return longitud;
    }

    /**
     * Actualiza la longitud del hotel.
     * @param longitud Debe ser un BigDecimal. Ejemplo 29.1342113
     */
    public void setLongitud(BigDecimal longitud) {
        this.longitud = longitud;
    }
    
    /**
     * Devuelve la lista de habitaciones asociadas al hotel.
     * @return List<Habitacion> lista de habitacion que pertenecen al hotel.
     */
    public List<Habitacion> getHabitaciones() {
        return habitaciones;
    }

    /**
     * Actualiza la lista de habitaciones del hotel.
     * @param habitaciones Debe ser una lista que solo acepte instancias de Habitacion.
     */
    public void setHabitaciones(List<Habitacion> habitaciones) {
        this.habitaciones = habitaciones;
    }
    
    /**
     * Agrega una habitación a la lista de habitaciones del hotel.
     * En caso de no tener ninguna habitacion asociada creara una lista y añadiara la habitacion
     * @param habitacion Debe ser una instancia de Habitacion.
     */
    public void addHabitacion(Habitacion habitacion) {
        if(this.habitaciones == null) {
            this.habitaciones = new ArrayList<Habitacion>();
        }
        this.habitaciones.add(habitacion);
        habitacion.setHotelBD(this);
    }
    
    /**
     * Quita una habitación de la lista de habitaciones del hotel.
     * Y elimina la relacion entre el hotel y la Habitacion
     * @param habitacion Instancia de la habitacion que queremos quitar.
     */
    public void quitarHabitacion(Habitacion habitacion) {
        if(this.habitaciones != null) {
            this.habitaciones.remove(habitacion);
            habitacion.setHotelBD(null);
        }
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(direccion, id_hotel, nombre_hotel);
    }

    @Override
    public String toString() {
        return "Hotel [id_hotel=" + id_hotel + ", direccion=" + direccion + ", nombre_hotel=" + nombre_hotel
                + ", habitaciones=" + habitaciones + "]";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        HotelBD other = (HotelBD) obj;
        return Objects.equals(direccion, other.direccion) && Objects.equals(id_hotel, other.id_hotel)
                && Objects.equals(nombre_hotel, other.nombre_hotel);
    }

}
