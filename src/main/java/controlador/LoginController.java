package controlador;

import java.io.IOException;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.slf4j.LoggerFactory;
import org.slf4j.Logger;

import com.amadeus.Amadeus;
import com.amadeus.Params;
import com.amadeus.exceptions.ClientException;
import com.amadeus.exceptions.ResponseException;
import com.amadeus.resources.City;
import com.amadeus.resources.HotelOfferSearch;
import com.amadeus.resources.HotelOfferSearch.Offer;
import com.amadeus.resources.Hotel;



import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.LockModeType;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import modelo.DatosVuelo;
import modelo.Direccion;
import modelo.Habitacion;
import modelo.HibernateUtils;
import modelo.HotelBD;
import modelo.Usuario;
import modelo.Viaje;
import util.ConfigLoader;
import util.EmailValidator;
import util.HotelData;


/**
 * La clase LoginController se encarga de actuar como un servlet con la extension HtttpServlet, respondiendo a las peticiones del usuario.
 * @author Grupo 5
 * @since 2024
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);
	ConfigLoader configLoader = new ConfigLoader();

	/**
	 * El metodo procesar peticon se encarga de ejecutar una accion que desencadena el usuario, como puede ser 
	 * redirigirlo a otra pagina, crear un Viaje y guardarlo en la base de datos, buscar ofertas de hoteles, eliminar un usuario
	 * eliminar un viaje, registrar un nuevo usuario en base de datos.
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws ServletException
	 */
	@SuppressWarnings("unchecked")
	protected void procesarPeticion(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		response.setContentType("text/html;charset=UTF-8");
		String nombreUsuario = "", password = "", passwordRe = "", email = "hola", telefono = "", sexo = "";
		
		LocalDate fecha_nacimiento = null;
		String token = "";
		String nomCiudadOrigen="",nomCiudadDestino="";
		String codigoCiudadOrigen="",codigoCiudadDestino="";

		String codVerificacion = "";
		BigDecimal latitud_hotel= new BigDecimal("0.0"),longitud_hotel=new BigDecimal("0.0");
		String codigoPaisOrigen="",codigoPaisDestino="";
		String nombreCiudadDestino="",nombrePaisDestino="";
		
		String idHotel="",nombreHotel="",calleHotel="";
		String codigoHabitacion="",tipoCama="";
		Integer disponibilidadHabitacion=0,numeroCamas=0, numeroViajeros;
		String numeroPersonasViajeStr="";
		
		Double precioHabitacionNoche,precioHabitacionTotal;
		
		String operacion = request.getParameter("opcion");
		if (operacion == null) {
			operacion = "";
		}

		RequestDispatcher rd;

		switch (operacion) {

		case "registrarse": // es el servidor quien redirije internamente hacia la vista registrarse
			LOGGER.info("Accediendo a pagina de registro");
		    rd = request.getRequestDispatcher("registro.jsp");
		    rd.forward(request, response);
		    
			break;
			
			// Se realiza el insert de un nuevo usuario en la base de datos
		case "registrarNuevoUsuario":
			
			nombreUsuario = request.getParameter("nombreUsuario");
			password = request.getParameter("contrasenia");
			passwordRe = request.getParameter("contraseniaRe");
			email = request.getParameter("correoUsuario");
			sexo = request.getParameter("genero");
			telefono = request.getParameter("num_telefono");
			fecha_nacimiento = LocalDate.parse(request.getParameter("fecha_nacimiento"));
			
			
			if (email.length()<=10) {
				request.setAttribute("error", "Formato de correo no valido");
				LOGGER.error("Error: Correo es muy corto");
				request.getRequestDispatcher("registro.jsp").forward(request, response);
			}
			else {
				String extensionCorreo = email.substring(email.length() - 10, email.length());
				EntityManager em1 = modelo.HibernateUtils.getEmf().createEntityManager();
				try {
					Query q1 = em1.createQuery("FROM Usuario");
					List<Usuario> usuarios = q1.getResultList();
					LOGGER.info("Comprobacion de que los datos introducidos no son coincidentes con los de otros usuarios ya existentes");
					for (Usuario user : usuarios) {
	
						if (user.getEmail().compareTo(email) == 0) {
							request.setAttribute("error", "El correo electronico ya esta en uso");
							LOGGER.error("Error: El correo electronico ya esta en uso");
							request.getRequestDispatcher("registro.jsp").forward(request, response);
						} 
						else if (user.getNombre().compareTo(nombreUsuario) == 0) {
							request.setAttribute("error", "El nombre de usuario ya esta en uso");
							LOGGER.error("Error: nombre de usuario ya esta en uso");
							request.getRequestDispatcher("registro.jsp").forward(request, response);
						}
						else if (user.getNum_telefono() != null && user.getNum_telefono().compareTo(telefono) == 0) {
							request.setAttribute("error", "El número de teléfono ya esta en uso");
							LOGGER.error("Error: el número de telefono ya esta en uso");
							request.getRequestDispatcher("registro.jsp").forward(request, response);
						}
	
					}
					if ((password.compareTo(passwordRe) != 0)) {
						request.setAttribute("error", "Las contraseñas deben coincidir");
						LOGGER.error("Error: Las contraseñas debe coincidir");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (extensionCorreo.compareTo("@gmail.com") != 0) {
						System.out.println(email.substring(email.length() - 10, email.length()));
						request.setAttribute("error", "El correo no es valido debe acabar en '@gmail.com'");
						LOGGER.error("Error: Correo no valido");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (!(password.matches(".*[A-Z].*"))) {
						request.setAttribute("error", "La contraseña debe contener como mínimo una mayuscula");
						LOGGER.error("Error: Las contraseña debe contener como minimo una mayuscula");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (!(password.matches(".*[0-9].*"))) {
						request.setAttribute("error", "La contraseña debe contener un numero");
						LOGGER.error("Error: Las contraseñas debe contener un numero");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (nombreUsuario.matches(".*[!¡@#$%^&*()¿?¬~].*")) {
						request.setAttribute("error", "El nombre de usuario no debe contener un caracter especial");
						LOGGER.error("Error: El nombre de usuario no debe contener un caracter especial");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (nombreUsuario.length() < 3) {
						request.setAttribute("error", "El nombre de usuario debe ser superior a 3 caracteres");
						LOGGER.error("Error: El nombre de usuario ser superior a 3 caracteres");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (!(password.matches(".*[!¡@#$%^&*()¿?¬~].*"))) {
						request.setAttribute("error", "La contraseña debe contener como mínimo un caracter especial");
						LOGGER.error("Error: La contraseña debe contener como mínimo un caracter especial");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if ((password.length() < 8) || (password.length() > 20)) {
						request.setAttribute("error",
								"La contraseña no puede ser inferior a los 8 caracteres ni superior a los 20");
						LOGGER.error("Error: La contraseña introducida es inferior a 8 caracteres o superior a 20 caracteres");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if (telefono.length() < 9 || telefono.length() > 9) {
						request.setAttribute("error",
								"El numero de telefono tienen que tener 9 dígitos");
						LOGGER.error("Error: el numeor de telefono introducido es inferior o superior a 9 digitos");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					} else if ('6' != telefono.charAt(0) && '7' != telefono.charAt(0)) {
						request.setAttribute("error",
								"El numero de telefono tiene que empezar por 6 o 7");
						LOGGER.error("Error: el numero de telefono no empieza por 6 o 7");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					}else if(telefono.matches(".*[A-Z].*")||telefono.matches(".*[a-z].*")||telefono.matches(".*[!¡@#$%^&*()¿?¬~].*")) {
						request.setAttribute("error",
								"El numero de telefono no puede contener una letra o caracter especial");
						LOGGER.error("Error: El numero de telefono no puede contener una letra o caracter especial([!¡@#$%^&*()¿?¬~])");
						request.getRequestDispatcher("registro.jsp").forward(request, response);
					}
	
					
					else {
						LOGGER.info("Los datos del usuario son validos");
						// Guardar los datos del usuario y el token de confirmación en la sesión del
						// usuario
						request.getSession().setAttribute("nombreUsuario", nombreUsuario);
						request.getSession().setAttribute("password", password);
						request.getSession().setAttribute("email", email);
						request.getSession().setAttribute("genero", sexo);
						request.getSession().setAttribute("num_telefono", telefono);
						request.getSession().setAttribute("fecha_nacimiento", fecha_nacimiento);
						
						LOGGER.info("Datos: "+nombreUsuario + ", " + password + ", " + email + ", " + telefono + ", " + sexo + ", " + fecha_nacimiento);
					
						token = generarToken();
						LOGGER.info("Token creado: " + token);
						EmailValidator.enviarCorreo(email, token);
						request.getSession().setAttribute("token", token);
						LOGGER.info("Correo enviado");
						
						// Redirigir a una página para que el usuario confirme su correo electrónico
						request.getRequestDispatcher("Secure/confirmar_correo.jsp").forward(request, response);
	
					}
				} catch (IllegalStateException e) {
					LOGGER.error(e.getMessage());
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
			
			LOGGER.info("Token recibido: " + token);
			LOGGER.error("Codigo de verificaion introducido por el usuario: " + codVerificacion);
			if (token.compareTo(codVerificacion) != 0) {
				request.setAttribute("token", token);
				request.setAttribute("email", email);
				request.setAttribute("error", "Codigo de verificacion incorrecto");
				LOGGER.error("El codigo de verificacion es incorrecto, redirigiendo a confirmar correo");
				
				request.getRequestDispatcher("Secure/confirmar_correo.jsp").forward(request, response);
			} else {
				LOGGER.info("El codigo de verificacion introducido es CORRECTO");
				Usuario nuevoUsuario = new Usuario(nombreUsuario, password, email, false, sexo, telefono, fecha_nacimiento, LocalDate.now(),false);
				LOGGER.info("Usuario creado: "+ nuevoUsuario.toString());
				
				EntityManager em2 = HibernateUtils.getEmf().createEntityManager();
				LOGGER.trace("Creando Entity Manager");
				EntityTransaction transacion = em2.getTransaction();
				LOGGER.trace("Transacion creada y obtenida");
				try {
					transacion.begin();
					em2.persist(nuevoUsuario);
					transacion.commit();
					LOGGER.info("El usuario ha sido persistido");
				} catch (Exception e) {
					LOGGER.error("Error: "+e.getMessage());
					transacion.rollback();
					LOGGER.info("Se ha realizado rollback");
				} finally {
					
					em2.close();
					LOGGER.info("Se ha cerrado el Entity Manager");
					LOGGER.info("Redirigiendo a pagina login");
					response.sendRedirect("login.jsp");
				}
			}
			break;

		case "perfil": 
			LOGGER.info("Redirigiendo al perfil del usuario");
			response.sendRedirect("Secure/perfilUsuario.jsp");
			break;
		case "NuevoViaje": // es el cliente quien invoca este recurso al presionar el oton de Crear Viaje
			LOGGER.info("Redirigiendo a la pagina para la creacion de un nuevo viaje");
			response.sendRedirect("Secure/nuevoViaje.jsp");
			break;
		case "buscarHotel":

		    String fechaEntrada = request.getParameter("fechaEntrada");
		    String fechaSalida = request.getParameter("fechaSalida");
		    String numeroPersonas = request.getParameter("numeroPersonas");
		    Usuario usuarioInfo2 = (Usuario) request.getAttribute("usuario");
		    nomCiudadOrigen = request.getParameter("origen");
		    nomCiudadDestino = request.getParameter("destino");
		    LOGGER.info("Parametros recibidos: " + 
		        "\nCiudad origen= " + nomCiudadOrigen +
		        "\nCiudad destino= " + nomCiudadDestino +
		        "\nFecha de Entrada= " + fechaEntrada +
		        "\nFecha de Salida= " + fechaSalida +
		        "\nNumero de Personas: " + numeroPersonas
		    );

		    LOGGER.trace("Iniciando sesion en Amadeus");
		    Amadeus amadeus = iniciarApi();
		    LOGGER.trace("Sesion obtenida");

		    boolean errorOccurred = false;

		    try {
		        LOGGER.trace("Realizando consulta a la API obtener datos de la Ciudad Origen");
		        City[] ciudadOrigen = amadeus.referenceData.locations.cities.get(Params.with("keyword", nomCiudadOrigen));
		        codigoCiudadOrigen = ciudadOrigen[0].getIataCode();
		        codigoPaisOrigen = ciudadOrigen[0].getAddress().getCountryCode();
		        LOGGER.info("Datos obtenidos: " +
		            "\nCodigo Ciudad Origen= " + codigoCiudadOrigen +
		            "\nCodigo Pais Origen= " + codigoPaisOrigen
		        );
		    } catch (NullPointerException | ResponseException e) {
		        LOGGER.error("Error obteniendo datos de la ciudad origen: " + e.getMessage());
		        errorOccurred = true;
		    }
		    

		    try {
		        LOGGER.trace("Realizando consulta a la API obtener datos de la Ciudad Destino");
		        City[] ciudadDestino = amadeus.referenceData.locations.cities.get(Params.with("keyword", nomCiudadDestino));
		        codigoCiudadDestino = ciudadDestino[0].getIataCode();
		        codigoPaisDestino = ciudadDestino[0].getAddress().getCountryCode();
		        LOGGER.info("Datos obtenidos: " +
		            "\nCodigo Ciudad Destino= " + codigoCiudadDestino +
		            "\nCodigo Pais Destino= " + codigoPaisDestino
		        );
		    } catch (NullPointerException | ResponseException e) {
		        LOGGER.error("Error obteniendo datos de la ciudad destino: " + e.getMessage());
		        errorOccurred = true;
		    }

		    if (errorOccurred) {
		        request.setAttribute("usuario", usuarioInfo2);
		        response.sendRedirect("Secure/nuevoViaje.jsp?error=ciudades");
		        break;
		    }

		    ArrayList<Hotel> listaHoteles = new ArrayList<>();
		    ArrayList<HotelData> listaDatosHoteles = new ArrayList<>();
		    try {
		    	LOGGER.info("Buscando hoteles en Amadeus");
		        Hotel[] hotels = amadeus.referenceData.locations.hotels.byCity.get(
		            Params.with("cityCode", codigoCiudadDestino));
		        for (int a = 0; a < 10; a++) {
		    		try {		    			
			        	System.out.println(hotels[a].toString());
			    		listaHoteles.add(hotels[a]);
		    		}catch(ArrayIndexOutOfBoundsException e) {
		    			LOGGER.info("No hay más hoteles en la lista.");
		    			break;
		    		}
		    		
		    	}
		       

		        int i = 0;
		        if (!listaHoteles.isEmpty()) {
		            LOGGER.info("Hoteles encontrados:" + listaHoteles.size());

		            for (Hotel hotel : listaHoteles) {
		                try {
		                    HotelOfferSearch[] ofertasHotel = amadeus.shopping.hotelOffersSearch.get(Params
		                        .with("hotelIds", hotel.getHotelId())
		                        .and("adults", Integer.valueOf(numeroPersonas))
		                        .and("checkInDate", fechaEntrada)
		                        .and("checkOutDate", fechaSalida)
		                        .and("currency", "EUR")
		                        .and("bestRateOnly", false));

		                    Offer[] ofer = ofertasHotel[0].getOffers();
		                    for (int j = 0; j < 2; j++) {
		                        try {
		                            Offer infoOferta = ofer[j];

		                            if (infoOferta.getRoom().getTypeEstimated().getBeds() != null &&
		                                infoOferta.getRoom().getTypeEstimated().getBedType() != null) {

		                                HotelData hotelData = new HotelData();
		                                hotelData.setNombre(hotel.getName());
		                                hotelData.setDireccion("Aqui va la direccion del hotel...");
		                                hotelData.setCodPaisDestino(hotel.getAddress().getCountryCode());
		                                hotelData.setNomPaisDestino(hotel.getAddress().getCityName());
		                                hotelData.setCodigoHotel(hotel.getHotelId());
		                                hotelData.setLatitud(String.valueOf(hotel.getGeoCode().getLatitude()));
		                                hotelData.setLongitud(String.valueOf(hotel.getGeoCode().getLongitude()));
		                                hotelData.setIdOferta(infoOferta.getId());
		                                hotelData.setFechaEntrada(infoOferta.getCheckInDate());
		                                hotelData.setFechaSalida(infoOferta.getCheckOutDate());
		                                hotelData.setValoracion(infoOferta.getRateCode());
		                                hotelData.setDisponible(ofertasHotel[j].isAvailable());
		                                hotelData.setTipoHabitacion(infoOferta.getRoom().getType());
		                                hotelData.setCategoriaHabitacion(infoOferta.getRoom().getTypeEstimated().getCategory());
		                                hotelData.setNumeroCamas(infoOferta.getRoom().getTypeEstimated().getBeds());
		                                hotelData.setTipoCama(infoOferta.getRoom().getTypeEstimated().getBedType());
		                                hotelData.setDescripcion(infoOferta.getRoom().getDescription().getText().toString());
		                                hotelData.setNumeroAdultos(infoOferta.getGuests().getAdults());
		                                hotelData.setNumeroNinos(0);
		                                hotelData.setPrecioNoche(Math.ceil(Double.valueOf(infoOferta.getPrice().getBase()) / (LocalDate.parse(fechaSalida).toEpochDay() - LocalDate.parse(fechaEntrada).toEpochDay())));
		                                hotelData.setPrecioTotal(Double.valueOf(infoOferta.getPrice().getTotal()));
		                                listaDatosHoteles.add(hotelData);
		                                i = i + 1;
		                                LOGGER.info("Oferta encontrada, total de ofertas encontradas: " + i);
		                            }
		                        } catch (ArrayIndexOutOfBoundsException e) {
		                            LOGGER.error("No quedan mas ofertas en el hotel pasamos al siguiente");
		                            break;
		                        }
		                    }

		                } catch (ClientException | NullPointerException e) {
		                    LOGGER.error("Error en el hotel " + hotel.getName() + ": " + e.getMessage());
		                }
		            }
		        }
		    } catch (IllegalStateException | ResponseException e) {
		        LOGGER.error(e.getMessage());
		        request.setAttribute("usuario", usuarioInfo2);
		        response.sendRedirect("Secure/nuevoViaje.jsp?error=hoteles");
		        break;
		    }

		    request.setAttribute("listaHoteles", listaDatosHoteles);
		    request.setAttribute("sesionAmadeus", amadeus);
		    request.setAttribute("usuario", usuarioInfo2);
		    request.setAttribute("numeroPersonas", numeroPersonas);
		    request.setAttribute("nombreCiudadOrigen", nomCiudadOrigen);
		    request.setAttribute("codCiudadOrigen", codigoCiudadOrigen);
		    request.setAttribute("codigoPaisOrigen", codigoPaisOrigen);
		    request.setAttribute("nombreCiudadDestino", nomCiudadDestino);
		    request.setAttribute("codIATACiudadDestino", codigoCiudadDestino);
		    request.setAttribute("codIATAPaisDestino", codigoPaisDestino);

		    if (!listaDatosHoteles.isEmpty()) {
		        request.getRequestDispatcher("Secure/ofertasHoteles.jsp").forward(request, response);
		    } else {
		        response.sendRedirect("Secure/nuevoViaje.jsp?error=hoteles");
		    }
		    break;


		case "guardarOfertaHotel":
			Amadeus sesion=iniciarApi();
			codigoHabitacion=(String) request.getParameter("idHabitacion");
			fechaEntrada=(String) request.getParameter("fechaEntrada2");
			fechaSalida=(String) request.getParameter("fechaSalida2");
			calleHotel=(String)request.getParameter("direccionHotel");
			disponibilidadHabitacion=(Integer)Integer.valueOf(request.getParameter("habitacionDisponible"));
			numeroCamas=(Integer) Integer.valueOf(request.getParameter("numeroCamas"));
			tipoCama=(String)request.getParameter("tipoDeCama");
			precioHabitacionNoche=(Double) Double.valueOf(request.getParameter("precioNoche"));
			precioHabitacionTotal=(Double)Double.valueOf(request.getParameter("precioTotal"));
			LOGGER.info("Datos obtenidos de ofertasHoteles.jsp para crear una instancia de Habitacion: " +
	                "\nCodigo Habitacion= " + codigoHabitacion +
	                "\nFecha Entrada= " + fechaEntrada +
	                "\nFecha Salida= " + fechaSalida +
	                "\nCalle Hotel= " + calleHotel +
	                "\nDisponibilidad Habitacion= " + disponibilidadHabitacion +
	                "\nNumero Camas= " + numeroCamas +
	                "\nTipo Cama= " + tipoCama +
	                "\nPrecio Habitacion por Noche= " + precioHabitacionNoche +
	                "\nPrecio Habitacion Total= " + precioHabitacionTotal);
			
			numeroPersonas=(String) request.getParameter("numeroPersonas2");
			codigoPaisOrigen=(String) request.getParameter("codigoIATAPaisOrigen");
			codigoCiudadOrigen=(String) request.getParameter("codigoIATACiudadOrigen");
			codigoPaisDestino=(String) request.getParameter("codigoIATAPaisDestino");
			nombreCiudadDestino=(String)request.getParameter("nombreCiudadDestino");
			codigoCiudadDestino=(String)request.getParameter("codigoIATACiudadDestino");
			LOGGER.info("Datos obtenidos de ofertasHoteles.jsp para crear una instancia de Direccion: " +
	                "\nNumero de Personas= " + numeroPersonas +
	                "\nCodigo Pais Origen= " + codigoPaisOrigen +
	                "\nCodigo Ciudad Origen= " + codigoCiudadOrigen +
	                "\nCodigo Pais Destino= " + codigoPaisDestino +
	                "\nNombre Ciudad Destino= " + nombreCiudadDestino +
	                "\nCodigo Ciudad Destino= " + codigoCiudadDestino);
			
			
			idHotel=request.getParameter("hotelId");
			nombreHotel=request.getParameter("nombreHotel");
			latitud_hotel=new BigDecimal((String) request.getParameter("latitudHotel"));
			longitud_hotel=new BigDecimal((String) request.getParameter("longitudHotel"));
			LOGGER.info("Datos obtenidos de ofertasHoteles.jsp para crear una instancio de HotelBD: "+
						"\nCodigo Hotel= "+idHotel+
						"\nNombre del Hotel= "+nombreHotel+
						"\nCoordenadas del Hotel Latitud= "+latitud_hotel+" y Longitud= "+longitud_hotel);
			nombrePaisDestino=(String)request.getParameter("nombrePaisDestino");
			Usuario usuarioInfo=(Usuario) request.getAttribute("usuario");
			
			LocalDate fEntrada=LocalDate.parse(fechaEntrada);
			LocalDate fSalida=LocalDate.parse(fechaSalida);
			
			//Falta incluir codigoPostal y Calle en la Direccion		
			Direccion direccionHotel=new Direccion(codigoPaisDestino,nombrePaisDestino,codigoCiudadDestino,nombreCiudadDestino,calleHotel);
			LOGGER.debug("Se ha creado la instancia de Direccion");
			HotelBD hotel=new HotelBD(idHotel,nombreHotel,latitud_hotel,longitud_hotel);
			LOGGER.debug("Se ha creado la instancia de HotelBD");
			hotel.setDireccion(direccionHotel);
			LOGGER.debug("Se ha añadido la direccion a HotelBD");
			Habitacion habitacion=new Habitacion(codigoHabitacion, fEntrada, fSalida, numeroCamas, tipoCama,precioHabitacionNoche, precioHabitacionTotal);
			LOGGER.debug("Se ha creado la instancia de Habitacion");
			habitacion.setHotelBD(hotel);
			LOGGER.debug("Se ha añadido el Hotel a la Habitacion");
			direccionHotel.setHotel(hotel);
			LOGGER.debug("Se ha añadido el Hotel a la Direccion");
			hotel.addHabitacion(habitacion);
			LOGGER.debug("Se ha añadido la Habitacion al Hotel");
			
			LOGGER.info("Direccion del Hotel elegido:\n"+direccionHotel.toString());
			LOGGER.info("Datos del Hotel elegido:\n"+hotel.toString());
			LOGGER.info("Datos de la Habitacion del Hotel elegido:\n"+habitacion.toString());
			
			//En este punto ya deberia tener todos los datos recojidos de 
			//Direccion,Hotel,Usuario y Habitacion.
			//Para poder transportar los datos de una mejor forma

			request.setAttribute("direccion_Creada",direccionHotel);
			request.setAttribute("hotel_Creada", hotel);
			request.setAttribute("habitacion_Creada", habitacion);
			LOGGER.info("Enviando datos a ofertasTransporte.jsp: " +
	                "\nDireccion Hotel= " + direccionHotel +
	                "\nHotel= " + hotel);
			request.setAttribute("fechaEntrada3", fechaEntrada);
			request.setAttribute("fechaSalida3", fechaSalida);
			request.setAttribute("numeroPersonas3", numeroPersonas);
			
			request.setAttribute("codigoIATAPaisOrigen2", codigoPaisOrigen);
			request.setAttribute("codigoIATACiudadOrigen2", codigoCiudadOrigen);
			request.setAttribute("codigoIATAPaisDestino2", codigoPaisDestino);
			request.setAttribute("codigoIATACiudadDestino2", codigoCiudadDestino);
			LOGGER.info("Enviando datos a ofertasTransporte.jsp: " +
	                "\nFecha Entrada= " + fechaEntrada +
	                "\nFecha Salida= " + fechaSalida +
	                "\nNumero de Personas= " + numeroPersonas +
	                "\nCodigo Pais Origen= " + codigoPaisOrigen +
	                "\nCodigo Ciudad Origen= " + codigoCiudadOrigen +
	                "\nCodigo Pais Destino= " + codigoPaisDestino +
	                "\nCodigo Ciudad Destino= " + codigoCiudadDestino);
			request.setAttribute("sesionAmadeus",sesion );
			LOGGER.debug("Enviando sesion de Amadeus a ofertasTransporte.jsp");
			request.setAttribute("usuario", usuarioInfo);
			LOGGER.debug("Enviando el usuario a ofertasTransporte.jsp");
			request.getRequestDispatcher("Secure/ofertasTransporte.jsp").forward(request, response);
			break;

		case "guardarOfertaViaje":
		    Direccion direccionFinal = (Direccion) request.getSession().getAttribute("direccion_Final");
		    HotelBD hotelFinal = (HotelBD) request.getSession().getAttribute("hotel_Final");
		    Habitacion habitacionFinal = (Habitacion) request.getSession().getAttribute("habitacion_Final");
		    Usuario usuarioFinal = (Usuario) request.getSession().getAttribute("usuario");
		    numeroPersonasViajeStr = request.getParameter("numeroPersonasViaje");
		    Integer numeroPersonasViaje = Integer.valueOf(numeroPersonasViajeStr);

		    LOGGER.info("Recuperando datos de ofertasTransporte.jsp: " +
		            "\nDireccion Hotel= " + direccionFinal +
		            "\nHotel= " + hotelFinal +
		            "\nHabitacion= " + habitacionFinal +
		            "\nUsuario= " + usuarioFinal +
		            "\nViajeros= " + numeroPersonasViaje);

		    EntityManager em1 = modelo.HibernateUtils.getEmf().createEntityManager();
		    EntityTransaction transaction1 = null;

		    // Datos de vuelo
		    String aeropuerto_Origen = request.getParameter("aeropuertoOrigen");
		    String ciudad_Origen = request.getParameter("ciudadOrigen");
		    String compania_Area = request.getParameter("companiaAerea");
		    String ciudad_destino = request.getParameter("ciudadDestino");
		    String aeropuerto_Destino = request.getParameter("aeropuertoDestino");
		    String tipo_Viajero = request.getParameter("tipoViajero");
		    String precio_MedioStr = request.getParameter("precioMedio");
		    String clase_Cabina = request.getParameter("claseCabina");

		    LOGGER.info("Datos obtenidos de ofertasTransporte.jsp para crear una instancia de DatosVuelo: " +
		            "\nAeropuerto Origen= " + aeropuerto_Origen +
		            "\nCiudad Origen= " + ciudad_Origen +
		            "\nCompañía Aérea= " + compania_Area +
		            "\nCiudad Destino= " + ciudad_destino +
		            "\nAeropuerto Destino= " + aeropuerto_Destino +
		            "\nTipo Viajero= " + tipo_Viajero +
		            "\nPrecio Medio= " + precio_MedioStr +
		            "\nClase Cabina= " + clase_Cabina);

		    DatosVuelo datosVuelo = null;
		    if (aeropuerto_Origen != null && ciudad_Origen != null) {
		        Double precio_Medio = precio_MedioStr != null ? Double.valueOf(precio_MedioStr) : 0.0;
		        datosVuelo = new DatosVuelo(aeropuerto_Origen, ciudad_Origen, compania_Area, ciudad_destino, aeropuerto_Destino, tipo_Viajero, precio_Medio, clase_Cabina);
		    }

		    Viaje viaje = new Viaje(usuarioFinal, numeroPersonasViaje);

		    if (direccionFinal != null) {
		    	hotelFinal.setDireccion(direccionFinal);
		    	LOGGER.debug("Direccion subida a Base de datos");
		    }
		    if (habitacionFinal != null) {
		        viaje.setHabitacion(habitacionFinal);
		        LOGGER.info("Habitacion añadida al viaje");		        
		        hotelFinal.addHabitacion(habitacionFinal);
		        LOGGER.info("Habitacion añadida al hotel");
		    }

		    if (datosVuelo != null) {
		        viaje.setDatos_vuelo(datosVuelo);
		        LOGGER.info("Datos de vuelo añadidos al Viaje");
		    }

		    try {
		        transaction1 = em1.getTransaction();
		        LOGGER.trace("Transaccion Iniciada");
		        transaction1.begin();

		        if (datosVuelo != null) {
		            em1.persist(datosVuelo);
		            LOGGER.debug("Datos del vuelo persistidos en la Base de datos");
		        }
		        
		        if (hotelFinal != null) {
		            HotelBD hotelExistente = em1.find(HotelBD.class, hotelFinal.getId_hotel());
		            if (hotelExistente == null) {
		            	em1.persist(direccionFinal);
		            	LOGGER.debug("Direccion del Hotel se ha persistido en la base de datos");
		                em1.persist(hotelFinal);
		                LOGGER.debug("Hotel persistido en la Base de datos");
		            }
		        }
		        
		        if (habitacionFinal != null) {
		        	Habitacion habitacionExistente=em1.find(Habitacion.class, habitacionFinal.getId_habitacion());
		        	if(habitacionExistente == null) {
		        		LOGGER.info(habitacionFinal.toString());
		        		em1.persist(habitacionFinal);		        		
		        		LOGGER.debug("Habitacion persistida en la Base de datos");
		        	}
		        }

		        if (viaje != null) {
		            em1.persist(viaje);
		            LOGGER.debug("Viaje persistido en la Base de datos");
		        }

		        transaction1.commit();
		        LOGGER.trace("Commit realizado");

		    } catch (Exception e) {
		        LOGGER.error(e.getMessage(), e);
		        if (transaction1 != null && transaction1.isActive()) {
		            transaction1.rollback();
		            LOGGER.trace("Se ha realizado Rollback");
		        }
		    } finally {
		        if (em1 != null && em1.isOpen()) {
		            em1.close();
		            LOGGER.trace("Entity Manager Cerrado");
		        }
		        request.getSession().setAttribute("usuario", usuarioFinal);
		        response.sendRedirect("Secure/perfilUsuario.jsp");
		    }
		    break;

		case "eliminarViajeUsuario":

		    Usuario usuarioSeleccionado = (Usuario) request.getSession().getAttribute("UsuarioSeleccionado");
		    Integer idViajeEliminar =Integer.parseInt(request.getParameter("idViajeEliminar"));
		    String idUsuarioStr = request.getParameter("idUsuario");
		    
		    LOGGER.info(idViajeEliminar + idUsuarioStr);

		    LOGGER.info("Datos " + idViajeEliminar + " " + idUsuarioStr);
		    EntityManager emBorrar = modelo.HibernateUtils.getEmf().createEntityManager();
		    LOGGER.debug("Entity Manager creado");
		    EntityTransaction transactionBorrar = null;
		    try {
		        transactionBorrar = emBorrar.getTransaction();
		        transactionBorrar.begin();
		        LOGGER.trace("Transaccion Iniciada");
		        
		        Usuario usuarioActualizado = emBorrar.find(Usuario.class, usuarioSeleccionado.getId_usuario());
		        LOGGER.trace("Buscando usuario con ID= "+usuarioSeleccionado.getId_usuario());
		        emBorrar.lock(usuarioActualizado, LockModeType.NONE); // Forzar la inicialización de la colección

		        Viaje viajeABorrar = emBorrar.find(Viaje.class, idViajeEliminar);
		        if (viajeABorrar != null) {
		            // Utilizar el método quitarViaje para eliminar la relación
		            usuarioActualizado.quitarViaje(viajeABorrar);
		            LOGGER.info("Quitando viaje de la lista de viajes del usuario");
		            emBorrar.remove(viajeABorrar);
		            LOGGER.info("Eliminando el viaje de la Base de datos");
		        }				 
				 transactionBorrar.commit();
				 LOGGER.trace("Realizando Commit");
		    } catch (Exception e) {
		        LOGGER.error("Error: " + e.getMessage());
		        e.printStackTrace();
		        if (transactionBorrar != null && transactionBorrar.isActive()) {
		            transactionBorrar.rollback();
		            LOGGER.trace("Se ha realizado Rollback");
		        }
		    } finally {
		        if (emBorrar != null && emBorrar.isOpen()) {
		            emBorrar.close();
		            LOGGER.trace("Entity Manager cerrado");
			        request.getSession().setAttribute("usuario", usuarioSeleccionado);
			        response.sendRedirect("Secure/perfilUsuario.jsp");
		        }else {
			        request.getSession().setAttribute("usuario", usuarioSeleccionado);
			        response.sendRedirect("Secure/perfilUsuario.jsp");
		        }
		    }
		    break;
		case "borrarUsuario":
				String idUsuarioABorrar=request.getParameter("usuarioABorrar");
				Usuario usuarioA=(Usuario) request.getAttribute("usuario");
				LOGGER.info("Iniciando proceso de Borrado del Usuario");
				EntityManager emBorrarUsuario = modelo.HibernateUtils.getEmf().createEntityManager();
				LOGGER.debug("Entity Manager creado");
				EntityTransaction transactionBorrarUsuario = null;
				try {
					transactionBorrarUsuario=emBorrarUsuario.getTransaction();
					transactionBorrarUsuario.begin();
					LOGGER.trace("Transaccion  iniciada");
					
					LOGGER.info("Recuperando usuario con id: "+idUsuarioABorrar);
					Usuario usuarioABorrar= emBorrarUsuario.find(Usuario.class, idUsuarioABorrar);							
					if(usuarioABorrar != null) {
						emBorrarUsuario.remove(usuarioABorrar);
						LOGGER.info("Usuario eliminado junto a sus viajes de la base de datos");						
					}
					transactionBorrarUsuario.commit();
					LOGGER.info("Commit realizado");
				}catch(Exception e) {
					LOGGER.error("Error: "+e.getMessage());
					if (transactionBorrarUsuario != null && transactionBorrarUsuario.isActive()) {
			            transactionBorrarUsuario.rollback();
			            request.getSession().setAttribute("usuario",usuarioA );
			            LOGGER.error("Error durante el borrado del usuario, redirigiendo a la configuracion");
			            response.sendRedirect("Secure/configuracion.js");
			        }
			    } finally {
			        if (emBorrarUsuario != null && emBorrarUsuario.isOpen()) {
			            emBorrarUsuario.close();
			            LOGGER.trace("Entity Manager Cerrado");
			            LOGGER.info("Operacion Exitosa redirigiendo a la pagina de inicio de sesion");
				        response.sendRedirect("login.jsp");
			        }else {
			        	request.getSession().setAttribute("usuario",usuarioA );
				        response.sendRedirect("Secure/perfilUsuario.jsp");
			        }
			    }
		   break;
		case "Loger":
			LOGGER.info("Redirigiendo a pagina login.jsp");
			response.sendRedirect("login.jsp");
			break;

		case "iniciarSesion":
			
			// Obtén los valores de los campos de nombre de usuario y contraseña del
			// formulario
			email = request.getParameter("correoUsuario");
			password = request.getParameter("contrasenia");
			LOGGER.info("Valores obtenidos de login.jsp: "+
			"\n Correo electronico del usuario= "+email+
			"\n Contraseña del usuario= "+password);
			
			// Realiza la verificación con la base de datos
			EntityManager em = HibernateUtils.getEmf().createEntityManager();
			LOGGER.trace("Entity Manager creado");
			Query consulta = em.createQuery("SELECT u FROM Usuario u WHERE u.email = :correo");
			consulta.setParameter("correo", email);	
			LOGGER.debug("Buscando usuario con email= "+email);
			
			try {
				Usuario usuario = (Usuario) consulta.getSingleResult();

				if (usuario != null && usuario.getContrasenia().equals(password)) {
					EntityManager em2 = HibernateUtils.getEmf().createEntityManager();
					Query query2 = em2.createQuery("SELECT u.ultima_conexion_temporal FROM Usuario u WHERE u.id = :id");
					query2.setParameter("id", usuario.getId_usuario());
					
					LocalDateTime  ultima_conexion_temporal =  (LocalDateTime) query2.getSingleResult();
					
				    EntityManagerFactory emf = HibernateUtils.getEmf();
				    EntityManager em3 = emf.createEntityManager();
				    LOGGER.debug("Entity Manager creado");
				    EntityTransaction transaction = null;

				    try {
				        transaction = em3.getTransaction();
				        transaction.begin();
				        LOGGER.trace("Iniciando transaccion");

				        Usuario user = em3.find(Usuario.class, usuario.getId_usuario());
				        LOGGER.trace("Buscando usuario con id= "+usuario.getId_usuario());
				        if (user != null) {
				            user.setUltima_conexion(ultima_conexion_temporal);
				            user.setUltima_conexion_temporal(LocalDateTime.now());
				            user.setSesionActiva(true);
				            
				            em3.merge(user);
				            LOGGER.trace("Guardando cambio de sesion del usuario en base de datos");
				            transaction.commit();
				            LOGGER.info("Realizando commit");
				        }

				    } catch (Exception e) {
				        // Maneja cualquier excepción
				        if (transaction != null && transaction.isActive()) {
				            transaction.rollback();
				            LOGGER.info("Rollback realizado");
				        }
				        LOGGER.error("Error"+ e.getMessage());
				    }
				    
				    HttpSession session = request.getSession();
					session.setAttribute("usuario", usuario);
					
					// Crear una cookie con el nombre del usuario
		            Cookie userCookie = new Cookie("userEmail", email);
		            LOGGER.trace("Cookie creada con el nombre del usuario");
		            // Configurar la cookie para que expire en 7 días
		            userCookie.setMaxAge(7 * 24 * 60 * 60);
		            LOGGER.trace("Cookie configurada para que expire en 7 dias");
		            // Añadir la cookie a la respuesta
		            response.addCookie(userCookie);
					LOGGER.info("Redirigiendo a perfilUsuario.jsp");
					response.sendRedirect("Secure/perfilUsuario.jsp");
					
					
				} else {
					// Si las credenciales no son válidas, redirige de nuevo al formulario de inicio
					// de sesión con un mensaje de error
					LOGGER.error("Nombre de usuario o contraseña incorrectos");
					request.setAttribute("error", "Nombre de usuario o contraseña incorrectos");
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}

			} catch (NoResultException e) {
				LOGGER.error("Nombre de usuario o contraseña incorrectos");
				request.setAttribute("error", "Nombre de usuario o contraseña incorrectas");
				request.getRequestDispatcher("login.jsp").forward(request, response);
			} finally {
				em.close();
				LOGGER.debug("Entity Manager cerrado");
			}
			break;
			
		case "cerrarSesion":
			LOGGER.info("Cerrando Sesion de usuario");
			HttpSession session10 = request.getSession();
		    Usuario usuario10 = (Usuario) session10.getAttribute("usuario");
		    int idUsuario11 = usuario10.getId_usuario();

		    // Crea un EntityManager a partir de la EntityManagerFactory
		    EntityManagerFactory emf10 = HibernateUtils.getEmf();
		    EntityManager em10 = emf10.createEntityManager();
		    LOGGER.debug("Entity Manager creado");
		    EntityTransaction transaction10 = null;

		    try {
		        // Inicia una transacción
		        transaction10 = em10.getTransaction();
		        transaction10.begin();
		        LOGGER.trace("Transaccion iniciada");

		        // Busca al usuario en la base de datos por su id
		        Usuario user = em10.find(Usuario.class, idUsuario11);
		        LOGGER.trace("Buscando usuario con id= "+idUsuario11);
		        // Verifica si el usuario existe
		        if (user != null) {
		            user.setSesionActiva(false);
		            em10.merge(user);
		            LOGGER.trace("Guardando cambio de estado de la sesion del usuario a false en la base de datos");
		            transaction10.commit();
		            LOGGER.info("Realizando Commit");
		        }

		    } catch (Exception e) {
		        // Maneja cualquier excepción
		        if (transaction10 != null && transaction10.isActive()) {
		            LOGGER.error("Error en el cierre de Sesion: " + e.getStackTrace());
		        	transaction10.rollback();
		        	LOGGER.error("Haciendo rollback");
		        }
		        
		    } finally {

		    	em10.close();
		    	LOGGER.debug("Entity Manager cerrado");
		    	response.sendRedirect("index.jsp");
		    	LOGGER.info("Redirigiendo a la pagina principal");
		    }
			break;
		
		case "cambiar_tema":
		    // Obtén el id del usuario de la sesión
			LOGGER.info("Cambiando tema");
		    HttpSession session = request.getSession();
		    Usuario usuario = (Usuario) session.getAttribute("usuario");
		    int idUsuario = usuario.getId_usuario();

		    // Crea un EntityManager a partir de la EntityManagerFactory
		    EntityManagerFactory emf = HibernateUtils.getEmf();
		    EntityManager em2 = emf.createEntityManager();
		    LOGGER.debug("Entity Manager creado");
		    EntityTransaction transaction = null;

		    try {
		        // Inicia una transacción
		        transaction = em2.getTransaction();
		        transaction.begin();
		        LOGGER.info("Transaccion iniciada");

		        // Busca al usuario en la base de datos por su id
		        Usuario user = em2.find(Usuario.class, idUsuario);
		        LOGGER.trace("Buscando usuario con id= "+idUsuario);
		        // Verifica si el usuario existe
		        if (user != null) {
		            // Actualiza el tema del usuario
		            user.setTema(!user.getTema()); // Cambia el tema

		            // Guarda los cambios en la base de datos
		            em2.merge(user);
		            LOGGER.trace("Guardando cambio de tema en la base de datos");
		            transaction.commit();
		            LOGGER.info("Realizando commit");
		        }

		    } catch (Exception e) {
		        // Maneja cualquier excepción
		        if (transaction != null && transaction.isActive()) {
		        	LOGGER.error("Error en el cambio de tema: " + e.getStackTrace());
		            transaction.rollback();
		            LOGGER.error("Haciendo rollback");
		        }
		        e.printStackTrace();
		    } finally {

		    	em2.close();
		    	LOGGER.debug("Entity Manager cerrado");
		    	response.sendRedirect("Secure/perfilUsuario.jsp");
		    	LOGGER.info("Redirigiendo a la pagina principal de usuario");
		    }
		    break;

		case "config":
			
			LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
			response.sendRedirect("Secure/configuracion.jsp");
			break;
		
		case "validarUser":
			
			LOGGER.info("Validacion de datos del usuario");
			nombreUsuario= request.getParameter("nombreUsuario");
			
			 // Obtén el id del usuario de la sesión
		    HttpSession session2 = request.getSession();
		    Usuario usuario2 = (Usuario) session2.getAttribute("usuario");
		    int idUsuario2 = usuario2.getId_usuario();
		    // Crea un EntityManager a partir de la EntityManagerFactory
		    EntityManagerFactory emf2 = HibernateUtils.getEmf();
		    EntityManager em3 = emf2.createEntityManager();
		    LOGGER.debug("Entity Manager creado");
		    EntityTransaction transaction2 = null;

		    if (nombreUsuario.matches(".*[!¡@#$%^&*()¿?¬~].*")) {
		    	LOGGER.error("El nombre de usuario no debe contener un caracter especial");
				request.setAttribute("error", "El nombre de usuario no debe contener un caracter especial");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			} else if (nombreUsuario.length() < 3) {
				LOGGER.error("El nombre de usuario debe ser superior a 3 caracteres");
				request.setAttribute("error", "El nombre de usuario debe ser superior a 3 caracteres");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else {
				Query q1 = em3.createQuery("FROM Usuario");
				List<Usuario> usuarios = q1.getResultList();
				
			    for (Usuario user : usuarios) {
	
					if (user.getNombre().compareTo(nombreUsuario) == 0) {
						LOGGER.error("El nombre de usuario ya esta en uso");
						request.setAttribute("error", "El nombre de usuario ya esta en uso");
						request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
					}
	
				}
			    
			    try {
			    	transaction2 = em3.getTransaction();
			    	transaction2.begin();
			    	LOGGER.info("Transaccion iniciada");
			        Usuario user = em3.find(Usuario.class, idUsuario2);
			        LOGGER.trace("Buscando usuario con id= "+idUsuario2);
			        if (user != null) {
			            user.setNombre(nombreUsuario); 
			            em3.merge(user);
			            LOGGER.trace("Guardando cambio de nombre de usuario en Base de datos");
			            transaction2.commit();
			            LOGGER.info("Realizando commit");
			        }
	
			        
			    } catch (Exception e) {
			        if (transaction2 != null && transaction2.isActive()) {
			        	LOGGER.error("Error en la validacion de datos del usuario: " + e.getStackTrace());
			        	transaction2.rollback();
			        	LOGGER.error("Haciendo rollback");
			        }
			        e.printStackTrace();
			    } finally {
			    	em3.close();
			    	LOGGER.debug("Entity Manager cerrado");
			    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
			    	LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
			    }
			}
		    
		    break;
		
		case "validar_tema":
		    // Obtén el id del usuario de la sesión
			LOGGER.info("Validacion de tema del usuario");
		    HttpSession session3 = request.getSession();
		    Usuario usuario3 = (Usuario) session3.getAttribute("usuario");
		    int idUsuario3 = usuario3.getId_usuario();
		    
		    // Crea un EntityManager a partir de la EntityManagerFactory
		    EntityManagerFactory emf3 = HibernateUtils.getEmf();
		    EntityManager em4 = emf3.createEntityManager();
		    LOGGER.debug("Entity Manager creado");
		    EntityTransaction transaction3 = null;

		    try {
		        // Inicia una transacción
		        transaction3 = em4.getTransaction();
		        transaction3.begin();
		        LOGGER.info("Transaccion iniciada");

		        // Busca al usuario en la base de datos por su id
		        Usuario user = em4.find(Usuario.class, idUsuario3);
		        LOGGER.trace("Buscando usuario con id= "+idUsuario3);
		        // Verifica si el usuario existe
		        if (user != null) {
		            // Actualiza el tema del usuario
		            user.setTema(!user.getTema()); // Cambia el tema
		            // Guarda los cambios en la base de datos
		            em4.merge(user);
		            LOGGER.trace("Guardando cambio del tema en base de datos");
		            transaction3.commit();
		        }

		    } catch (Exception e) {
		        // Maneja cualquier excepción
		        if (transaction3 != null && transaction3.isActive()) {
		        	LOGGER.error("Error en la validacion de tema del usuario: " + e.getStackTrace());
		        	transaction3.rollback();
		        	LOGGER.error("Haciendo rollback");
		        	
		        }
		        e.printStackTrace();
		    } finally {
		        // Cierra el EntityManager
		    	em4.close();
		    	LOGGER.debug("Entity Manager cerrado");
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    	LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
		    }
		    break;
		    

		case "validar_correo":
			
			LOGGER.info("Validacion del correo de usuario al registrarse");
			email = request.getParameter("emailUsuario");
			if (email.length()<=10) {
				LOGGER.error("Formato de correo no valido");
				request.setAttribute("error", "Formato de correo no valido");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else {
				String extensionCorreo2 = email.substring(email.length() - 10, email.length());
				EntityManagerFactory emf4 = HibernateUtils.getEmf();
			    EntityManager em5 = emf4.createEntityManager();
				LOGGER.debug("Entity Manager Creado");
				
			    Query q2 = em5.createQuery("FROM Usuario");
				List<Usuario> usuarios2 = q2.getResultList();
				for (Usuario user : usuarios2) {
	
					if (user.getEmail().compareTo(email) == 0) {
						LOGGER.error("El correo electronico ya esta en uso");
						request.setAttribute("error", "El correo electronico ya esta en uso");
						request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
					}
	
				}
				if (extensionCorreo2.compareTo("@gmail.com") != 0) {
					LOGGER.error("Correo no valido");
					request.setAttribute("error", "Correo no valido");
					request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
					LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
				}
				else {
					request.getSession().setAttribute("email", email);
					
					token = generarToken();
					LOGGER.info("Token creado: " + token);
					
					EmailValidator.cambio_correo(email, token);
					request.getSession().setAttribute("token", token);
					LOGGER.info("Correo enviado");
					
					request.getRequestDispatcher("Secure/confirmar_correo2.jsp").forward(request, response);
					LOGGER.info("Redirigiendo a la pagina de validacion de correo al cambiarlo desde configuracion");
				}
			}
			
			
			break;
		    
		case "verificarCorreo2":
			
			LOGGER.info("Validacion del correo de usuario al cambiarlo desde la configuracion");
			HttpSession session4 = request.getSession();
		    Usuario usuario4 = (Usuario) session4.getAttribute("usuario");
		    int idUsuario4 = usuario4.getId_usuario();
		    
			codVerificacion = request.getParameter("cod_verificacion");
			email = (String) request.getSession().getAttribute("email");
			token = (String) request.getSession().getAttribute("token");
			LOGGER.debug("TokenDef: " + token);
			LOGGER.debug("codVeri: " + codVerificacion);
			if (token.compareTo(codVerificacion) != 0) {
				request.setAttribute("token", token);
				request.setAttribute("email", email);
				LOGGER.error("Codigo de verificacion incorrecto");
				request.setAttribute("error", "Codigo de verificacion incorrecto");
				request.getRequestDispatcher("Secure/confirmar_correo2.jsp").forward(request, response);
			} else {
				
				EntityManager em6 = HibernateUtils.getEmf().createEntityManager();
				EntityTransaction transaction4 = em6.getTransaction();
				
				try {
					transaction4.begin();
					LOGGER.info("Transaccion iniciada");
					
					Usuario user = em6.find(Usuario.class, idUsuario4);
					LOGGER.trace("Buscando usuario con id= "+idUsuario4);
			        if (user != null) {
			            user.setEmail(email); 
			            em6.merge(user);
			            LOGGER.trace("Guardando cambio de correo electronico en Base de datos");
			            transaction4.commit();
			            LOGGER.info("Realizando commit");
			        }
			        
			        LOGGER.debug("Nuevo correo Subido");
				} catch (Exception e) {
					LOGGER.error("Error en la validacion del correo del usuario: " + e.getMessage());
					transaction4.rollback();
					LOGGER.error("Haciendo rollback");
				} finally {
					
					em6.close();
					LOGGER.debug("Entity Manager cerrado");
					response.sendRedirect("Secure/configuracion.jsp?datPer=true");
					LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
				}
				
			}
			break;
			
		case "validar_password":
			
			LOGGER.info("Validacion de la contraseña");
			password = request.getParameter("passwordUsuario");
			
			HttpSession session5 = request.getSession();
		    Usuario usuario5 = (Usuario) session5.getAttribute("usuario");
		    email = usuario5.getEmail();
			
			
			if (!(password.matches(".*[A-Z].*"))) {
				LOGGER.error("La contraseña debe contener como mínimo una mayuscula");
				request.setAttribute("error", "La contraseña debe contener como mínimo una mayuscula");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			} 
			else if (!(password.matches(".*[0-9].*"))) {
				LOGGER.error("La contraseña debe contener un numero");
				request.setAttribute("error", "La contraseña debe contener un numero");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			} 
			else if (!(password.matches(".*[!¡@#$%^&*()¿?¬~].*"))) {
				LOGGER.error("La contraseña debe contener como mínimo un caracter especial");
				request.setAttribute("error", "La contraseña debe contener como mínimo un caracter especial");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else if ((password.length() < 8) || (password.length() > 20)) {
				LOGGER.error("a contraseña no puede ser inferior a los 8 caracteres ni superior a los 20");
				request.setAttribute("error",
						"La contraseña no puede ser inferior a los 8 caracteres ni superior a los 20");
				request.getRequestDispatcher("Secure/configuracion.jsp?datPer=true").forward(request, response);
			}
			else {
				
				request.getSession().setAttribute("email", email);
				request.getSession().setAttribute("password", password);
				
				token = generarToken();
				LOGGER.debug("Token creado: " + token);
				
				EmailValidator.cambio_password(email, token);
				request.getSession().setAttribute("token", token);
				LOGGER.debug("Correo enviado");
				
				request.getRequestDispatcher("Secure/confirmar_password.jsp").forward(request, response);
				LOGGER.info("Redirigiendo a la pagina de verificacion de contraseña");
			}
			
			
			break;
		
		case "verificar_password":
			
			LOGGER.info("Verificacion de la contraseña");
			password = (String) request.getSession().getAttribute("password");
			
			HttpSession session6 = request.getSession();
		    Usuario usuario6 = (Usuario) session6.getAttribute("usuario");
		    int idUsuario6 = usuario6.getId_usuario();
		    
			codVerificacion = request.getParameter("cod_verificacion");
			email = (String) request.getSession().getAttribute("email");
			token = (String) request.getSession().getAttribute("token");
			LOGGER.debug("TokenDef: " + token);
			LOGGER.debug("codVeri: " + codVerificacion);
			
			if (token.compareTo(codVerificacion) != 0) {
				request.setAttribute("token", token);
				request.setAttribute("email", email);
				LOGGER.error("Codigo de verificacion incorrecto");
				request.setAttribute("error", "Codigo de verificacion incorrecto");
				request.getRequestDispatcher("Secure/confirmar_password.jsp").forward(request, response);
			} else {
				
				EntityManagerFactory emf5 = HibernateUtils.getEmf();
			    EntityManager em5 = emf5.createEntityManager();
			    LOGGER.debug("Entity Manager creado");
			    EntityTransaction transaction5 = null;
				
			    try {
			    	transaction5 = em5.getTransaction();
			    	transaction5.begin();
			    	LOGGER.info("Transaccion iniciada");
			    	
			        Usuario user = em5.find(Usuario.class, idUsuario6);
			        LOGGER.trace("Buscando usuario con id= "+idUsuario6);
			        if (user != null) {
			            user.setContrasenia(password);
			            user.setUltima_modificacion_contrasenna(LocalDate.now());
			            
			            em5.merge(user);
			            LOGGER.trace("Guardando cambio de contraseña en base de datos");
			            transaction5.commit();
			            LOGGER.info("Realizando commit");
			        }

			        
			    } catch (Exception e) {
			        if (transaction5 != null && transaction5.isActive()) {
			        	LOGGER.error("Error en la verificacion de la contraseña del usuario: " + e.getStackTrace());
			        	transaction5.rollback();
			        	LOGGER.error("Haciendo rollback");
			        }
			    } finally {
			    	em5.close();
			    	LOGGER.debug("Entity Manager cerrado");
			    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
			    	LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
			    }
			
			}
			break;
			
		case "validar_telefono":
			
			LOGGER.info("Validacion del telefono");
			telefono = request.getParameter("telefonoUsuario");
			
			HttpSession session7 = request.getSession();
		    Usuario usuario7 = (Usuario) session7.getAttribute("usuario");
		    int idUsuario7 = usuario7.getId_usuario();
			
		    EntityManagerFactory emf6 = HibernateUtils.getEmf();
		    EntityManager em6 = emf6.createEntityManager();
		    LOGGER.debug("Entity Manager creado");
		    EntityTransaction transaction6 = null;
			
		    try {
		    	transaction6 = em6.getTransaction();
		    	transaction6.begin();
		    	LOGGER.info("Transaccion iniciada");
		    	
		        Usuario user = em6.find(Usuario.class, idUsuario7);
		        LOGGER.trace("Buscando usuario con id= "+idUsuario7);
		        if (user != null) {
		            user.setNum_telefono(telefono);
		            em6.merge(user);
		            LOGGER.trace("Guardando cambio de numero de telefono en base de datos");
		            transaction6.commit();
		            LOGGER.info("Realizando commit");
		        }

		        
		    } catch (Exception e) {
		        if (transaction6 != null && transaction6.isActive()) {
		        	LOGGER.error("Error en la verificacion del telefono del usuario: " + e.getStackTrace());
		        	transaction6.rollback();
		        	LOGGER.error("Haciendo rollback");
		        }
		    } finally {
		    	em6.close();
		    	LOGGER.debug("Entity Manager cerrado");
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    	LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
		    }
			
			break;
			
		case "validar_sexo":
			
			LOGGER.info("Validacion del sexo");
			sexo = request.getParameter("sexoUsuario");
			
			HttpSession session8 = request.getSession();
		    Usuario usuario8 = (Usuario) session8.getAttribute("usuario");
		    int idUsuario9 = usuario8.getId_usuario();
			
		    EntityManagerFactory emf7 = HibernateUtils.getEmf();		    
		    EntityManager em7 = emf7.createEntityManager();
		    LOGGER.debug("Entity Manager creado");
		    EntityTransaction transaction7 = null;
			
		    try {
		    	transaction7 = em7.getTransaction();
		    	transaction7.begin();
		    	LOGGER.info("Transaccion iniciada");
		    	
		        Usuario user = em7.find(Usuario.class, idUsuario9);
		        LOGGER.trace("Buscando usuario con id= "+idUsuario9);
		        if (user != null) {
		            user.setSexo(sexo);
		            em7.merge(user);
		            LOGGER.trace("Guardando cambio genero del usuario en la base de datos");
		            transaction7.commit();
		            LOGGER.info("Realizando Commit");
		        }

		        
		    } catch (Exception e) {
		        if (transaction7 != null && transaction7.isActive()) {
		        	LOGGER.error("Error en la validacion del sexo del usuario: " + e.getStackTrace());
		        	transaction7.rollback();
		        	LOGGER.error("Haciendo rollback");
		        }
		    } finally {
		    	em7.close();
		    	LOGGER.debug("Entity Manager cerrado");
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    	LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
		    }
			
			break;
			
		case "validar_fecha":
			
			LOGGER.info("Validacion de fecha");
			fecha_nacimiento = LocalDate.parse(request.getParameter("fechaUsuario"));
			
			HttpSession session9 = request.getSession();
		    Usuario usuario9 = (Usuario) session9.getAttribute("usuario");
		    int idUsuario10 = usuario9.getId_usuario();
			
		    EntityManagerFactory emf8 = HibernateUtils.getEmf();
		    EntityManager em8 = emf8.createEntityManager();
		    EntityTransaction transaction8 = null;
			
		    try {
		    	transaction8 = em8.getTransaction();
		    	transaction8.begin();
		    	LOGGER.info("Transaccion iniciada");
		    	
		        Usuario user = em8.find(Usuario.class, idUsuario10);
		        LOGGER.trace("Buscando usuario con id= "+idUsuario10);
		        if (user != null) {
		            user.setFecha_nacimiento(fecha_nacimiento);
		            em8.merge(user);
		            LOGGER.trace("Guardando cambio fecha de nacimiento en base de datos");
		            transaction8.commit();
		            LOGGER.info("Realizando commit");
		        }
		        
		    } catch (Exception e) {
		        if (transaction8 != null && transaction8.isActive()) {
		        	LOGGER.error("Error en la validacion de fecha: " + e.getStackTrace());
		        	transaction8.rollback();
		        	LOGGER.error("Haciendo rollabck");
		        }
		        e.printStackTrace();
		    } finally {
		    	em8.close();
		    	LOGGER.debug("Entity Manager cerrado");
		    	response.sendRedirect("Secure/configuracion.jsp?datPer=true");
		    	LOGGER.info("Redirigiendo a la pagina de configuracion de usuario");
		    }
			
			break;
		default:
			//Se inicia siempre al ejecutarse la aplicacion
			LOGGER.info("Iniciando aplicacion en index.jsp");
			response.sendRedirect("index.jsp");
		}

	}
	
	/**
	 * Llama al metedo encargado de generar el token de verificacion de correo electronico 
	 * @return String Token de verificacion.
	 */
	private String generarToken() {
		// Implementa la lógica para generar un token de confirmación único
		return UUID.randomUUID().toString();
	}
	
	/**
	 * Inicia sesion en la API de Amadeus mediante 2 tokens de acceso si las claves son correctas devolvera 
	 * una instancia de Amadeus con el que podremos realizar las consultas a la API
	 * @return Instancia de Amadeus.
	 */
	protected Amadeus iniciarApi() {
		//Initialize using parameters
		Amadeus amadeus = null;
		try {
			amadeus = Amadeus
				.builder(configLoader.getProperty("util.apiKeyAmadeus1"), configLoader.getProperty("util.apiKeyAmadeus2"))
		        .build();
		}catch (IllegalArgumentException e) {
			LOGGER.error("Una de las claves de acceso son incorrectas");
		}
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
