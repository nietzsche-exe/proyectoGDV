package modelo;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
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
	
	@Column(name="ultima_conexion")
	private LocalDateTime  ultima_conexion;
	
	@Column(name="ultima_conexion_temporal")
	private LocalDateTime  ultima_conexion_temporal;
	
	@Column(name="sexo")
	private String sexo;
	
	@Column(name="telefono")
	private String num_telefono;
	
	@Column(name="ultima_modificacion_contrasenna")
	private LocalDate ultima_modificacion_contrasenna;
	
	@Column(name="fecha_nacimiento")
	private LocalDate fecha_nacimiento;
	
	@Column(name="sesion_activa")
	private Boolean sesionActiva;
	
	@OneToMany(mappedBy = "usuario", cascade = CascadeType.ALL, orphanRemoval = true)
	private List<Viaje> viajes;
	

	public List<Viaje> getViajes() {
		return viajes;
	}

	public void setViajes(List<Viaje> viajes) {
		this.viajes = viajes;
	}
	
	public void addViaje(Viaje viaje) {
		if(this.viajes==null) {
			this.viajes=new ArrayList<Viaje>();
		}
		this.viajes.add(viaje);
		viaje.setUsuario(this);
	}
	
	public void quitarViaje(Viaje viaje) {
		if(this.viajes!=null) {
			this.viajes.remove(viaje);
			viaje.setUsuario(null);
		}
	}

	public Usuario(String nombre, String contrasenia, String email, Boolean tema, String sexo, String num_telefono, 
			LocalDate fecha_nacimiento, LocalDate ultima_modificacion_contrasenna ) {
		
		this.nombre = nombre;
		this.contrasenia = contrasenia;
		this.email = email;
		this.tema = tema;
		this.sexo = sexo;
		this.num_telefono = num_telefono;
		this.fecha_nacimiento = fecha_nacimiento;
		this.ultima_modificacion_contrasenna = ultima_modificacion_contrasenna;
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
	
	public LocalDateTime  getUltima_conexion() {
		return ultima_conexion;
	}

	public void setUltima_conexion(LocalDateTime  ultima_conexion) {
		this.ultima_conexion = ultima_conexion;
	}

	public LocalDateTime  getUltima_conexion_temporal() {
		return ultima_conexion_temporal;
	}

	public void setUltima_conexion_temporal(LocalDateTime  ultima_conexion_temporal) {
		this.ultima_conexion_temporal = ultima_conexion_temporal;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String getNum_telefono() {
		return num_telefono;
	}

	public void setNum_telefono(String num_telefono) {
		this.num_telefono = num_telefono;
	}

	public LocalDate getUltima_modificacion_contrasenna() {
		return ultima_modificacion_contrasenna;
	}

	public void setUltima_modificacion_contrasenna(LocalDate ultima_modificacion_contrasenna) {
		this.ultima_modificacion_contrasenna = ultima_modificacion_contrasenna;
	}

	public LocalDate getFecha_nacimiento() {
		return fecha_nacimiento;
	}

	public void setFecha_nacimiento(LocalDate fecha_nacimiento) {
		this.fecha_nacimiento = fecha_nacimiento;
	}
	
	public Boolean getSesionActiva() {
		return sesionActiva;
	}

	public void setSesionActiva(Boolean sesionActiva) {
		this.sesionActiva = sesionActiva;
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


	@Override
	public String toString() {
		return "Usuario [id_usuario=" + id_usuario + ", nombre=" + nombre + ", contrasenia=" + contrasenia + ", email="
				+ email + ", tema=" + tema + ", sexo=" + sexo + ", num_telefono=" + num_telefono + ", fecha_nacimiento="
				+ fecha_nacimiento + "]";
	}
	
}
