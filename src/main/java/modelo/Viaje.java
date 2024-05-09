package modelo;

import java.io.Serializable;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "viaje", schema = "gestion_viajes")
public class Viaje implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "id_viaje")
	private Integer id_viaje;
	
	//@OneToOne
	//@JoinColumn(name = "id_usuario")
	@Column(name="id_usuario")
	private Integer id_usuario;
	
	@Column(name = "id_habitacion")
	private String id_habitacion;
	/*
	@OneToMany(mappedBy = "viaje")
	private List<Habitacion> habitaciones;
	*/
	public Viaje(Integer id_viaje, Integer id_usuario, String id_habitacion) {
		super();
		this.id_viaje = id_viaje;
		this.id_usuario = id_usuario;
		this.id_habitacion = id_habitacion;
	}

	public Integer getId_viaje() {
		return id_viaje;
	}

	public void setId_viaje(Integer id_viaje) {
		this.id_viaje = id_viaje;
	}

	public Integer getId_usuario() {
		return id_usuario;
	}

	public void setId_usuario(Integer id_usuario) {
		this.id_usuario = id_usuario;
	}

	public String getId_habitacion() {
		return id_habitacion;
	}

	public void setId_habitacion(String id_habitacion) {
		this.id_habitacion = id_habitacion;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id_habitacion, id_usuario, id_viaje);
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
		return Objects.equals(id_habitacion, other.id_habitacion) && Objects.equals(id_usuario, other.id_usuario)
				&& Objects.equals(id_viaje, other.id_viaje);
	}
	
	
	
}
