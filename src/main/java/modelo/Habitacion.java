package modelo;

import java.io.Serializable;

import java.time.LocalDate;
import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

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

	@ManyToOne
	@JoinColumn(name = "id_hotel")
	private Hotel hotel;
	
	@OneToOne(mappedBy = "habitacion", cascade = CascadeType.ALL)
	private Viaje viaje;
	
	public Habitacion() {
		
	}
	
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


	public String getId_habitacion() {
		return id_habitacion;
	}

	public void setId_habitacion(String id_habitacion) {
		this.id_habitacion = id_habitacion;
	}

	public Hotel getHotel() {
		return hotel;
	}

	public void setHotel(Hotel hotel) {
		this.hotel = hotel;
	}

	public LocalDate getFecha_entrada() {
		return fecha_entrada;
	}

	public void setFecha_entrada(LocalDate fecha_entrada) {
		this.fecha_entrada = fecha_entrada;
	}

	public LocalDate getFecha_salida() {
		return fecha_salida;
	}

	public void setFecha_salida(LocalDate fecha_salida) {
		this.fecha_salida = fecha_salida;
	}

	public Integer getHabitacion_disponible() {
		return habitacion_disponible;
	}

	public void setHabitacion_disponible(Integer habitacion_disponible) {
		this.habitacion_disponible = habitacion_disponible;
	}

	public Integer getNumero_camas() {
		return numero_camas;
	}

	public void setNumero_camas(Integer numero_camas) {
		this.numero_camas = numero_camas;
	}

	public String getTipo_cama() {
		return tipo_cama;
	}

	public void setTipo_cama(String tipo_cama) {
		this.tipo_cama = tipo_cama;
	}

	public Double getPrecio_noche() {
		return precio_noche;
	}

	public void setPrecio_noche(Double precio_noche) {
		this.precio_noche = precio_noche;
	}

	public Double getPrecio_total() {
		return precio_total;
	}

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
					+ ", hotel=[id=" + this.getHotel().getId_hotel() + ", nombre="+this.getHotel().getNombre_hotel()+"]]";
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
