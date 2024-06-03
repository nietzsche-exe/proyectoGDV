package util;

/**
 * Clase encargada de crear Instancias de coordenadas a partir de la latitud y longitud de los hoteles
 */
public class Coordenada {

	String latitude;
	String longitude;
	
	/**
	 * Constructor de Coordenada con Parametros
	 * @param String latitude
	 * @param String longitude
	 */
	public Coordenada(String latitude, String longitude) {
		this.latitude = latitude;
		this.longitude = longitude;
	}
	
}
