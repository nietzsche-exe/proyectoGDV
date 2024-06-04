<%@page import="com.amadeus.exceptions.ResponseException"%>
<%@page import="java.lang.module.ResolutionException"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.amadeus.exceptions.ClientException"%>
<%@page import="com.amadeus.resources.Activity"%>
<%@page import="com.amadeus.Params"%>
<%@page import="com.amadeus.Amadeus"%>
<%@page import="modelo.HotelBD"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="jakarta.persistence.Query"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Viaje"%>
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.HotelBD"%>
<%@page import="modelo.DatosVuelo"%>
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager"%>
<%@page import="jakarta.persistence.EntityTransaction"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Transaction"%>
<%@page import="util.ConfigLoader" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Perfil de Usuario</title>
<%
// Obtiene la sesión actual
HttpSession session2 = request.getSession(false);
ConfigLoader configLoader = new ConfigLoader();
// Verifica si la sesión existe y si el usuario está autenticado
if (session2 == null || session2.getAttribute("usuario") == null) {
	response.sendRedirect("login.jsp");
	return;
}
//Sesion Amadeus

Amadeus amadeus = Amadeus.builder(configLoader.getProperty("util.apiKeyAmadeus1"), configLoader.getProperty("util.apiKeyAmadeus2")).build();

// Obtiene los datos del usuario almacenados en la sesión
Usuario usuario = (Usuario) session2.getAttribute("usuario");

