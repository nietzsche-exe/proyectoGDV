package modelo;

import java.io.Serializable;

import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "hotel", schema = "gestion_viajes")
public class Hotel implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "id_hotel")
	private String id_hotel;
	
	//@OneToOne
	//@JoinColumn(name = "id_direccion")
	//private Direccion direccion_hotel;
	@Column(name = "id_direccion")
	private Integer id_direccion;	
	@Column(name = "nombre_hotel")
	private String nombre_hotel;

	
	public Hotel() {
		super();
	}

	public Hotel(String id_hotel, Integer id_direccion, String nombre_hotel) {
		super();
		this.id_hotel = id_hotel;
		this.id_direccion = id_direccion;
		this.nombre_hotel = nombre_hotel;
	}

	public String getId_hotel() {
		return id_hotel;
	}

	public void setId_hotel(String id_hotel) {
		this.id_hotel = id_hotel;
	}

	public Integer getid_direccion() {
		return id_direccion;
	}

	public void setid_direccion(Integer id_direccion) {
		this.id_direccion = id_direccion;
	}

	public String getNombre_hotel() {
		return nombre_hotel;
	}

	public void setNombre_hotel(String nombre_hotel) {
		this.nombre_hotel = nombre_hotel;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id_direccion, id_hotel, nombre_hotel);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Hotel other = (Hotel) obj;
		return Objects.equals(id_direccion, other.id_direccion) && Objects.equals(id_hotel, other.id_hotel)
				&& Objects.equals(nombre_hotel, other.nombre_hotel);
	}

	
	
}
