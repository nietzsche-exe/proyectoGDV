package modelo;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

/**
 * Esta clase representa la habitación de un hotel.
 * @author Grupo 5
 * @since 2024
 */
@Entity
@Table(name = "habitacion", schema = "gestion_viajes")
public class Habitacion implements Serializable{

    private static final long serialVersionUID = 1L;
    
    @Id
    @Column(name = "id_habitacion")
    private String id_habitacion;

    @Column(name = "fecha_entrada")
    private LocalDate fecha_entrada;

    @Column(name = "fecha_salida")
    private LocalDate fecha_salida;

    @Column(name = "habitacion_disponible", insertable = false, updatable = false)
    private Integer habitacion_disponible;

    @Column(name = "num_cama")
    private Integer numero_camas;

    @Column(name = "tipo_cama")
    private String tipo_cama;

    @Column(name = "precio_noche")
    private Double precio_noche;

    @Column(name = "precio_total")
    private Double precio_total;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_hotel")
    private HotelBD hotel;

    @OneToOne(mappedBy = "habitacion")
    private Viaje viaje;
    
    /**
     * Constructor por defecto de la clase Habitacion.
     */
    public Habitacion() {
        
    }
    
    /**
     * Constructor de la clase Habitacion con parámetros.
     * @param id_habitacion String El ID de la habitación.
     * @param fecha_entrada LocalDate La fecha de entrada a la habitación.
     * @param fecha_salida LocalDate La fecha de salida de la habitación.
     * @param numero_camas Integer El número de camas en la habitación.
     * @param tipo_cama String El tipo de cama en la habitación.
     * @param precio_noche Double El precio por noche de la habitación.
     * @param precio_total Double El precio total de la habitación.
     */
    public Habitacion(String id_habitacion,  LocalDate fecha_entrada, LocalDate fecha_salida,
            Integer numero_camas, String tipo_cama, Double precio_noche,
            Double precio_total) {
        super();
        this.id_habitacion = id_habitacion;
        this.fecha_entrada = fecha_entrada;
        this.fecha_salida = fecha_salida;
        this.numero_camas = numero_camas;
        this.tipo_cama = tipo_cama;
        this.precio_noche = precio_noche;
        this.precio_total = precio_total;
    }

    /**
     * Devuelve el ID de la habitacion.
     * @return	String id del la habitacion. Ejemplo"XML5LO1"
     */
    public String getId_habitacion() {
        return id_habitacion;
    }

    /**
     * Actualiza el ID de la habitacion.
     * @param id_habitacion	Debe se un String. Ejemplo "KOL9M2NA"
     */
    public void setId_habitacion(String id_habitacion) {
        this.id_habitacion = id_habitacion;
    }

    /**
     * Devuelve el Hotel asociado a la habitacion.
     * @return	HotelBD	instancia del hotel al que esta asociado.
     */
    public HotelBD getHotelBD() {
        return hotel;
    }

    /**
     * Acualiza el hotel al que esta asociado la habitacion.
     * @param hotel	Debe ser una instancia de HotelBD
     */
    public void setHotelBD(HotelBD hotel) {
        this.hotel = hotel;
    }

    /**
     * Devuelve la fecha a la que se entra a la Habitacion.
     * @return	LocalDate fecha de entrada a la habitacion. Ejemplo 2024-06-01
     */
    public LocalDate getFecha_entrada() {
        return fecha_entrada;
    }

    /**
     * Actualiza la fecha de entrada a la Habitacion
     * @param fecha_entrada	Debe ser un LocalDate. Ejemplo 2024-06-20
     */
    public void setFecha_entrada(LocalDate fecha_entrada) {
        this.fecha_entrada = fecha_entrada;
    }

    /**
   	 *Devuelve la fecha de la que se sale de la Habitacion.
     * @return	LocalDate fecha de salida de la habitacion. Ejemplo 2024-06-11
     */
    public LocalDate getFecha_salida() {
        return fecha_salida;
    }
    /**
     *Actualiza la fecha de salida de la Habitacion.
     * @param fecha_salida Debe ser un LocalDate. Ejemplo 2024-06-01
     */
    public void setFecha_salida(LocalDate fecha_salida) {
        this.fecha_salida = fecha_salida;
    }

