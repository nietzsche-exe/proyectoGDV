package controlador;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.DatosVuelo;
import modelo.Direccion;
import modelo.Habitacion;
import modelo.HibernateUtils;
import modelo.Hotel;
import modelo.Usuario;
import modelo.Viaje;
import util.EmailValidator;

import java.util.List;
import java.util.UUID;

import com.amadeus.Amadeus;
import com.amadeus.Params;
import com.amadeus.exceptions.ResponseException;
import com.amadeus.resources.City;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;


/**
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void procesarPeticion(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		response.setContentType("text/html;charset=UTF-8");
		String nombreUsuario = "", password = "", passwordRe = "", email = "hola", telefono = "", sexo = "";
		
		LocalDate fecha_nacimiento = null;
		String token = "";
		String nomCiudad="";
		String codigo="";

		String codVerificacion = "";
		
		String codigoPaisOrigen="",codigoPaisDestino="";
		String nombreCiudadDestino="",nombrePaisDestino="";
		
		String idHotel="",nombreHotel="";
		String codigoHabitacion="",tipoCama="";
		Integer disponibilidadHabitacion=0,numeroCamas;
		Double precioHabitacionNoche,precioHabitacionTotal;
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
			sexo = request.getParameter("genero");
			telefono = request.getParameter("num_telefono");
			fecha_nacimiento = LocalDate.parse(request.getParameter("fecha_nacimiento"));
			
			
			if (email.length()<=10) {
				request.setAttribute("error", "Formato de correo no valido");
				request.getRequestDispatcher("registro.jsp").forward(request, response);
			}
			else {
				String extensionCorreo = email.substring(email.length() - 10, email.length());
				EntityManager em1 = modelo.HibernateUtils.getEmf().createEntityManager();
				try {
					Query q1 = em1.createQuery("FROM Usuario");
					List<Usuario> usuarios = q1.getResultList();
					for (Usuario user : usuarios) {
	
						if (user.getEmail().compareTo(email) == 0) {
							request.setAttribute("error", "El correo electronico ya esta en uso");
							request.getRequestDispatcher("registro.jsp").forward(request, response);
						} 
						else if (user.getNombre().compareTo(nombreUsuario) == 0) {
							request.setAttribute("error", "El nombre de usuario ya esta en uso");
							request.getRequestDispatcher("registro.jsp").forward(request, response);
						}
						else if (user.getNum_telefono() != null && user.getNum_telefono().compareTo(telefono) == 0) {
							request.setAttribute("error", "El número de teléfono ya esta en uso");
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
					} else if (telefono.length() < 9 || telefono.length() > 9) {
						request.setAttribute("error",
								"El numero de telefono tienen que tener 9 dígitos");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if ('6' != telefono.charAt(0) && '7' != telefono.charAt(0)) {
						request.setAttribute("error",
								"El numero de telefono tiene que empezar por 6 o 7");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					}
	
					// Try catch exceptiones java.lang.IllegalStateException
					else {
						// Guardar los datos del usuario y el token de confirmación en la sesión del
						// usuario
						request.getSession().setAttribute("nombreUsuario", nombreUsuario);
						request.getSession().setAttribute("password", password);
						request.getSession().setAttribute("email", email);
						request.getSession().setAttribute("genero", sexo);
						request.getSession().setAttribute("num_telefono", telefono);
						request.getSession().setAttribute("fecha_nacimiento", fecha_nacimiento);
						System.out.println(nombreUsuario + " " + password + " " + email + " " + telefono + " " + sexo + " " + fecha_nacimiento);
						token = generarToken();
						System.out.println("Token creado: " + token);
						EmailValidator.enviarCorreo(email, token);
						request.getSession().setAttribute("token", token);
						System.out.println("Correo enviado");
						// Redirigir a una página para que el usuario confirme su correo electrónico
						// request.setAttribute("token", token);
						request.getRequestDispatcher("Secure/confirmar_correo.jsp").forward(request, response);
	
					}
				} catch (IllegalStateException e) {
					System.out.println(e.getMessage());
				}

			}
			
			break;
		case "verificarCorreo":
			codVerificacion = request.getParameter("cod_verificacion");
			nombreUsuario = (String) request.getSession().getAttribute("nombreUsuario");
			password = (String) request.getSession().getAttribute("password");
			email = (String) request.getSession().getAttribute("email");
			sexo = (String) request.getSession().getAttribute("genero");
			telefono = (String) request.getSession().getAttribute("num_telefono");
			fecha_nacimiento = (LocalDate) request.getSession().getAttribute("fecha_nacimiento");
			token = (String) request.getSession().getAttribute("token");
			System.out.println(nombreUsuario + " " + password + " " + email);
			System.out.println("TokenDef: " + token);
			System.out.println("codVeri: " + codVerificacion);
			if (token.compareTo(codVerificacion) != 0) {
				request.setAttribute("token", token);
				request.setAttribute("email", email);
				request.setAttribute("error", "Codigo de verificacion incorrecto");
				request.getRequestDispatcher("Secure/confirmar_correo.jsp").forward(request, response);
			} else {
				Usuario nuevoUsuario = new Usuario(nombreUsuario, password, email, false, sexo, telefono, fecha_nacimiento, LocalDate.now());
				System.out.println(nuevoUsuario.toString());
				EntityManager em2 = HibernateUtils.getEmf().createEntityManager();
				EntityTransaction transacion = em2.getTransaction();
				try {
					transacion.begin();
					em2.persist(nuevoUsuario);
					transacion.commit();
					System.out.println("Usuario Subido");
				} catch (Exception e) {
					System.out.println(nuevoUsuario.toString());
					System.err.println(e.getMessage());
					transacion.rollback();
				} finally {
					em2.close();
				}
				response.sendRedirect("login.jsp");
			}
			break;

		case "perfil": // es el cliente quien deber� invocar a este recurso
			response.sendRedirect("Secure/perfilUsuario.jsp");
			break;
		case "NuevoViaje": // es el cliente quien invoca este recurso al presionar el oton de Crear Viaje

			response.sendRedirect("Secure/nuevoViaje.jsp");
			break;
		case "buscarHotel":
			String fechaEntrada=request.getParameter("fechaEntrada");
			String fechaSalida=request.getParameter("fechaSalida");
			String numeroPersonas=request.getParameter("numeroPersonas");
	    	System.out.println("Fecha de Entrada: "+fechaEntrada+"\nFecha de Salida: "+fechaSalida+"\nNumero de personas: "+numeroPersonas);

			nomCiudad= request.getParameter("destino");
			System.out.println(nomCiudad);
			
			Amadeus amadeus =iniciarApi();
			try {
				City[] ciudad=amadeus.referenceData.locations.cities.get(Params.with("keyword", nomCiudad));
				codigo=ciudad[0].getIataCode();
				codigoPaisDestino=ciudad[0].getAddress().getCountryCode();
				
			} catch (ResponseException e) {
				e.printStackTrace();
			}
			request.setAttribute("fechaEntrada", fechaEntrada);
			request.setAttribute("fechaSalida", fechaSalida);
			request.setAttribute("numeroPersonas", numeroPersonas);
			
			request.setAttribute("codigoIATAPaisDestino", codigoPaisDestino);
			request.setAttribute("nombreCiudad", nomCiudad);
			request.setAttribute("sesionAmadeus", amadeus);
			request.setAttribute("codIATA", codigo);
			request.getRequestDispatcher("Secure/ofertasHoteles.jsp").forward(request, response);
			break;
			
		case "guardarOfertaHotel":
			Amadeus sesion=iniciarApi();
			codigo=(String)request.getParameter("codigoIATA2");
			codigoHabitacion=(String) request.getParameter("idHabitacion");
			fechaEntrada=(String) request.getParameter("fechaEntrada2");
			fechaSalida=(String) request.getParameter("fechaSalida2");
			disponibilidadHabitacion=(Integer)Integer.valueOf(request.getParameter("habitacionDisponible"));
			numeroCamas=(Integer) Integer.valueOf(request.getParameter("numeroCamas"));
			tipoCama=(String)request.getParameter("tipoDeCama");
			precioHabitacionNoche=(Double) Double.valueOf(request.getParameter("precioNoche"));
			precioHabitacionTotal=(Double)Double.valueOf(request.getParameter("precioTotal"));
			
			numeroPersonas=(String) request.getParameter("numeroPersonas2");
			codigoPaisOrigen=(String) request.getParameter("codigoIATAPaisOrigen");
			codigoPaisDestino=(String) request.getParameter("codigoIATAPaisDestino");
			nombreCiudadDestino=(String)request.getParameter("nombreCiudadDestino");
				
			idHotel=request.getParameter("hotelId");
			nombreHotel=request.getParameter("nombreHotel");
			nombrePaisDestino=(String)request.getParameter("nombrePaisDestino");
			System.out.println("case: guardarOfertaHotel ["+codigo+" "+fechaEntrada+" "+fechaSalida+" "+numeroPersonas);
			LocalDate fEntrada=LocalDate.parse(fechaEntrada);
			LocalDate fSalida=LocalDate.parse(fechaSalida);
			
			//Falta incluir codigoPostal y Calle en la Direccion		
			Direccion direccionHotel=new Direccion(codigoPaisDestino,nombrePaisDestino,codigo,nombreCiudadDestino,null,null);
			
			Hotel hotel=new Hotel(idHotel,nombreHotel);
			hotel.setDireccion(direccionHotel);
			
			Habitacion habitacion=new Habitacion(codigoHabitacion, fEntrada, fSalida, numeroCamas, tipoCama,precioHabitacionNoche, precioHabitacionTotal);
			habitacion.setHotel(hotel);
			direccionHotel.setHotel(hotel);
			hotel.addHabitacion(habitacion);
			
			System.out.println("Direccion del Hotel elegido:\n"+direccionHotel.toString());
			System.out.println("Datos del Hotel elegido:\n"+hotel.toString());
			System.out.println("Datos de la Habitacion del Hotel elegido:\n"+habitacion.toString());
			
			//En este punto ya deberia tener todos los datos recojidos de 
			//Direccion,Hotel,Usuario y Habitacion.
			//Para poder transportar los datos de una mejor forma
			//probare a utilizar el almacenamiento en json
			request.setAttribute("direccion",direccionHotel);
			request.setAttribute("hotel2", hotel);
			request.setAttribute("habitacion01", habitacion);
			
			request.setAttribute("codigoIATA3", codigo);
			request.setAttribute("fechaEntrada3", fechaEntrada);
			request.setAttribute("fechaSalida3", fechaSalida);
			request.setAttribute("numeroPersonas3", numeroPersonas);
			request.setAttribute("codigoIATAOrigen2", codigoPaisOrigen);
			request.setAttribute("codigoIATADestino2", codigoPaisDestino);
			request.setAttribute("sesionAmadeus",sesion );
			
			request.getRequestDispatcher("Secure/ofertasTransporte.jsp").forward(request, response);
			break;

		case "guardarOfertaViaje":
			String aeropuerto_Origen =request.getParameter("aeropuertoOrigen");
			String ciudad_Origen =request.getParameter("ciudadOrigen");
			String compania_Area= request.getParameter("companiaAerea");
			String ciudad_destino= request.getParameter("ciudadDestino");
			String aeropuerto_Destino =request.getParameter("aeropuertoDestino");
			String tipo_Viajero =request.getParameter("tipoViajero");
			Double precio_Medio =Double.valueOf(request.getParameter("precioMedio"));
			String clase_Cabina =request.getParameter("claseCabina");
			
			Direccion direccionFinal=(Direccion) request.getSession().getAttribute("direccion1");
			Hotel hotelFinal=(Hotel) request.getSession().getAttribute("hotel1");
			Habitacion habitacionFinal=(Habitacion) request.getSession().getAttribute("habitacion1");
			Usuario usuarioFinal = (Usuario) request.getSession().getAttribute("usuario");
			
			DatosVuelo datosVuelo = new DatosVuelo(aeropuerto_Origen,ciudad_Origen,compania_Area,ciudad_destino
													,aeropuerto_Destino, tipo_Viajero, precio_Medio,clase_Cabina);
			Viaje viaje= new Viaje(usuarioFinal, habitacionFinal, datosVuelo);
			System.out.println(viaje.toString());
			//usuarioFinal.addViaje(viaje);
			EntityManager em1 = modelo.HibernateUtils.getEmf().createEntityManager();
			EntityTransaction transaction1= null;
			try {
				transaction1=em1.getTransaction();
				transaction1.begin();
				em1.merge(direccionFinal);
				em1.merge(hotelFinal);
				em1.merge(habitacionFinal);
				em1.merge(datosVuelo);
				em1.merge(viaje);
				//em1.merge(usuarioFinal);
				transaction1.commit();
			}catch(Exception e) {
				System.out.println(e.getMessage());
				 if (transaction1 != null && transaction1.isActive()) {
			            transaction1.rollback();
			        }
			}finally {
				 if (em1 != null && em1.isOpen()) {
			            em1.close();
			        }
			}
			request.getSession().setAttribute("usuario", usuarioFinal);
			response.sendRedirect("Secure/perfilUsuario.jsp");

	        break;
		case "eliminarViajeUsuario":
			System.out.println("HOLAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");

		    Usuario usuarioSeleccionado = (Usuario) request.getSession().getAttribute("UsuarioSeleccionado");
		    Integer idViajeEliminar =Integer.parseInt(request.getParameter("idViajeEliminar"));
		    String idUsuarioStr = request.getParameter("idUsuario");
		    
		    System.out.println(idViajeEliminar + idUsuarioStr);

		    System.out.println("Datos"+idViajeEliminar+idUsuarioStr);
		    EntityManager emBorrar = modelo.HibernateUtils.getEmf().createEntityManager();
		    EntityTransaction transactionBorrar = null;
		    try {
		        transactionBorrar = emBorrar.getTransaction();
		        transactionBorrar.begin();
		        
				 Viaje viajeABorrar = emBorrar.find(Viaje.class, idViajeEliminar);
				 if (viajeABorrar != null) {
			            // Eliminar el viaje y las entidades relacionadas con él
			            emBorrar.remove(viajeABorrar);
			        }
				 System.out.println(viajeABorrar.toString());
				 transactionBorrar.commit();

		    } catch (Exception e) {
		        System.out.println("Error: " + e.getMessage());
		        e.printStackTrace();
		        if (transactionBorrar != null && transactionBorrar.isActive()) {
		            transactionBorrar.rollback();
		        }
		    } finally {
		        if (emBorrar != null && emBorrar.isOpen()) {
		            emBorrar.close();
		        }
		    }
		    System.out.println("ADIOOOOOOOOOOOOOOOOOOOOOOOOOOOS");
		    request.getSession().setAttribute("usuario", usuarioSeleccionado);
		    response.sendRedirect("Secure/perfilUsuario.jsp");
		    break;
		case "Loger":
			response.sendRedirect("login.jsp");
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
					EntityManager em2 = HibernateUtils.getEmf().createEntityManager();
					Query query2 = em2.createQuery("SELECT u.ultima_conexion_temporal FROM Usuario u WHERE u.id = :id");
					query2.setParameter("id", usuario.getId_usuario());
					
					LocalDateTime  ultima_conexion_temporal =  (LocalDateTime) query2.getSingleResult();
					
				    EntityManagerFactory emf = HibernateUtils.getEmf();
				    EntityManager em3 = emf.createEntityManager();
				    EntityTransaction transaction = null;

				    try {
				        transaction = em3.getTransaction();
				        transaction.begin();

				        Usuario user = em3.find(Usuario.class, usuario.getId_usuario());

				        if (user != null) {
				            user.setUltima_conexion(ultima_conexion_temporal);
				            user.setUltima_conexion_temporal(LocalDateTime.now());
				            
				            em3.merge(user);
				            transaction.commit();
				        }

				    } catch (Exception e) {
				        // Maneja cualquier excepción
				        if (transaction != null && transaction.isActive()) {
				            transaction.rollback();
				        }
				        e.printStackTrace();
				    }
				    
				    HttpSession session = request.getSession();
					session.setAttribute("usuario", usuario);
					
					// Crear una cookie con el nombre del usuario
		            Cookie userCookie = new Cookie("userEmail", email);
		            // Configurar la cookie para que expire en 7 días
		            userCookie.setMaxAge(7 * 24 * 60 * 60);
		            // Añadir la cookie a la respuesta
		            response.addCookie(userCookie);
					
					response.sendRedirect("Secure/perfilUsuario.jsp");
					
					
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
		
		case "cambiar_tema":
		    // Obtén el id del usuario de la sesión
		    HttpSession session = request.getSession();
		    Usuario usuario = (Usuario) session.getAttribute("usuario");
		    int idUsuario = usuario.getId_usuario();

		    // Crea un EntityManager a partir de la EntityManagerFactory
		    EntityManagerFactory emf = HibernateUtils.getEmf();
		    EntityManager em2 = emf.createEntityManager();
		    EntityTransaction transaction = null;

		    try {
		        // Inicia una transacción
		        transaction = em2.getTransaction();
		        transaction.begin();

		        // Busca al usuario en la base de datos por su id
		        Usuario user = em2.find(Usuario.class, idUsuario);

		        // Verifica si el usuario existe
		        if (user != null) {
		            // Actualiza el tema del usuario
		            user.setTema(!user.getTema()); // Cambia el tema

		            // Guarda los cambios en la base de datos
		            em2.merge(user);
		            transaction.commit();
		        }

		    } catch (Exception e) {
		        // Maneja cualquier excepción
		        if (transaction != null && transaction.isActive()) {
		            transaction.rollback();
		        }
		        e.printStackTrace();
		    } finally {

		    	em2.close();
		    	
		    	response.sendRedirect("Secure/perfilUsuario.jsp");
		    }
		    break;

		case "config":
			
			response.sendRedirect("Secure/configuracion.jsp");
			break;
		
		case "validarUser":
			nombreUsuario= request.getParameter("nombreUsuario");
			
			
			
			 // Obtén el id del usuario de la sesión
		    HttpSession session2 = request.getSession();
		    Usuario usuario2 = (Usuario) session2.getAttribute("usuario");
		    int idUsuario2 = usuario2.getId_usuario();

		    // Crea un EntityManager a partir de la EntityManagerFactory
		    EntityManagerFactory emf2 = HibernateUtils.getEmf();
		    EntityManager em3 = emf2.createEntityManager();
		    EntityTransaction transaction2 = null;

		    if (nombreUsuario.matches(".*[!¡@#$%^&*()¿?¬~].*")) {
				request.setAttribute("error", "El nombre de usuario no debe contener un caracter especial");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			} else if (nombreUsuario.length() < 3) {
				request.setAttribute("error", "El nombre de usuario debe ser superior a 3 caracteres");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else {
				Query q1 = em3.createQuery("FROM Usuario");
				List<Usuario> usuarios = q1.getResultList();
				
			    for (Usuario user : usuarios) {
	
					if (user.getNombre().compareTo(nombreUsuario) == 0) {
						request.setAttribute("error", "El nombre de usuario ya esta en uso");
						request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
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
	
			        
			    } catch (Exception e) {
			        if (transaction2 != null && transaction2.isActive()) {
			        	transaction2.rollback();
			        }
			        e.printStackTrace();
			    } finally {
			    	em3.close();
			    	
			    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
			    }
			}
		    
		    break;
		
		case "validar_tema":
		    // Obtén el id del usuario de la sesión
		    HttpSession session3 = request.getSession();
		    Usuario usuario3 = (Usuario) session3.getAttribute("usuario");
		    int idUsuario3 = usuario3.getId_usuario();

		    // Crea un EntityManager a partir de la EntityManagerFactory
		    EntityManagerFactory emf3 = HibernateUtils.getEmf();
		    EntityManager em4 = emf3.createEntityManager();
		    EntityTransaction transactio3 = null;

		    try {
		        // Inicia una transacción
		        transaction = em4.getTransaction();
		        transaction.begin();

		        // Busca al usuario en la base de datos por su id
		        Usuario user = em4.find(Usuario.class, idUsuario3);

		        // Verifica si el usuario existe
		        if (user != null) {
		            // Actualiza el tema del usuario
		            user.setTema(!user.getTema()); // Cambia el tema

		            // Guarda los cambios en la base de datos
		            em4.merge(user);
		            transaction.commit();
		        }

		    } catch (Exception e) {
		        // Maneja cualquier excepción
		        if (transactio3 != null && transactio3.isActive()) {
		        	transactio3.rollback();
		        }
		        e.printStackTrace();
		    } finally {
		        // Cierra el EntityManager
		    	em4.close();
		    	
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    }
		    break;
		    

		case "validar_correo":
			
			email = request.getParameter("emailUsuario");
			if (email.length()<=10) {
				request.setAttribute("error", "Formato de correo no valido");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else {
				String extensionCorreo2 = email.substring(email.length() - 10, email.length());
				EntityManagerFactory emf4 = HibernateUtils.getEmf();
			    EntityManager em5 = emf4.createEntityManager();
				
			    Query q2 = em5.createQuery("FROM Usuario");
				List<Usuario> usuarios2 = q2.getResultList();
				for (Usuario user : usuarios2) {
	
					if (user.getEmail().compareTo(email) == 0) {
						request.setAttribute("error", "El correo electronico ya esta en uso");
						request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
					}
	
				}
				if (extensionCorreo2.compareTo("@gmail.com") != 0) {
					
					request.setAttribute("error", "Correo no valido");
					request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
				}
				else {
					request.getSession().setAttribute("email", email);
					
					token = generarToken();
					System.out.println("Token creado: " + token);
					
					EmailValidator.cambio_correo(email, token);
					request.getSession().setAttribute("token", token);
					System.out.println("Correo enviado");
					
					request.getRequestDispatcher("Secure/confirmar_correo2.jsp").forward(request, response);
				}
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
				request.getRequestDispatcher("Secure/confirmar_correo.jsp").forward(request, response);
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
					
					response.sendRedirect("Secure/configuracion.jsp?datPer=true");
				}
				
			}
			break;
			
		case "validar_password":
			password = request.getParameter("passwordUsuario");
			
			HttpSession session5 = request.getSession();
		    Usuario usuario5 = (Usuario) session5.getAttribute("usuario");
		    email = usuario5.getEmail();
			
			
			if (!(password.matches(".*[A-Z].*"))) {
				request.setAttribute("error", "La contraseña debe contener como mínimo una mayuscula");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			} 
			else if (!(password.matches(".*[0-9].*"))) {
				request.setAttribute("error", "La contraseña debe contener un numero");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			} 
			else if (!(password.matches(".*[!¡@#$%^&*()¿?¬~].*"))) {
				request.setAttribute("error", "La contraseña debe contener como mínimo un caracter especial");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else if ((password.length() < 8) || (password.length() > 20)) {
				request.setAttribute("error",
						"La contraseña no puede ser inferior a los 8 caracteres ni superior a los 20");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else {
				
				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("password", password);
				
				token = generarToken();
				System.out.println("Token creado: " + token);
				
				EmailValidator.cambio_password(email, token);
				request.getSession().setAttribute("token", token);
				System.out.println("Correo enviado");
				
				request.getRequestDispatcher("Secure/confirmar_password.jsp").forward(request, response);
				
			}
			
			
			break;
		
		case "verificar_password":
			password = (String) request.getSession().getAttribute("password");
			
			HttpSession session6 = request.getSession();
		    Usuario usuario6 = (Usuario) session6.getAttribute("usuario");
		    int idUsuario6 = usuario6.getId_usuario();
		    
			codVerificacion = request.getParameter("cod_verificacion");
			email = (String) request.getSession().getAttribute("email");
			token = (String) request.getSession().getAttribute("token");
			System.out.println("TokenDef: " + token);
			System.out.println("codVeri: " + codVerificacion);
			
			if (token.compareTo(codVerificacion) != 0) {
				request.setAttribute("token", token);
				request.setAttribute("email", email);
				request.setAttribute("error", "Codigo de verificacion incorrecto");
				request.getRequestDispatcher("Secure/confirmar_password.jsp").forward(request, response);
			} else {
				
				EntityManagerFactory emf5 = HibernateUtils.getEmf();
			    EntityManager em5 = emf5.createEntityManager();
			    EntityTransaction transaction5 = null;
				
			    try {
			    	transaction5 = em5.getTransaction();
			    	transaction5.begin();
			    	
			        Usuario user = em5.find(Usuario.class, idUsuario6);

			        if (user != null) {
			            user.setContrasenia(password);
			            user.setUltima_modificacion_contrasenna(LocalDate.now());
			            
			            em5.merge(user);
			            transaction5.commit();
			        }

			        
			    } catch (Exception e) {
			        if (transaction5 != null && transaction5.isActive()) {
			        	transaction5.rollback();
			        }
			        e.printStackTrace();
			    } finally {
			    	em5.close();
			    	
			    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
			    }
			
			}
			break;
			
		case "validar_telefono":
			telefono = request.getParameter("telefonoUsuario");
			
			HttpSession session7 = request.getSession();
		    Usuario usuario7 = (Usuario) session7.getAttribute("usuario");
		    int idUsuario7 = usuario7.getId_usuario();
			
		    EntityManagerFactory emf6 = HibernateUtils.getEmf();
		    EntityManager em6 = emf6.createEntityManager();
		    EntityTransaction transaction6 = null;
			
		    try {
		    	transaction6 = em6.getTransaction();
		    	transaction6.begin();
		    	
		        Usuario user = em6.find(Usuario.class, idUsuario7);

		        if (user != null) {
		            user.setNum_telefono(telefono);
		            
		            em6.merge(user);
		            transaction6.commit();
		        }

		        
		    } catch (Exception e) {
		        if (transaction6 != null && transaction6.isActive()) {
		        	transaction6.rollback();
		        }
		        e.printStackTrace();
		    } finally {
		    	em6.close();
		    	
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    }
			
			break;
			
		case "validar_sexo":
			sexo = request.getParameter("sexoUsuario");
			
			HttpSession session8 = request.getSession();
		    Usuario usuario8 = (Usuario) session8.getAttribute("usuario");
		    int idUsuario9 = usuario8.getId_usuario();
			
		    EntityManagerFactory emf7 = HibernateUtils.getEmf();
		    EntityManager em7 = emf7.createEntityManager();
		    EntityTransaction transaction7 = null;
			
		    try {
		    	transaction6 = em7.getTransaction();
		    	transaction6.begin();
		    	
		        Usuario user = em7.find(Usuario.class, idUsuario9);

		        if (user != null) {
		            user.setSexo(sexo);
		            
		            em7.merge(user);
		            transaction6.commit();
		        }

		        
		    } catch (Exception e) {
		        if (transaction7 != null && transaction7.isActive()) {
		        	transaction7.rollback();
		        }
		        e.printStackTrace();
		    } finally {
		    	em7.close();
		    	
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    }
			
			break;
			
		case "validar_fecha":
			fecha_nacimiento = LocalDate.parse(request.getParameter("fechaUsuario"));
			
			HttpSession session9 = request.getSession();
		    Usuario usuario9 = (Usuario) session9.getAttribute("usuario");
		    int idUsuario10 = usuario9.getId_usuario();
			
		    EntityManagerFactory emf8 = HibernateUtils.getEmf();
		    EntityManager em8 = emf8.createEntityManager();
		    EntityTransaction transaction8 = null;
			
		    try {
		    	transaction6 = em8.getTransaction();
		    	transaction6.begin();
		    	
		        Usuario user = em8.find(Usuario.class, idUsuario10);

		        if (user != null) {
		            user.setFecha_nacimiento(fecha_nacimiento);
		            
		            em8.merge(user);
		            transaction6.commit();
		        }

		        
		    } catch (Exception e) {
		        if (transaction8 != null && transaction8.isActive()) {
		        	transaction8.rollback();
		        }
		        e.printStackTrace();
		    } finally {
		    	em8.close();
		    	
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    }
			
			break;
			
		default:
			// es el cliente quien deber� invocar a este recurso
			response.sendRedirect("index.jsp");
		}

	}

	private String generarToken() {
		// Implementa la lógica para generar un token de confirmación único
		return UUID.randomUUID().toString();
	}
	
	protected Amadeus iniciarApi() {
		//Initialize using parameters
		Amadeus amadeus = Amadeus
		        //.builder("ptncDDPN6h0AZL1kMKSrGquLu1yUPeGk", "RUZhm8NigqOrNrDw")
		        .builder("ogWe05A023xfPIxnde7GFlvDZtsot8V9","EhGKNIAHKSjwc5EL")
		        .build();
		return amadeus;
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
