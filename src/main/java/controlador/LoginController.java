package controlador;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.HibernateUtils;
import modelo.Usuario;
import util.EmailValidator;

import java.util.List;
import java.util.UUID;

import java.io.IOException;

import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void procesarPeticion(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		response.setContentType("text/html;charset=UTF-8");
		String nombreUsuario = "", password = "", passwordRe = "", email = "hola";
		String token = "";

		String codVerificacion = "";

		String operacion = request.getParameter("opcion");
		if (operacion == null) {
			operacion = "";
		}

		RequestDispatcher rd;

		switch (operacion) {

		case "registrarse": // es el servidor quien redirije internamente hacia la vista registrarse

		    rd = request.getRequestDispatcher("registro.jsp");
		    rd.forward(request, response);
		    	
			break;
		case "registrarNuevoUsuario":// Se realiza el insert de un nuevo usuario en la base de datos

			nombreUsuario = request.getParameter("nombreUsuario");
			password = request.getParameter("contrasenia");
			passwordRe = request.getParameter("contraseniaRe");
			email = request.getParameter("correoUsuario");
			String extensionCorreo = email.substring(email.length() - 10, email.length());
			EntityManager em1 = modelo.HibernateUtils.getEmf().createEntityManager();
			try {
				Query q1 = em1.createQuery("FROM Usuario");
				List<Usuario> usuarios = q1.getResultList();
				for (Usuario user : usuarios) {

					if (user.getEmail().compareTo(email) == 0) {
						request.setAttribute("error", "El correo electronico ya esta en uso");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (user.getNombre().compareTo(nombreUsuario) == 0) {
						request.setAttribute("error", "El nombre de usuario ya esta en uso");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					}

				}
				if ((password.compareTo(passwordRe) != 0)) {
					request.setAttribute("error", "Las contraseñas debe coincidir");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				} else if (extensionCorreo.compareTo("@gmail.com") != 0) {
					System.out.println(email.substring(email.length() - 10, email.length()));
					request.setAttribute("error", "Correo no valido");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				} else if (!(password.matches(".*[A-Z].*"))) {
					request.setAttribute("error", "La contraseña debe contener como mínimo una mayuscula");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				} else if (!(password.matches(".*[0-9].*"))) {
					request.setAttribute("error", "La contraseña debe contener un numero");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				} else if (nombreUsuario.matches(".*[!¡@#$%^&*()¿?¬~].*")) {
					request.setAttribute("error", "El nombre de usuario no debe contener un caracter especial");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				} else if (nombreUsuario.length() < 3) {
					request.setAttribute("error", "El nombre de usuario debe ser superior a 3 caracteres");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				} else if (!(password.matches(".*[!¡@#$%^&*()¿?¬~].*"))) {
					request.setAttribute("error", "La contraseña debe contener como mínimo un caracter especial");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				} else if ((password.length() < 8) || (password.length() > 20)) {
					request.setAttribute("error",
							"La contraseña no puede ser inferior a los 8 caracteres ni superior a los 20");
					request.getRequestDispatcher("registro.jsp").forward(request, response);
				}

				// Try catch exceptiones java.lang.IllegalStateException
				else {
					// Guardar los datos del usuario y el token de confirmación en la sesión del
					// usuario
					request.getSession().setAttribute("nombreUsuario", nombreUsuario);
					request.getSession().setAttribute("password", password);
					request.getSession().setAttribute("email", email);
					System.out.println(nombreUsuario + " " + password + " " + email);
					token = generarToken();
					System.out.println("Token creado: " + token);
					EmailValidator.enviarCorreo(email, token);
					request.getSession().setAttribute("token", token);
					System.out.println("Correo enviado");
					// Redirigir a una página para que el usuario confirme su correo electrónico
					// request.setAttribute("token", token);
					request.getRequestDispatcher("confirmar_correo.jsp").forward(request, response);

				}
			} catch (IllegalStateException e) {
				System.out.println(e.getMessage());
			}
			break;
		case "verificarCorreo":
			codVerificacion = request.getParameter("cod_verificacion");
			nombreUsuario = (String) request.getSession().getAttribute("nombreUsuario");
			password = (String) request.getSession().getAttribute("password");
			email = (String) request.getSession().getAttribute("email");
			token = (String) request.getSession().getAttribute("token");
			System.out.println(nombreUsuario + " " + password + " " + email);
			System.out.println("TokenDef: " + token);
			System.out.println("codVeri: " + codVerificacion);
			if (token.compareTo(codVerificacion) != 0) {
				request.setAttribute("token", token);
				request.setAttribute("email", email);
				request.setAttribute("error", "Codigo de verificacion incorrecto");
				request.getRequestDispatcher("confirmar_correo.jsp").forward(request, response);
			} else {
				Usuario nuevoUsuario = new Usuario(nombreUsuario, password, email, false);
				System.out.println(nuevoUsuario);
				EntityManager em2 = HibernateUtils.getEmf().createEntityManager();
				EntityTransaction transacion = em2.getTransaction();
				try {
					transacion.begin();
					em2.persist(nuevoUsuario);
					transacion.commit();
					System.out.println("Usuario Subido");
				} catch (Exception e) {
					System.err.println(e.getMessage());
					transacion.rollback();
				} finally {
					em2.close();
				}
				response.sendRedirect("login.jsp");
			}
			break;

		case "perfil": // es el cliente quien deber� invocar a este recurso
			response.sendRedirect("perfilUsuario.jsp");
			break;
		case "NuevoViaje": // es el cliente quien invoca este recurso al presionar el oton de Crear Viaje
			response.sendRedirect("nuevoViaje.jsp");
			break;
		case "iniciarSesion":
			// Obtén los valores de los campos de nombre de usuario y contraseña del
			// formulario
			email = request.getParameter("correoUsuario");
			password = request.getParameter("contrasenia");

			// Realiza la verificación con la base de datos
			EntityManager em = HibernateUtils.getEmf().createEntityManager();
			Query consulta = em.createQuery("SELECT u FROM Usuario u WHERE u.email = :correo");
			consulta.setParameter("correo", email);
			try {
				Usuario usuario = (Usuario) consulta.getSingleResult();

				if (usuario != null && usuario.getContrasenia().equals(password)) {
					// Almacena los datos del usuario en la sesión
					HttpSession session = request.getSession();
					session.setAttribute("usuario", usuario);
					// Redirige a la página de perfil
					response.sendRedirect("perfilUsuario.jsp");
				} else {
					// Si las credenciales no son válidas, redirige de nuevo al formulario de inicio
					// de sesión con un mensaje de error
					request.setAttribute("error", "Nombre de usuario o contraseña incorrectos");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}

			} catch (NoResultException e) {
				request.setAttribute("error", "Nombre de usuario o contraseña incorrectas");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			} finally {
				em.close();
			}
			break;
		case "Loger":
			response.sendRedirect("login.jsp");
			break;
		case "cambiar_tema":
			
		    HttpSession session = request.getSession();
		    Usuario usuario = (Usuario) session.getAttribute("usuario");
		    int idUsuario = usuario.getId_usuario();

		  	
		    EntityManagerFactory emf = HibernateUtils.getEmf();
		    EntityManager em2 = emf.createEntityManager();
		    EntityTransaction transaction = null;

		    try {
		    	
		        transaction = em2.getTransaction();
		        transaction.begin();

		       	
		        Usuario user = em2.find(Usuario.class, idUsuario);

		      	
		        if (user != null) {
		         	
		            user.setTema(!user.getTema()); 	

		            
		            em2.merge(user);
		            transaction.commit();
		        }

		       	
		        response.sendRedirect("perfilUsuario.jsp");
		    } catch (Exception e) {
		        	
		        if (transaction != null && transaction.isActive()) {
		            transaction.rollback();
		        }
		        e.printStackTrace();
		    } finally {
		        	
		    	em2.close();
		    }
		    break;

		case "config":
			
			response.sendRedirect("configuracion.jsp");
			break;
		
		case "validarUser":
			nombreUsuario= request.getParameter("nombreUsuario");
			
		    HttpSession session2 = request.getSession();
		    Usuario usuario2 = (Usuario) session2.getAttribute("usuario");
		    int idUsuario2 = usuario2.getId_usuario();

		    EntityManagerFactory emf2 = HibernateUtils.getEmf();
		    EntityManager em3 = emf2.createEntityManager();
		    EntityTransaction transaction2 = null;
		    
		    Query q1 = em3.createQuery("FROM Usuario");
			List<Usuario> usuarios = q1.getResultList();
			
		    for (Usuario user : usuarios) {

				if (user.getNombre().compareTo(nombreUsuario) == 0) {
					request.setAttribute("error", "El nombre de usuario ya esta en uso");
					request.getRequestDispatcher("configuracion.jsp?datPer=true").forward(request, response);
				}

			}
		    
		    try {
		    	transaction2 = em3.getTransaction();
		    	transaction2.begin();

		        Usuario user = em3.find(Usuario.class, idUsuario2);

		        if (user != null) {
		            user.setNombre(nombreUsuario); 
		            
		            em3.merge(user);
		            
		            transaction2.commit();
		        }

		        response.sendRedirect("configuracion.jsp?datPer=true");
		    } catch (Exception e) {
		        if (transaction2 != null && transaction2.isActive()) {
		        	transaction2.rollback();
		        }
		        e.printStackTrace();
		    } finally {
		    	em3.close();
		    }
		    break;
		
		case "validar_tema":
		    HttpSession session3 = request.getSession();
		    Usuario usuario3 = (Usuario) session3.getAttribute("usuario");
		    int idUsuario3 = usuario3.getId_usuario();
		    
		    EntityManagerFactory emf3 = HibernateUtils.getEmf();
		    EntityManager em4 = emf3.createEntityManager();
		    EntityTransaction transaction3 = null;

		    try {
		    	transaction3 = em4.getTransaction();
		        transaction3.begin();

		        Usuario user = em4.find(Usuario.class, idUsuario3);

		        if (user != null) {
		            user.setTema(!user.getTema());

		            em4.merge(user);
		            transaction3.commit();
		        }

		        response.sendRedirect("configuracion.jsp?datPer=true");
		    } catch (Exception e) {
		        if (transaction3 != null && transaction3.isActive()) {
		        	transaction3.rollback();
		        }
		        e.printStackTrace();
		    } finally {
		    	em4.close();
		    }
		    break;
		
		    
		case "validar_correo":
			
			email = request.getParameter("emailUsuario");
			String extensionCorreo2 = email.substring(email.length() - 10, email.length());
			EntityManagerFactory emf4 = HibernateUtils.getEmf();
		    EntityManager em5 = emf4.createEntityManager();
			
		    Query q2 = em5.createQuery("FROM Usuario");
			List<Usuario> usuarios2 = q2.getResultList();
			for (Usuario user : usuarios2) {

				if (user.getEmail().compareTo(email) == 0) {
					request.setAttribute("error", "El correo electronico ya esta en uso");
					request.getRequestDispatcher("configuracion.jsp?datPer=true").forward(request, response);
				}

			}
			if (extensionCorreo2.compareTo("@gmail.com") != 0) {
				System.out.println(email.substring(email.length() - 10, email.length()));
				request.setAttribute("error", "Correo no valido");
				request.getRequestDispatcher("configuracion.jsp?datPer=true").forward(request, response);
			}
			else {
				request.getSession().setAttribute("email", email);
				
				token = generarToken();
				System.out.println("Token creado: " + token);
				
				EmailValidator.enviarCorreo(email, token);
				request.getSession().setAttribute("token", token);
				System.out.println("Correo enviado");
				
				request.getRequestDispatcher("confirmar_correo2.jsp").forward(request, response);
			}
			
			break;
		    
		case "verificarCorreo2":
			HttpSession session4 = request.getSession();
		    Usuario usuario4 = (Usuario) session4.getAttribute("usuario");
		    int idUsuario4 = usuario4.getId_usuario();
		    
			codVerificacion = request.getParameter("cod_verificacion");
			email = (String) request.getSession().getAttribute("email");
			token = (String) request.getSession().getAttribute("token");
			System.out.println("TokenDef: " + token);
			System.out.println("codVeri: " + codVerificacion);
			if (token.compareTo(codVerificacion) != 0) {
				request.setAttribute("token", token);
				request.setAttribute("email", email);
				request.setAttribute("error", "Codigo de verificacion incorrecto");
				request.getRequestDispatcher("confirmar_correo.jsp").forward(request, response);
			} else {
				
				EntityManager em6 = HibernateUtils.getEmf().createEntityManager();
				EntityTransaction transaction4 = em6.getTransaction();
				
				try {
					transaction4.begin();
					
					Usuario user = em6.find(Usuario.class, idUsuario4);

			        if (user != null) {
			            user.setEmail(email); 

			            em6.merge(user);
			            transaction4.commit();
			        }
			        
					System.out.println("Usuario Subido");
				} catch (Exception e) {
					System.err.println(e.getMessage());
					transaction4.rollback();
				} finally {
					em6.close();
				}
				response.sendRedirect("configuracion.jsp?datPer=true");
			}
			break;
			
		default:
			response.sendRedirect("index.jsp");
		}

	}

	private String generarToken() {
		return UUID.randomUUID().toString();
	}

	/**
	 * Método controlador para las peticiones HTTP GET que delega al método
	 * `procesarPeticion`.
	 *
	 * @param request  Objeto de solicitud HTTP servlet.
	 * @param response Objeto de respuesta HTTP servlet.
	 * @throws IOException      si hay un error de entrada o salida mientras el
	 *                          servlet está manejando la solicitud.
	 * @throws ServletException si la solicitud GET no se pudo manejar.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		procesarPeticion(request, response);
	}

	/**
	 * Método controlador para las peticiones HTTP POST que delega al método
	 * `procesarPeticion`.
	 *
	 * @param request  Objeto de solicitud HTTP servlet.
	 * @param response Objeto de respuesta HTTP servlet.
	 * @throws IOException      si hay un error de entrada o salida mientras el
	 *                          servlet está manejando la solicitud.
	 * @throws ServletException si la solicitud POST no se pudo manejar.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		procesarPeticion(request, response);
	}

}