    /**
     * Devuelve si la habitacion esta disponible.
     * @return	Integer disponibilidad de la habitacion. Ejemplo 1 = Disponible
     */
    public Integer getHabitacion_disponible() {
        return habitacion_disponible;
    }

    /**
     * Actualiza si la habitacion esta disponible.
     * @param habitacion_disponible Debe ser un Integer. Ejemplo 0 = No esta disponible
     */
    public void setHabitacion_disponible(Integer habitacion_disponible) {
        this.habitacion_disponible = habitacion_disponible;
    }

    /**
     * Devuelve el numero de camas con las que cuenta la habitacion.
     * @return	Integer numero de camas. Ejemplo 2
     */
    public Integer getNumero_camas() {
        return numero_camas;
    }

    /**
     * Actualiza el numero de camas con las que cuenta una habitacion.
     * @param numero_camas	Debe ser un Integer. Ejemplo 3
     */
    public void setNumero_camas(Integer numero_camas) {
        this.numero_camas = numero_camas;
    }

    /**
     * Devuelve el Tipo de cama que tiene la Habitacion
     * @return	String tipo de cama. Ejemplo "KING"
     */
    public String getTipo_cama() {
        return tipo_cama;
    }

    /**
     * Actualiza el Tipo de cama que tiene la Habitacion
     * @param tipo_cama	Debe ser un String. Ejemplo "SINGLE"
     */
    public void setTipo_cama(String tipo_cama) {
        this.tipo_cama = tipo_cama;
    }

    /**
     * Devuelve el precio por noche de la Habitacion.
     * @return Double precio por noche. Ejemplo 50.23
     */
    public Double getPrecio_noche() {
        return precio_noche;
    }

    /**
     * Actualiza el precio por noche de la Habitacion
     * @param precio_noche	Debe ser un Double.	Ejemplo "102.32"
     */
    public void setPrecio_noche(Double precio_noche) {
        this.precio_noche = precio_noche;
    }

    /**
     * Devuelve el precio por la estancia completa de la Habitacion
     * @return	Double precio total. Ejemplo 302.9
     */
    public Double getPrecio_total() {
        return precio_total;
    }

    /**
     * Actualiza el precio por la estancia completa de la Habitacion
     * @param precio_total	Deber ser un Double. Ejemplo 500.87
     */
    public void setPrecio_total(Double precio_total) {
        this.precio_total = precio_total;
    }
    

    @Override
    public String toString() {
        
        if(this.hotel==null) {
            return "Habitacion [id_habitacion=" + id_habitacion + ", fecha_entrada=" + fecha_entrada + ", fecha_salida="
                    + fecha_salida + ", habitacion_disponible=" + habitacion_disponible + ", numero_camas=" + numero_camas
                    + ", tipo_cama=" + tipo_cama + ", precio_noche=" + precio_noche + ", precio_total=" + precio_total
                    + ", hotel=" + null + "]";            
        }else
            return "Habitacion [id_habitacion=" + id_habitacion + ", fecha_entrada=" + fecha_entrada + ", fecha_salida="
                    + fecha_salida + ", habitacion_disponible=" + habitacion_disponible + ", numero_camas=" + numero_camas
                    + ", tipo_cama=" + tipo_cama + ", precio_noche=" + precio_noche + ", precio_total=" + precio_total
                    + ", hotel=[id=" + this.getHotelBD().getId_hotel() + ", nombre="+this.getHotelBD().getNombre_hotel()+"]]";
    }

    @Override
    public int hashCode() {
        return Objects.hash(fecha_entrada, fecha_salida, habitacion_disponible, id_habitacion, hotel, numero_camas,
                precio_noche, precio_total, tipo_cama);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Habitacion other = (Habitacion) obj;
        return Objects.equals(fecha_entrada, other.fecha_entrada) && Objects.equals(fecha_salida, other.fecha_salida)
                && Objects.equals(habitacion_disponible, other.habitacion_disponible)
                && Objects.equals(id_habitacion, other.id_habitacion) && Objects.equals(hotel, other.hotel)
                && Objects.equals(numero_camas, other.numero_camas) && Objects.equals(precio_noche, other.precio_noche)
                && Objects.equals(precio_total, other.precio_total) && Objects.equals(tipo_cama, other.tipo_cama);
    }

}
