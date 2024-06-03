package util;

/**
 * Clase encargada de almacenar los datos del hotel y habitacion de la API de Amadeus
 */
public class HotelData {

	private String nombre;
    private String direccion;
    private String codPaisDestino;
    private String nomPaisDestino;
    private String codigoHotel;
    private String latitud;
    private String longitud;
    private String idOferta;
    private String fechaEntrada;
    private String fechaSalida;
    private String valoracion;
    private boolean disponible;
    private String tipoHabitacion;
    private String categoriaHabitacion;
    private int numeroCamas;
    private String tipoCama;
    private String descripcion;
    private int numeroAdultos;
    private int numeroNinos;
    private double precioNoche;
    private double precioTotal;
	
    /**
     * Constructor por defecto sin Parametros
     */
    public HotelData() {
		super();
	}
    
    /**
     * Devuelve el nombre del hotel
     * @return String nombre del Hotel. Ejemplo "AC BY MARRIOTT HOTEL ATOCHA" 
     */
	public String getNombre() {
		return nombre;
	}

	/**
	 * Actualiza el nombre del hotel.
	 * @param nombre Debe ser un String. Ejemplo "BEST WESTERN HOTEL PICCADILLY"
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	/**
	 * Devuelve la direccion del hotel
	 * @return String direccion del hotel. Ejemplo "3409 Paradise Rd, Las Vegas, NV 89109, EE. UU."
	 */
	public String getDireccion() {
		return direccion;
	}

	/**
	 * Actualiza la direccion del hotel.
	 * @param direccion debe ser un String. Ejemplo "Carrer dels Tellinaires, 38, 08850 Gavà, Barcelona, España"
	 */
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	
	/**
	 * Devuelve el codigo IATA del Pais al que pertenece el hotel.
	 * @return String codigo del pais del hotel. Ejemplo "ES"
	 */
	public String getCodPaisDestino() {
		return codPaisDestino;
	}

	/**
	 * Actualiza el codigo IATA del Pais al que pertenece el hotel.
	 * @param codPaisDestino Debe ser un String. Ejemplo "UK"
	 */
	public void setCodPaisDestino(String codPaisDestino) {
		this.codPaisDestino = codPaisDestino;
	}

	/**
	 * Devuelve el nombre del Pais destino al que pertenece el hotel.
	 * @return String nombre del Pais al que pertenece el hotel. Ejemplo "Spain"
	 */
	public String getNomPaisDestino() {
		return nomPaisDestino;
	}

	/**
	 * Actualiza el nombre del Pais destino al que pertenece el hotel.
	 * @param nomPaisDestino Debe ser un String. Ejemplo "Germany"
	 */
	public void setNomPaisDestino(String nomPaisDestino) {
		this.nomPaisDestino = nomPaisDestino;
	}

	/**
	 * Devuelve el codigo de identificacion del hotel.
	 * @return String ID del hotel. Ejemplo "ARMADAVE"
	 */
	public String getCodigoHotel() {
		return codigoHotel;
	}

	/**
	 * Actualiza el codigo de identificacion del hotel.
	 * @param codigoHotel Debe ser un String. Ejemplo "BWMUC367"
	 */
	public void setCodigoHotel(String codigoHotel) {
		this.codigoHotel = codigoHotel;
	}

	/**
	 * Devuelve la latitud del hotel.
	 * @return String latitud del hotel. Ejemplo "23.0959734"
	 */
	public String getLatitud() {
		return latitud;
	}

	/**
	 * Actualiza la latitud del hotel
	 * @param latitud Debe ser un String. Ejemplo "-12.542453"
	 */
	public void setLatitud(String latitud) {
		this.latitud = latitud;
	}

	/**
	 * Devuelve la longitud del hotel.
	 * @return String longitud del hotel. Ejemplo "-98.12351346"
	 */
	public String getLongitud() {
		return longitud;
	}

	/**
	 * Actualiza la longitud del hotel.
	 * @param longitud Debe ser un String. Ejemplo "45.0987292"
	 */
	public void setLongitud(String longitud) {
		this.longitud = longitud;
	}

	/**
	 * Devuelve el codigo de identificaion de la oferta de la habitacion
	 * @return String ID de la oferta de la habitacion. Ejemplo "DDPSZN17P0"
	 */
	public String getIdOferta() {
		return idOferta;
	}

	/**
	 * Actualiza el codigo de identificacion de la oferta del habitacion.
	 * @param idOferta Debe ser in String. Ejemplo "GZ58E8NUZE"
	 */
	public void setIdOferta(String idOferta) {
		this.idOferta = idOferta;
	}

	/**
	 * Devuelve la fecha de entrada a la habitacion.
	 * @return	String fecha de entrada a la habitacion. Ejemplo "2024-04-12"
	 */
	public String getFechaEntrada() {
		return fechaEntrada;
	}

	/**
	 * Actualiza la fecha de entrada a la habitacion
	 * @param fechaEntrada Debe ser un String. Ejemplo "2024-08-25"
	 */
	public void setFechaEntrada(String fechaEntrada) {
		this.fechaEntrada = fechaEntrada;
	}

	/**
	 * Devuelve la fecha de salida a la habitacion.
	 * @return	String fecha de salida a la habitacion. Ejemplo "2024-05-20"
	 */
	public String getFechaSalida() {
		return fechaSalida;
	}
	
	/**
	 * Actualiza la fecha de salida a la habitacion
	 * @param fechaSalida Debe ser un String. Ejemplo "2024-10-14"
	 */
	public void setFechaSalida(String fechaSalida) {
		this.fechaSalida = fechaSalida;
	}

	/**
	 * Devueleve la valoracion que recibio la habitacion
	 * @return String valoracion de la habitacion. Ejemplo "AAA"
	 */
	public String getValoracion() {
		return valoracion;
	}