//Enviar usuario
session2.setAttribute("UsuarioSeleccionado", usuario);
List<Viaje> listaViajes = new ArrayList<Viaje>();
// Manejo del EntityManager
EntityManager em = HibernateUtils.getEmf().createEntityManager();
try {
	Query query = em.createQuery("SELECT u.tema, u.sesionActiva FROM Usuario u WHERE u.id = :idUsuario");
	query.setParameter("idUsuario", usuario.getId_usuario());

	Object[] resultado = (Object[]) query.getSingleResult();

	Boolean tema = (Boolean) resultado[0];
	Boolean sesion_Activa = (Boolean) resultado[1];
	
	usuario.setTema(tema);
	usuario.setSesionActiva(sesion_Activa);
	
	Query queryViajes = em.createQuery("SELECT v FROM Viaje v " + "JOIN FETCH v.habitacion h " + "JOIN FETCH h.hotel "
	+ "JOIN FETCH v.datos_vuelo dv " + "WHERE v.usuario.id_usuario = :idUsuario");
	queryViajes.setParameter("idUsuario", usuario.getId_usuario());
	listaViajes = queryViajes.getResultList();
	

} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (em != null) {
		em.close();
	}
}

	
if (usuario.getTema() == false) {
%>
	<link rel="stylesheet" href="../Styles/Perfil_Usuario/cssPerfilUsuario_Claro.css">
<%
} else {
%>
	<link rel="stylesheet" href="../Styles/Perfil_Usuario/cssPerfilUsuario_Oscuro.css">
<%
}
%>
</head>
<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada");
%>
<%
	if (usuario.getSesionActiva() == false) {
%>
	<form name="tema" action="../LoginController" method="POST">
		<input type="hidden" name="opcion" value="cambiar_tema">

		<div class="Contenedor_SesionCerrada">
			<p id="Titulo">UPS</p>
			<p id="Texto">
				<img id="imgAdvertencia" src="../Resources/advertencia.png">
				Tu sesión está cerrada <img id="imgAdvertencia"
					src="../Resources/advertencia.png">
			</p>
			<p id="Texto">Inicia esión otra vez.</p>
			<a id="Boton_Loger" href="javascript:void(0)"
				onclick="javascript:document.tema.opcion.value='Loger';document.tema.submit();">Iniciar
				Sesion</a>
		</div>
	</form>
<%
	} else {

%>
		<form name="tema" action="../LoginController" method="POST">
			<input type="hidden" name="opcion" value="cambiar_tema">
	
			<header class="Encabezado">
				<div class="Contenedor_Botones">
					<button id="btnCreacionViaje" onclick="javascript:document.tema.opcion.value='NuevoViaje';document.tema.submit();" 
						class="Botones"> Creación de viaje </button>
				</div>
				
				<div class="Contenedor_Logo">
					<img id="logo" alt="Logo" src="../Resources/logo_2.0.jpeg">
				</div>
				
				<div id="menu-container">
					<img src="../Resources/perfil.png" alt="Menú" id="menu-icon">
					<ul id="menu">
						<li id="nada">&nbsp;</li>
						<li id="usuario"><%=usuario.getNombre()%></li>
						<li id="correo"><%=usuario.getEmail()%></li>
						<li>&nbsp;</li>
						<li class="Botones_Despliegue">
							<a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='cerrarSesion';document.tema.submit();">
								<img id="imgSalir" src="../Resources/salir.png"> &nbsp; &nbsp; Cerrar Sesion</a>
						</li>
						<li class="Botones_Despliegue">
							<a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='config';document.tema.submit();">
								<img id="imgConfig" src="../Resources/configuracion.png"> &nbsp; &nbsp; Configuracion</a>
						</li>
<%
						if (usuario.getTema() == false) {
%>
							<li id="btnCambiarTema" class="Botones_Despliegue">
								<a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='cambiar_tema';document.tema.submit();">
									<img id="imgConfig" src="../Resources/oscuro.png"> &nbsp; &nbsp; Cambiar tema a oscuro</a>
							</li>
<%
						} else {
%>
							<li id="btnCambiarTema" class="Botones_Despliegue">
								<a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='cambiar_tema';document.tema.submit();">
									<img id="imgConfig" src="../Resources/claro.png"> &nbsp; &nbsp; Cambiar tema a claro</a>
							</li>
<%
						}
%>
					</ul>
				</div>
			</header>
	
		</form>
<%
		if (listaViajes != null) {
	
			for (Viaje viaje : listaViajes) {
				Habitacion habitacion = viaje.getHabitacion();
				HotelBD hotel = habitacion.getHotelBD();
				DatosVuelo datosVuelo = viaje.getDatos_vuelo();
	
				Double resultadoTotal=datosVuelo.getPrecioMedio()+habitacion.getPrecio_total();;
				resultadoTotal=Math.ceil(resultadoTotal);
%>
				<div class="Contenedor_Viajes">
		
					<table class="Tabla_Viajes">
						<tr class="Contenedor_Titulo">
							<th>Codigo Viaje</th>
							<th>Nombre Hotel</th>
							<th>Precio</th>
							<th>Noche</th>
							<th>Fecha Entrada</th>
							<th>Fecha Salida</th>
							<th>NºCamas</th>
							<th>Origen</th>
							<th>Destino</th>
							<th>Precio Vuelo Total</th>
							<th>Numero Viajero</th>
							<th>Total Viaje</th>
						</tr>
						<tr class="Filas">
							<td class="Columna_1"><%=viaje.getId_viaje()%></td>
							<td class="Columna_2"><%=hotel.getNombre_hotel()%></td>
							<td class="Columna_3"><%=habitacion.getPrecio_total()%></td>
							<td class="Columna_4"><%=habitacion.getPrecio_noche()%></td>
							<td class="Columna_5"><%=habitacion.getFecha_entrada()%></td>
							<td class="Columna_6"><%=habitacion.getFecha_salida()%></td>
							<td class="Columna_7"><%=habitacion.getNumero_camas()%></td>
							<td class="Columna_8"><%=datosVuelo.getCiudadOrigen()%></td>
							<td class="Columna_9"><%=datosVuelo.getCiudadDestino()%></td>
							<td><%=datosVuelo.getPrecioMedio() %></td>
							<td><%=viaje.getNumeroViajeros() %></td>
							<td><%=resultadoTotal%></td>
							<td class="Columna_10">
								<form name="eliminarViajeUsuario" action="../LoginController?opcion=eliminarViajeUsuario" method="post">
								
									<input type="hidden" name="idUsuario" value="<%=usuario.getId_usuario()%>"> 
									<input type="hidden" name="idViajeEliminar" value="<%=viaje.getId_viaje()%>"> 
									<input id="Boton_Eliminar" type="submit" value="Eliminar">
									
								</form>
							</td>
						</tr>
		
					</table>
				
<%
					System.out.println(hotel.getLatitud()+ " "+hotel.getLongitud());
					if (hotel.getLatitud() != null&&hotel.getLongitud()!=null) {
		
						try {
							Activity[] activities = amadeus.shopping.activities.
									get(Params.with("latitude", hotel.getLatitud()).and("longitude", hotel.getLongitud()));
							
							try{
								int posicionActividad = (int) (Math.random() * activities.length);
								System.out.println(posicionActividad);
%>
								<h3 id="Titulo_Turismo"><%=activities[posicionActividad].getName()%></h3>
<%
								String[] stringsimagen = activities[posicionActividad].getPictures();
%>
								<img id="imgTurismo" src="<%=stringsimagen[0]%>">
								<p id="Texto_Turismo">	
<%
									if(activities[posicionActividad].getShortDescription()!=null){
%>
										<%= activities[posicionActividad].getShortDescription()%>
<% 
									}
%>
									<br>
<%
									if(activities[posicionActividad].getDescription()!=null){
%>
										<%= activities[posicionActividad].getDescription()%>
<% 
									}
%>
								</p>
<%
								if(activities[posicionActividad].getBookingLink()!=null){
%>									
									<a id="enlace_Turismo" target="_blank" rel="noopener noreferrer" href="<%= activities[posicionActividad].getBookingLink()%>">Pulsa aquí para mas información.</a>
<%
								}

							}catch(ArrayIndexOutOfBoundsException e) {
								System.out.println("No hay mas puntos de interes en la lista.");	
							}
					
						} 
						catch (ClientException e) {
							System.out.println("Ubicacion no dispone de puntos de interes");
						}catch(ResponseException e){
							System.out.println("Error de verificacion de clave de acceso a la api"+e.getMessage());							
						}
						catch(NullPointerException e) {
			    			System.out.println("Error :"+e.getMessage());
			    		}
			
					}
%>
				</div>
<%
			}
		}
	}

%>

	<script src="../JavaScript/script.js"></script>
	
</body>

</html>

