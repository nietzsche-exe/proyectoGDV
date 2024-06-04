package modelo;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

/**
 * Esta clase representa un viaje realizado por un usuario.
 * @author Grupo 5
 * @since 2024
 */
@Entity
@Table(name = "viaje", schema = "gestion_viajes")
public class Viaje implements Serializable{

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_viaje")
    private Integer id_viaje;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario")
    private Usuario usuario;
        
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    @JoinColumn(name = "id_habitacion")
    private Habitacion habitacion;
    
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name = "id_vuelo")
    private DatosVuelo datos_vuelo;
    
    @Column(name = "numero_viajeros")
    private Integer numeroViajeros;
    
    /**
     * Constructor por defecto de la clase Viaje.
     */
    public Viaje() {
        
    }

    /**
     * Constructor de la clase Viaje con parámetros.
     * @param usuario Usuario El usuario que realiza el viaje.
     * @param numeroViajeros Integer El número de viajeros en el viaje.
     */
    public Viaje(Usuario usuario, Integer numeroViajeros) {
        super();
        this.usuario = usuario;
        this.numeroViajeros = numeroViajeros;
    }
    

    /**
     * Devuelve el número de viajeros en el viaje.
     * @return Integer El número de viajeros. Ejemplo 2
     */
    public Integer getNumeroViajeros() {
        return numeroViajeros;
    }

    /**
     * Actualiza el número de viajeros en el viaje.
     * @param numeroViajeros Deber ser un Integer. Ejemplo 3
     */
    public void setNumeroViajeros(Integer numeroViajeros) {
        this.numeroViajeros = numeroViajeros;
    }

    /**
     * Devuelve el ID del viaje.
     * @return Integer El ID del viaje. Ejemplo 20
     */
    public Integer getId_viaje() {
        return id_viaje;
    }

    /**
     * Actualiza el ID del viaje.
     * @param id_viaje Debe ser un Integer. Ejemplo 52
     */
    public void setId_viaje(Integer id_viaje) {
        this.id_viaje = id_viaje;
    }

    /**
     * Devuelve el usuario que realiza el viaje.
     * @return instancia de Usuario.
     */
    public Usuario getUsuario() {
        return usuario;
    }

    /**
     * Actualiza el usuario que realiza el viaje.
     * @param usuario Debe ser una instancia de Usuario.
     */
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    /**
     * Devuelve la habitación asociada al viaje.
     * @return Habitacion habitacion del viaje.
     */
    public Habitacion getHabitacion() {
        return habitacion;
    }

    /**
     * Actualiza la habitación asociada al viaje.
     * @param habitacion Debe ser una instancia de Habitacion.
     */
    public void setHabitacion(Habitacion habitacion) {
        this.habitacion = habitacion;
    }
    
    /**
     * Devuelve los datos de vuelo asociados al viaje.
     * @return DatosVuelo informacion de la oferta de vuelo.
     */
    public DatosVuelo getDatos_vuelo() {
        return datos_vuelo;
    }

    /**
     * Actualiza los datos de vuelo asociados al viaje.
     * @param datos_vuelo Debe ser una instancia de DatosVuelo.
     */
    public void setDatos_vuelo(DatosVuelo datos_vuelo) {
        this.datos_vuelo = datos_vuelo;
    }

    @Override
    public int hashCode() {
        return Objects.hash(datos_vuelo, habitacion, id_viaje, numeroViajeros, usuario);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Viaje other = (Viaje) obj;
        return Objects.equals(datos_vuelo, other.datos_vuelo) && Objects.equals(habitacion, other.habitacion)
                && Objects.equals(id_viaje, other.id_viaje) && Objects.equals(numeroViajeros, other.numeroViajeros)
                && Objects.equals(usuario, other.usuario);
    }

    @Override
    public String toString() {
        return "Viaje [id_viaje=" + id_viaje + ", usuario=" + usuario + ", habitacion=" + habitacion + ", datos_vuelo="
                + datos_vuelo + ", numeroViajeros=" + numeroViajeros + "]";
    }

}
