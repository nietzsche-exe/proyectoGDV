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
 * Esta clase representa los datos de una oferta de vuelo
 */
@Entity
@Table(name = "datosVuelo", schema = "gestion_viajes")
public class DatosVuelo implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_vuelo")
    private Integer id_vuelo;

    @Column(name = "aeropuerto_origen")
    private String aeropuertoOrigen;

    @Column(name = "ciudad_origen")
    private String ciudadOrigen;

    @Column(name = "nombre_compañia_aerea")
    private String companiaAerea;

    @Column(name = "ciudad_destino")
    private String ciudadDestino;

    @Column(name = "aeropuerto_destino")
    private String aeropuertoDestino;

    @Column(name = "tipo_viajero")
    private String tipoViajero;

    @Column(name = "precio_medio")
    private Double precioMedio;
    
    @Column(name = "clase")
    private String clase;
    
    @OneToOne(mappedBy = "datos_vuelo", cascade = CascadeType.ALL, orphanRemoval = true)
    private Viaje viaje;
    
    /**
     * Constructor por defecto de la clase DatosVuelo
     */
	public DatosVuelo() {
		super();
	}
	
	/**
	 * Constructor con parámetros. 
	 * @param aeropuertoOrigen String Nombre del Aeropuerto de Origen
	 * @param ciudadOrigen String Nombre de la Ciudad de origen
	 * @param companiaAerea String Iniciales de la compañia aerea
	 * @param ciudadDestino String Nombre de la Ciudad de destino
	 * @param aeropuertoDestino String Nombre del Aeropuerto Destino
	 * @param tipoViajero String grupo al que pertenece el viajero: ADULT
	 * @param precioMedio Double Precio del vuelo
	 * @param clase	String Clase del asiento: Economy, Business
	 */
	public DatosVuelo(String aeropuertoOrigen, String ciudadOrigen, String companiaAerea, String ciudadDestino,
			String aeropuertoDestino, String tipoViajero, Double precioMedio, String clase) {
		super();
		this.aeropuertoOrigen = aeropuertoOrigen;
		this.ciudadOrigen = ciudadOrigen;
		this.companiaAerea = companiaAerea;
		this.ciudadDestino = ciudadDestino;
		this.aeropuertoDestino = aeropuertoDestino;
		this.tipoViajero = tipoViajero;
		this.precioMedio = precioMedio;
		this.clase = clase;
	}
	
	/**
	 * Devuelve el ID de la oferta de vuelo
	 * @return Integer id del vuelo.	Ejemplo: 1
	 */
	public Integer getId_vuelo() {
		return id_vuelo;
	}

	/**
	 * Actualiza el ID de la oferta de vuelo
	 * @param id_vuelo	Debe ser un Integer.	Ejemplo 23
	 */
	public void setId_vuelo(Integer id_vuelo) {
		this.id_vuelo = id_vuelo;
	}

	/**
	 * Devuelve el nombre de el Aeropuerto de Origen de la oferta de vuelo
	 * @return	String nombre completo del Aeropuerto de origen. Ejemplo	"ADOLFO SUAREZ BARAJAS"
	 */
	public String getAeropuertoOrigen() {
		return aeropuertoOrigen;
	}

	/**
	 * Actualiza el nombre de el Aeropuerto de Origen de la oferta de vuelo
	 * @param aeropuertoOrigen	Debe ser un String	Ejemplo "Malaga Airport"
	 */
	public void setAeropuertoOrigen(String aeropuertoOrigen) {
		this.aeropuertoOrigen = aeropuertoOrigen;
	}

	/**
	 * Devuelve el nombre de la ciudad de origen de la oferta de vuelo
	 * @return	String nombre de la ciudad de origen	Ejemplo "Madrid"
	 */
	public String getCiudadOrigen() {
		return ciudadOrigen;
	}

	/**
	 * Actualiza el nombre de la ciudad de origen de la oferta de vuelo 
	 * @param ciudadOrigen	Debe ser un String	Ejemplo"Malaga"
	 */
	public void setCiudadOrigen(String ciudadOrigen) {
		this.ciudadOrigen = ciudadOrigen;
	}
	
	/**
	 * Devuelve las iniciales de la compañia Aerea encargada de la oferta de vuelo
	 * @return	String iniciales de la compañia	Ejemplo Air Europa = "UX"
	 */
	public String getCompaniaAerea() {
		return companiaAerea;
	}
	
	/**
	 * Actualiza las iniciales de la compañia aerea
	 * @param companiaAerea	Debe ser un String	Ejemplo Iberia = "IB"
	 */
	public void setCompaniaAerea(String companiaAerea) {
		this.companiaAerea = companiaAerea;
	}

	/**
	 * Devuelve el nombre de la ciudad de destino de la oferta de vuelo
	 * @return	String 	Nombre de la ciudad destino Ejemplo	"London"
	 */
	public String getCiudadDestino() {
		return ciudadDestino;
	}

	/**
	 * Actualiza el nombre de la ciudad de destino de la oferta de vuelo
	 * @param ciudadDestino	Debe se un String Ejemplo "Munich"
	 */
	public void setCiudadDestino(String ciudadDestino) {
		this.ciudadDestino = ciudadDestino;
	}

	/**
	 * Devuelve el nombre del Aeropuerto destino de la oferta de vuelo
	 * @return	String Nombre del Aeropuerto destino 	Ejemplo	"Heathrow"
	 */
	public String getAeropuertoDestino() {
		return aeropuertoDestino;
	}

	/**
	 * Actualiza el nombre del Aeropuerto Destino de la oferta de vuelo
	 * @param aeropuertoDestino	Debe ser un String Ejemplo "Munich International"
	 */
	public void setAeropuertoDestino(String aeropuertoDestino) {
		this.aeropuertoDestino = aeropuertoDestino;
	}

	/**
	 * Devuelve el Tipo de Viajero de la oferta de vuelo
	 * @return	String tipo de viajero	Ejemplo "Adult"
	 */
	public String getTipoViajero() {
		return tipoViajero;
	}

	/**
	 * Actualiza el tipo de viajero de la oferta de vuelo
	 * @param tipoViajero	Debe ser un String Ejemplo	"Child"
	 */
	public void setTipoViajero(String tipoViajero) {
		this.tipoViajero = tipoViajero;
	}

	/**
	 * Devuelve el precio Total de la oferta de vuelo
	 * @return	Double precio total	Ejemplo	108.98
	 */
	public Double getPrecioMedio() {
		return precioMedio;
	}

	/**
	 * Actualizar el precio total de la oferta de vuelo
	 * @param precioMedio	Debe ser un Double Ejemplo	230.50
	 */
	public void setPrecioMedio(Double precioMedio) {
		this.precioMedio = precioMedio;
	}

	/**
	 * Devuelva la clase del Asiento de la oferta de vuelo
	 * @return	String clase del Asiento Ejemplo "ECONOMY"
	 */
	public String getClase() {
		return clase;
	}

	/**
	 * Actualiza la Clase del Asiento de la oferta de vuelo
	 * @param clase	Debe ser un String Ejemplo Business
	 */
	public void setClase(String clase) {
		this.clase = clase;
	}

	@Override
	public int hashCode() {
		return Objects.hash(aeropuertoDestino, aeropuertoOrigen, ciudadDestino, ciudadOrigen, clase, companiaAerea,
				id_vuelo, precioMedio, tipoViajero);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DatosVuelo other = (DatosVuelo) obj;
		return Objects.equals(aeropuertoDestino, other.aeropuertoDestino)
				&& Objects.equals(aeropuertoOrigen, other.aeropuertoOrigen)
				&& Objects.equals(ciudadDestino, other.ciudadDestino)
				&& Objects.equals(ciudadOrigen, other.ciudadOrigen) && Objects.equals(clase, other.clase)
				&& Objects.equals(companiaAerea, other.companiaAerea) && Objects.equals(id_vuelo, other.id_vuelo)
				&& Objects.equals(precioMedio, other.precioMedio) && Objects.equals(tipoViajero, other.tipoViajero);
	}
	
	
}
