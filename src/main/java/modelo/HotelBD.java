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

	public HotelBD() {
	}

	public HotelBD(String id_hotel, String nombreHotel, BigDecimal latitud
			, BigDecimal longitud) {
		super();
		this.id_hotel = id_hotel;
		this.nombre_hotel=nombreHotel;
		this.latitud=latitud;
		this.longitud=longitud;
	}

	public String getId_hotel() {
		return id_hotel;
	}

	public void setId_hotel(String id_hotel) {
		this.id_hotel = id_hotel;
	}

	public Direccion getDireccion() {
		return direccion;
	}

	public void setDireccion(Direccion direccion) {
		this.direccion = direccion;
	}

	public String getNombre_hotel() {
		return nombre_hotel;
	}

	public void setNombre_hotel(String nombre_hotel) {
		this.nombre_hotel = nombre_hotel;
	}
	
	public BigDecimal getLatitud() {
	    return latitud;
	}

	public void setLatitud(BigDecimal latitud) {
	    this.latitud = latitud;
	}

	public BigDecimal getLongitud() {
	    return longitud;
	}

	public void setLongitud(BigDecimal longitud) {
	    this.longitud = longitud;
	}
	
	public List<Habitacion> getHabitaciones() {
		return habitaciones;
	}

	public void setHabitaciones(List<Habitacion> habitaciones) {
		this.habitaciones=habitaciones;
	}
	
	public void addHabitacion(Habitacion habitacion) {
		if(this.habitaciones==null) {
			this.habitaciones=new ArrayList<Habitacion>();
		}
		this.habitaciones.add(habitacion);
		habitacion.setHotelBD(this);
	}
	
	public void quitarHabitacion(Habitacion habitacion) {
		if(this.habitaciones!=null) {
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
