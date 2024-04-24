package modelo;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name="usuarios", schema="gestion_viajes")
public class Usuario implements Serializable{

	private static final long serialVersionUID = 1L;
	
	public Usuario() {
	
	}
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id_usuario;
	
	@Column(name="nombre_usuario")
	private String nombre;
	
	@Column(name="contraseña")
	private String contrasenia;
	
	@Column(name="email")
	private String email;
	
	@Column(name="modo_oscuro")
	private Boolean tema;
	
	
	public Usuario(String nombre, String contrasenia, String email) {
		super();
		this.nombre = nombre;
		this.contrasenia = contrasenia;
		this.email = email;
	}

	public Integer getId_usuario() {
		return id_usuario;
	}

	public void setId_usuario(Integer id_usuario) {
		this.id_usuario = id_usuario;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getContrasenia() {
		return contrasenia;
	}

	public void setContrasenia(String contrasenia) {
		this.contrasenia = contrasenia;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Boolean getTema() {
		return tema;
	}

	public void setTema(Boolean tema) {
		this.tema = tema;
	}

	
	@Override
	public int hashCode() {
		return Objects.hash(contrasenia, email, id_usuario, nombre);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Usuario other = (Usuario) obj;
		return Objects.equals(contrasenia, other.contrasenia) && Objects.equals(email, other.email)
				&& Objects.equals(id_usuario, other.id_usuario) && Objects.equals(nombre, other.nombre);
	}
	
	
	
}
