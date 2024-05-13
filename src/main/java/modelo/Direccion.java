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
@Table(name="direccion", schema = "gestion_viajes")
public class Direccion implements Serializable{

	private static final long serialVersionUID = 1L;
	
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
	
	@Column(name = "cod_postal")
	private String codigo_postal;
	
	@Column(name = "calle")
	private String nombre_calle;
	
	@OneToOne(mappedBy = "direccion")
	private Hotel hotel;
	
	public Hotel getHotel() {
	    return hotel;
	}

	public void setHotel(Hotel hotel) {
	    this.hotel = hotel;
	}
	
	public Direccion(Integer id_direccion, String codigo_pais, String nombre_pais, String codigo_ciudad,
			String nombre_ciudad, String codigo_postal, String nombre_calle) {
		super();
		this.id_direccion = id_direccion;
		this.codigo_pais = codigo_pais;
		this.nombre_pais = nombre_pais;
		this.codigo_ciudad = codigo_ciudad;
		this.nombre_ciudad = nombre_ciudad;
		this.codigo_postal = codigo_postal;
		this.nombre_calle = nombre_calle;
	}

	public Integer getId_direccion() {
		return id_direccion;
	}

	public void setId_direccion(Integer id_direccion) {
		this.id_direccion = id_direccion;
	}

	public String getCodigo_pais() {
		return codigo_pais;
	}

	public void setCodigo_pais(String codigo_pais) {
		this.codigo_pais = codigo_pais;
	}

	public String getNombre_pais() {
		return nombre_pais;
	}

	public void setNombre_pais(String nombre_pais) {
		this.nombre_pais = nombre_pais;
	}

	public String getCodigo_ciudad() {
		return codigo_ciudad;
	}

	public void setCodigo_ciudad(String codigo_ciudad) {
		this.codigo_ciudad = codigo_ciudad;
	}

	public String getNombre_ciudad() {
		return nombre_ciudad;
	}

	public void setNombre_ciudad(String nombre_ciudad) {
		this.nombre_ciudad = nombre_ciudad;
	}

	public String getCodigo_postal() {
		return codigo_postal;
	}

	public void setCodigo_postal(String codigo_postal) {
		this.codigo_postal = codigo_postal;
	}

	public String getNombre_calle() {
		return nombre_calle;
	}

	public void setNombre_calle(String nombre_calle) {
		this.nombre_calle = nombre_calle;
	}

	@Override
	public int hashCode() {
		return Objects.hash(codigo_ciudad, codigo_pais, codigo_postal, id_direccion, nombre_calle, nombre_ciudad,
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
				&& Objects.equals(codigo_postal, other.codigo_postal)
				&& Objects.equals(id_direccion, other.id_direccion) && Objects.equals(nombre_calle, other.nombre_calle)
				&& Objects.equals(nombre_ciudad, other.nombre_ciudad) && Objects.equals(nombre_pais, other.nombre_pais);
	}
	
	@Override
	public String toString() {
		if(this.hotel==null) {
			return "Direccion [id_direccion=" + id_direccion + ", codigo_pais=" + codigo_pais + ", nombre_pais="
					+ nombre_pais + ", codigo_ciudad=" + codigo_ciudad + ", nombre_ciudad=" + nombre_ciudad
					+ ", codigo_postal=" + codigo_postal + ", nombre_calle=" + nombre_calle + ", hotel=" + null + "]";			
		}
		return "Direccion [id_direccion=" + id_direccion + ", codigo_pais=" + codigo_pais + ", nombre_pais="
					+ nombre_pais + ", codigo_ciudad=" + codigo_ciudad + ", nombre_ciudad=" + nombre_ciudad
					+ ", codigo_postal=" + codigo_postal + ", nombre_calle=" + nombre_calle + ", hotel=" + hotel.getId_hotel() + "]";			

	}
	
	
}
