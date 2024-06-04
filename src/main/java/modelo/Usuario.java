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
/**
 * Esta clase representa un usuario en la base de datos.
 * @author Grupo 5
 * @since 2024
 */
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
	
	/**
     * Devuelve la lista de viajes del usuario.
     * @return Lista de viajes asociadas al usuario.
     */
    public List<Viaje> getViajes() {
        return viajes;
    }

    /**
     * Actualiza la lista de viajes del usuario.
     * @param viajes Debe ser una Lista que solo acepte instancias de Viaje.
     */
    public void setViajes(List<Viaje> viajes) {
        this.viajes = viajes;
    }
    
    /**
     * Agrega un viaje a la lista de viajes del usuario.
     * Si es la primera vez que el usuario añade un Viaje antes de añadirse se creara una lista.
     * @param viaje Debe ser una instancia de Viaje.
     */
    public void addViaje(Viaje viaje) {
        if(this.viajes == null) {
            this.viajes = new ArrayList<Viaje>();
        }
        this.viajes.add(viaje);
        viaje.setUsuario(this);
    }
    
    /**
     * Quita un viaje de la lista de viajes del usuario.
     * @param viaje Debe ser una instancia de Viaje.
     */
    public void quitarViaje(Viaje viaje) {
        if(this.viajes != null) {
            this.viajes.remove(viaje);
            viaje.setUsuario(null);
        }
    }

    /**
     * Constructor de la clase Usuario con parámetros.
     * @param nombre String El nombre del usuario.
     * @param contrasenia String La contraseña del usuario.
     * @param email String El email del usuario.
     * @param tema String El tema del usuario.
     * @param sexo String El sexo del usuario.
     * @param Boolean num_telefono El número de teléfono del usuario.
     * @param LocalDate fecha_nacimiento La fecha de nacimiento del usuario.
     * @param LocalDate ultima_modificacion_contrasenna La fecha de última modificación de la contraseña del usuario.
     * @param Boolean sesionActiva El estado de la sesión del usuario.
     */
    public Usuario(String nombre, String contrasenia, String email, Boolean tema, String sexo, String num_telefono, 
            LocalDate fecha_nacimiento, LocalDate ultima_modificacion_contrasenna, Boolean sesionActiva) {
        
        this.nombre = nombre;
        this.contrasenia = contrasenia;
        this.email = email;
        this.tema = tema;
        this.sexo = sexo;
        this.num_telefono = num_telefono;
        this.fecha_nacimiento = fecha_nacimiento;
        this.ultima_modificacion_contrasenna = ultima_modificacion_contrasenna;
        this.sesionActiva = sesionActiva;
    }

    /**
     * Devuelve el ID del usuario.
     * @return Integer Id del usuario. Ejemplo 2
     */
	public Integer getId_usuario() {
		return id_usuario;
	}

	/**
	 * Actualiza el ID del usuario.
	 * @param id_usuario Debe ser un Integer. Ejemplo 44
	 */
	public void setId_usuario(Integer id_usuario) {
		this.id_usuario = id_usuario;
	}

	/**
	 * Devuelve el Nombre de usuario del usuario
	 * @return String nombre del usuario. Ejemplo "Adpo23"
	 */
	public String getNombre() {
		return nombre;
	}

	/**
	 * Actualiza el nombre de usuario del usuario.
	 * @param nombre Debe ser un String. Ejemplo "Koliac2"
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	/**
	 * Devuelve la contraseña del usuario.
	 * @return String contraseña del usuario. Ejemplo "passs231!"
	 */
	public String getContrasenia() {
		return contrasenia;
	}

	/**
	 * Actualiza la contraseña del usuario.
	 * @param contrasenia String contraseña del usuario. Ejemplo "poliko42!%"
	 */
	public void setContrasenia(String contrasenia) {
		this.contrasenia = contrasenia;
	}

	/**
	 * Devuelve el correo electronico del usuario.
	 * @return String correo electronico del usuario. Ejemplo "pruebear2@gmail.com"
	 */
	public String getEmail() {
		return email;
	}
	
	/**
	 * Actualiza el correo electronico del usuario.
	 * @param email Deber ser un String. Ejemplo "juliar24@gmail.com"
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * Devuelve el Tema de la pagina false=claro, 1=True.
	 * @return Boolean tema de visualizacion de la pagina. Ejemplo False = Claro
	 */
	public Boolean getTema() {
		return tema;
	}

	/**
	 * Actualiza el tema de la pagina.
	 * @param tema	Debe ser un boolean. Ejemplo True=Oscuro.
	 */
	public void setTema(Boolean tema) {
		this.tema = tema;
	}
	
	/**
	 * Devuelve la fecha de la ultima conexion que realizo el usuario en la pagina web.
	 * @return	LocalDateTime ultima conexion ultima vez que el usuario ingreso a la pagina web. Ejemplo 2024-02-15 12:52:00
	 */
	public LocalDateTime  getUltima_conexion() {
		return ultima_conexion;
	}

	/**
	 * Actualiza la fecha en la que el usuario ingreso a la pagina web 
	 * @param ultima_conexion	Debe ser un LocalDateTime. Ejemplo 2024-05-03 06:08:25	
	 */
	public void setUltima_conexion(LocalDateTime  ultima_conexion) {
		this.ultima_conexion = ultima_conexion;
	}

	/**
	 * Devuelve la fecha en la que el usuario ingreso a la pagina web
	 * @return	LocalDateTime ultima conexion. Ejemplo 2024-02-15 12:52:00
	 */
	public LocalDateTime  getUltima_conexion_temporal() {
		return ultima_conexion_temporal;
	}

	/**
	 * Actualiza la fecha en la que el usuario ingreso a la pagina web 
	 * @param ultima_conexion_temporal	Debe ser un LocalDateTime. Ejemplo 2024-05-03 06:08:25	
	 */
	public void setUltima_conexion_temporal(LocalDateTime  ultima_conexion_temporal) {
		this.ultima_conexion_temporal = ultima_conexion_temporal;
	}

	/**
	 * Devuelve el sexo del usuario.
	 * @return	String sexo del usuario. Ejemplo "Masculino"
	 */
	public String getSexo() {
		return sexo;
	}

	/**
	 * Actualiza el sexo del Usuario
	 * @param sexo	Debe ser un String. Ejemplo "Femenino"
	 */
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	/**
	 * Devuelve el numero de telefono del usuario.
	 * @return	String numero de telefono del usuario. Ejemplo "661535849"
	 */
	public String getNum_telefono() {
		return num_telefono;
	}

	/**
	 * Actualiza el numero de telefono del usuario.
	 * @param num_telefono deber ser un String. Ejemplo "623535941"
	 */
	public void setNum_telefono(String num_telefono) {
		this.num_telefono = num_telefono;
	}

	/**
	 * Devuelve la ultima vez en la que el usuario cambio su contraseña
	 * @return LocalDate ultima vez en la que usuario modifico su contraseña. Ejemplo 2024-2-06-25
	 */
	public LocalDate getUltima_modificacion_contrasenna() {
		return ultima_modificacion_contrasenna;
	}

	/**
	 * Actualiza la ultima vez en la que el usuario cambio su contraseña
	 * @param ultima_modificacion_contrasenna Debe ser un LocalDate. Ejemplo 2024-08-10
	 */
	public void setUltima_modificacion_contrasenna(LocalDate ultima_modificacion_contrasenna) {
		this.ultima_modificacion_contrasenna = ultima_modificacion_contrasenna;
	}

	/**
	 * Devuelve la fecha de nacimiento del usuario.
	 * @return LocalDate fecha de nacimiento del usuario. Ejemplo 2000-05-12
	 */
	public LocalDate getFecha_nacimiento() {
		return fecha_nacimiento;
	}
	
	/**
	 * Actualiza la fecha de nacimiento del usuario.
	 * @param fecha_nacimiento Debe ser un LocalDate. Ejemplo 1998-03-20
	 */
	public void setFecha_nacimiento(LocalDate fecha_nacimiento) {
		this.fecha_nacimiento = fecha_nacimiento;
	}
	
	/**
	 * Devuelve el estado de la sesion del usuario
	 * @return	Boolean estado de la sesion. False True=Activa 
	 */
	public Boolean getSesionActiva() {
		return sesionActiva;
	}

	/**
	 * Actualiza el estado de la sesion del usuario
	 * @param sesionActiva Debe ser un boolean. Ejemplo False = Inactiva
	 */
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
