package modelo;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

/**
 * Esta clase representa la dirección de un hotel.
 * @author Grupo 5
 * @since 2024
 */
@Entity
@Table(name="direccion", schema = "gestion_viajes")
public class Direccion implements Serializable{

    private static final long serialVersionUID = 1L;

    /**
     * Constructor por defecto de la clase Direccion.
     */
    public Direccion () {
        
    }
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_direccion")
    private Integer id_direccion;

    @Column(name = "cod_pais")
    private String codigo_pais;

    @Column(name = "pais")
    private String nombre_pais;

    @Column(name = "cod_ciudad")
    private String codigo_ciudad;

    @Column(name = "ciudad")
    private String nombre_ciudad;

    @Column(name = "calle")
    private String nombre_calle;

    @OneToOne(mappedBy = "direccion", cascade = CascadeType.ALL)
    private HotelBD hotel;
    
    /**
     * Devuelve el hotel asociado a esta dirección.	Ejemplo
     * @return El hotel asociado	Objeto tipo HotelBD.
     */
    public HotelBD getHotel() {
        return hotel;
    }

    /**
     * Actualiza el hotel asociado a esta dirección. 
     * @param hotel Debe ser un Objeto de tipo HotelBD.
     */
    public void setHotel(HotelBD hotel) {
        this.hotel = hotel;
    }
    
    /**
     * Constructor de la clase Direccion con parámetros.
     * @param codigo_pais String El código del país.
     * @param nombre_pais String El nombre del país.
     * @param codigo_ciudad String El código de la ciudad.
     * @param nombre_ciudad String El nombre de la ciudad.
     * @param nombre_calle String El nombre de la calle.
     */
    public Direccion(String codigo_pais, String nombre_pais, String codigo_ciudad,
            String nombre_ciudad, String nombre_calle) {
        super();
        this.codigo_pais = codigo_pais;
        this.nombre_pais = nombre_pais;
        this.codigo_ciudad = codigo_ciudad;
        this.nombre_ciudad = nombre_ciudad;
        this.nombre_calle = nombre_calle;
    }

    /**
     * Devuelve el ID de la dirección.
     * @return Integer El ID de la dirección	Ejemplo 12.
     */
    public Integer getId_direccion() {
        return id_direccion;
    }

    /**
     * Actualiza el ID de la dirección.
     * @param id_direccion Debe ser un Integer	Ejemplo 20.
     */
    public void setId_direccion(Integer id_direccion) {
        this.id_direccion = id_direccion;
    }

    /**
     * Devuelve el código del país.
     * @return String El código del país	Ejemplo "ES".
     */
    public String getCodigo_pais() {
        return codigo_pais;
    }

    /**
     * Actualiza el código del país.
     * @param codigo_pais  Debe ser un String	Ejemplo "UK".
     */
    public void setCodigo_pais(String codigo_pais) {
        this.codigo_pais = codigo_pais;
    }

    /**
     * Devuelve el nombre del país.
     * @return String El nombre del país	Ejemplo "España".
     */
    public String getNombre_pais() {
        return nombre_pais;
    }

    /**
     * Actualiza el nombre del país.
     * @param nombre_pais Debe ser un String	Ejemplo "Alemania".
     */
    public void setNombre_pais(String nombre_pais) {
        this.nombre_pais = nombre_pais;
    }

    /**
     * Devuelve el código de la ciudad.
     * @return	String Codigo de la ciudad	Ejemplo "MAD".
     */
    public String getCodigo_ciudad() {
        return codigo_ciudad;
    }

    /**
     * Actualiza el código de la ciudad.
     * @param codigo_ciudad Debe ser un String. Ejemplo"LON"
     */
    public void setCodigo_ciudad(String codigo_ciudad) {
        this.codigo_ciudad = codigo_ciudad;
    }

    /**
     * Devuelve el nombre de la ciudad.
     * @return String del nombre de la ciudad.	Ejemplo "Madrid"
     */
    public String getNombre_ciudad() {
        return nombre_ciudad;
    }

    /**
     * Actualiza el nombre de la ciudad.
     * @param nombre_ciudad	Debe ser un String.	Ejemplo "London"
     */
    public void setNombre_ciudad(String nombre_ciudad) {
        this.nombre_ciudad = nombre_ciudad;
    }

    /**
     * Devuelve el nombre de la calle.
     * @return String del nombre de la calle Ejemplo "C. Mar Cantabric, 3, 08174 Sant Cugat del Vallès, Barcelona, España".
     */
    public String getNombre_calle() {
        return nombre_calle;
    }

    /**
     * Actualiza el nombre de la calle.
     * @param nombre_calle Debe ser un String.	Ejemplo "1 Western Gateway, London E16 1XL, Reino Unido"
     */
    public void setNombre_calle(String nombre_calle) {
        this.nombre_calle = nombre_calle;
    }

    @Override
    public int hashCode() {
        return Objects.hash(codigo_ciudad, codigo_pais, id_direccion, nombre_calle, nombre_ciudad,
                nombre_pais);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Direccion other = (Direccion) obj;
        return Objects.equals(codigo_ciudad, other.codigo_ciudad) && Objects.equals(codigo_pais, other.codigo_pais)
                && Objects.equals(id_direccion, other.id_direccion) && Objects.equals(nombre_calle, other.nombre_calle)
                && Objects.equals(nombre_ciudad, other.nombre_ciudad) && Objects.equals(nombre_pais, other.nombre_pais);
    }
    
    @Override
    public String toString() {
        if(this.hotel==null) {
            return "Direccion [id_direccion=" + id_direccion + ", codigo_pais=" + codigo_pais + ", nombre_pais="
                    + nombre_pais + ", codigo_ciudad=" + codigo_ciudad + ", nombre_ciudad=" + nombre_ciudad
                    + ", nombre_calle=" + nombre_calle + ", hotel=" + null + "]";            
        }
        return "Direccion [id_direccion=" + id_direccion + ", codigo_pais=" + codigo_pais + ", nombre_pais="
                    + nombre_pais + ", codigo_ciudad=" + codigo_ciudad + ", nombre_ciudad=" + nombre_ciudad
                    + ", nombre_calle=" + nombre_calle + ", hotel=" + hotel.getId_hotel() + "]";            

    }
    
}
