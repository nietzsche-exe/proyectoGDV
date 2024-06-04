package util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Esta clase se encarga de gestionar el acceso a claves y datos de acceso almacenados en un archivo properties
 * @author Grupo 5
 * @since 2024
 * @
 */
public class ConfigLoader {
	 private Properties properties;

	 /**
	  *  Constructor de la clase que instancia un objeto ConfigLoader
	  */
	    public ConfigLoader() {
	        properties = new Properties();
	        try (InputStream input = getClass().getClassLoader().getResourceAsStream("config.properties")) {
	            if (input == null) {
	                System.out.println("Sorry, unable to find config.properties");
	                return;
	            }
	            properties.load(input);
	        } catch (IOException ex) {
	            ex.printStackTrace();
	        }
	    }

	    /**
	     * Metodo get para acceder mediante una key al dato que sea necesario
	     * @param String key
	     */
	    public String getProperty(String key) {
	        return properties.getProperty(key);
	    }
}