	/**
	 * Actualiza la valoracion que recibe la habitacion
	 * @param valoracion Debe ser un String. Ejemplo "R9A"
	 */
	public void setValoracion(String valoracion) {
		this.valoracion = valoracion;
	}

	/**
	 * Devuelve el estado de la habitacion.
	 * @return Boolean estado de la habitacion. Ejemplo False= No disponible
	 */
	public boolean isDisponible() {
		return disponible;
	}

	/**
	 * Actualiza el estado de la habitacion.
	 * @param disponible Debe ser un Boolean. Ejemplo True= Disponible
	 */
	public void setDisponible(boolean disponible) {
		this.disponible = disponible;
	}

	/**
	 * Devuelve el tipo de habitacion.
	 * @return String Tipo de habitacion.
	 */
	public String getTipoHabitacion() {
		return tipoHabitacion;
	}

	/**
	 * Actualiza el tipo de habitacion.
	 * @param tipoHabitacion Debe ser un String.
	 */
	public void setTipoHabitacion(String tipoHabitacion) {
		this.tipoHabitacion = tipoHabitacion;
	}

	/**
	 * Devuelve la categoria de la habitacion.
	 * @return String categoria de la habitacion.
	 */
	public String getCategoriaHabitacion() {
		return categoriaHabitacion;
	}

	/**
	 * Actualiza la categoria de la habitacion
	 * @param categoriaHabitacion Debe ser un String.
	 */
	public void setCategoriaHabitacion(String categoriaHabitacion) {
		this.categoriaHabitacion = categoriaHabitacion;
	}

	/**
	 * Devuelve el numero de camas de la habitacion
	 * @return int numero de camas. Ejemplo 2
	 */
	public int getNumeroCamas() {
		return numeroCamas;
	}

	/**
	 * Actualiza el numero de camas de la habitacion.
	 * @param numeroCamas Debe ser un int. Ejemplo 1
	 */
	public void setNumeroCamas(int numeroCamas) {
		this.numeroCamas = numeroCamas;
	}

	/**
	 * Devuelve el Tipo de Cama que tiene la Habitacion
	 * @return String  tipo de cama.
	 */
	public String getTipoCama() {
		return tipoCama;
	}

	/**
	 * Actualiza el tipo de cama que tiene la habitacion
	 * @param tipoCama Debe ser un String.
	 */
	public void setTipoCama(String tipoCama) {
		this.tipoCama = tipoCama;
	}

	/**
	 * Devuelve la descripcion con informacion sobre la habitacion
	 * @return String descripcion sobre la habitacion.
	 */
	public String getDescripcion() {
		return descripcion;
	}

	/**
	 * Actualiza la descripcion sobre la habitacion.
	 * @param descripcion Debe ser un String.
	 */
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	/**
	 * Devuelve el numero de adultos que hay en la habitacion.
	 * @return int numero de adultos en la habitacion. Ejemplo 2
	 */
	public int getNumeroAdultos() {
		return numeroAdultos;
	}

	/**
	 * Actualiza el numero de adultos que hay en la habitacion.
	 * @param numeroAdultos debe ser un int. Ejemplo 3
	 */
	public void setNumeroAdultos(int numeroAdultos) {
		this.numeroAdultos = numeroAdultos;
	}

	/**
	 * Devuelve el numero de menores de edad que hay en la habitacion.
	 * @return int numero de menores de edad en la habitacion. Ejemplo 2
	 */
	public int getNumeroNinos() {
		return numeroNinos;
	}

	/**
	 * Actualiza el numero de menores de edad que hay en la habitacion.
	 * @param numeroNiños debe ser un int. Ejemplo 3
	 */
	public void setNumeroNinos(int numeroNinos) {
		this.numeroNinos = numeroNinos;
	}

	/**
	 * Devuelve el precio por noche de la habitacion.
	 * @return	double precio pr noche de la habitacion. Ejemplo 23.53
	 */
	public double getPrecioNoche() {
		return precioNoche;
	}

	/**
	 * Actualiza el precio por noche de la habitacion.
	 * @param precioNoche Deve ser un double. Ejemplo 123.32
	 */
	public void setPrecioNoche(double precioNoche) {
		this.precioNoche = precioNoche;
	}

	/**
	 * Devuelve el precio por la estancia completa en la habitacion.
	 * @return double precio total por la estancia completa en la habitacion. Ejemplo 103.34
	 */
	public double getPrecioTotal() {
		return precioTotal;
	}

	/**
	 * Actualiza el precio por la estancia completa en la habitacion.
	 * @param double precio total por la estancia completa en la habitacion. Ejemplo 153.34
	 */
	public void setPrecioTotal(double precioTotal) {
		this.precioTotal = precioTotal;
	}

	@Override
	public String toString() {
		return "HotelData [nombre=" + nombre + ", direccion=" + direccion + ", codPaisDestino=" + codPaisDestino
				+ ", nomPaisDestino=" + nomPaisDestino + ", codigoHotel=" + codigoHotel + ", latitud=" + latitud
				+ ", longitud=" + longitud + ", idOferta=" + idOferta + ", fechaEntrada=" + fechaEntrada
				+ ", fechaSalida=" + fechaSalida + ", valoracion=" + valoracion + ", disponible=" + disponible
				+ ", tipoHabitacion=" + tipoHabitacion + ", categoriaHabitacion=" + categoriaHabitacion
				+ ", numeroCamas=" + numeroCamas + ", tipoCama=" + tipoCama + ", descripcion=" + descripcion
				+ ", numeroAdultos=" + numeroAdultos + ", numeroNinos=" + numeroNinos + ", precioNoche=" + precioNoche
				+ ", precioTotal=" + precioTotal + "]";
	}
    
    
    
    

}
