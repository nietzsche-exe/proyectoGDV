package modelo;

import java.io.Serializable;

import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import jakarta.persistence.Table;

@Entity
@Table(name = "viaje", schema = "gestion_viajes")
public class Viaje implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "id_viaje")
	private Integer id_viaje;
	
	@ManyToOne
	@JoinColumn(name = "id_usuario")
	private Usuario usuario;
		
	@ManyToOne
    @JoinColumn(name = "id_habitacion")
    private Habitacion habitacion;
	
	public Viaje(Integer id_viaje, Usuario usuario, Habitacion habitacion) {
		super();
		this.id_viaje = id_viaje;
		this.usuario = usuario;
		this.habitacion = habitacion;
	}

	public Integer getId_viaje() {
		return id_viaje;
	}

	public void setId_viaje(Integer id_viaje) {
		this.id_viaje = id_viaje;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Habitacion getHabitacion() {
		return habitacion;
	}

	public void setHabitacion(Habitacion habitacion) {
		this.habitacion = habitacion;
	}

	@Override
	public int hashCode() {
		return Objects.hash(habitacion, usuario, id_viaje);
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
		return Objects.equals(habitacion, other.habitacion) && Objects.equals(usuario, other.usuario)
				&& Objects.equals(id_viaje, other.id_viaje);
	}

	@Override
	public String toString() {
		return "Viaje [id_viaje=" + id_viaje + ", usuario=" + usuario + ", habitacion=" + habitacion + "]";
	}
	
	
	
	
}
