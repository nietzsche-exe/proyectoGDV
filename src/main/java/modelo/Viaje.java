package modelo;

import java.io.Serializable;


import java.util.Objects;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "viaje", schema = "gestion_viajes")
public class Viaje implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_viaje")
    private Integer id_viaje;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario")
    private Usuario usuario;
        
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval = true)
    @JoinColumn(name = "id_habitacion")
    private Habitacion habitacion;
    
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name = "id_vuelo")
    private DatosVuelo datos_vuelo;
	
    @Column(name = "numero_viajeros")
    private Integer numeroViajeros;
    
	public Viaje() {
		
	}

	public Viaje(Usuario usuario, Integer numeroViajeros) {
		super();
		this.usuario = usuario;
		this.numeroViajeros=numeroViajeros;
	}
	
	


	public Integer getNumeroViajeros() {
		return numeroViajeros;
	}

	public void setNumeroViajeros(Integer numeroViajeros) {
		this.numeroViajeros = numeroViajeros;
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
	
	public DatosVuelo getDatos_vuelo() {
		return datos_vuelo;
	}

	public void setDatos_vuelo(DatosVuelo datos_vuelo) {
		this.datos_vuelo = datos_vuelo;
	}

	@Override
	public int hashCode() {
		return Objects.hash(datos_vuelo, habitacion, id_viaje, numeroViajeros, usuario);
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
		return Objects.equals(datos_vuelo, other.datos_vuelo) && Objects.equals(habitacion, other.habitacion)
				&& Objects.equals(id_viaje, other.id_viaje) && Objects.equals(numeroViajeros, other.numeroViajeros)
				&& Objects.equals(usuario, other.usuario);
	}

	@Override
	public String toString() {
		return "Viaje [id_viaje=" + id_viaje + ", usuario=" + usuario + ", habitacion=" + habitacion + ", datos_vuelo="
				+ datos_vuelo + ", numeroViajeros=" + numeroViajeros + "]";
	}


	
	
	
	
	
}
