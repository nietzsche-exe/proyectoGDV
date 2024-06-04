package modelo;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Clase utilitaria para obtener la instancia de EntityManagerFactory.
 * @author Grupo 5
 * @since 2024
 */
public class HibernateUtils {
	 /**
     * Instancia de EntityManagerFactory.
     */
	private static EntityManagerFactory emf = Persistence.createEntityManagerFactory("GestionViajes");

	 /**
     * Método para obtener la instancia de EntityManagerFactory.
     *
     * @return Instancia de EntityManagerFactory.
     */
	public static EntityManagerFactory getEmf() {
		return emf;
	}
}