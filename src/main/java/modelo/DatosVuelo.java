package modelo;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

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
    
    @OneToOne(mappedBy = "datos_vuelo")
    private Viaje viaje;
    
	public DatosVuelo() {
		super();
	}
	
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
	
	public Integer getId_vuelo() {
		return id_vuelo;
	}

	public void setId_vuelo(Integer id_vuelo) {
		this.id_vuelo = id_vuelo;
	}

	public String getAeropuertoOrigen() {
		return aeropuertoOrigen;
	}


	public void setAeropuertoOrigen(String aeropuertoOrigen) {
		this.aeropuertoOrigen = aeropuertoOrigen;
	}

	public String getCiudadOrigen() {
		return ciudadOrigen;
	}

	public void setCiudadOrigen(String ciudadOrigen) {
		this.ciudadOrigen = ciudadOrigen;
	}

	public String getCompaniaAerea() {
		return companiaAerea;
	}

	public void setCompaniaAerea(String companiaAerea) {
		this.companiaAerea = companiaAerea;
	}

	public String getCiudadDestino() {
		return ciudadDestino;
	}

	public void setCiudadDestino(String ciudadDestino) {
		this.ciudadDestino = ciudadDestino;
	}

	public String getAeropuertoDestino() {
		return aeropuertoDestino;
	}

	public void setAeropuertoDestino(String aeropuertoDestino) {
		this.aeropuertoDestino = aeropuertoDestino;
	}

	public String getTipoViajero() {
		return tipoViajero;
	}

	public void setTipoViajero(String tipoViajero) {
		this.tipoViajero = tipoViajero;
	}

	public Double getPrecioMedio() {
		return precioMedio;
	}

	public void setPrecioMedio(Double precioMedio) {
		this.precioMedio = precioMedio;
	}

	public String getClase() {
		return clase;
	}

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
