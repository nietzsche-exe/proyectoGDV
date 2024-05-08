<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="jakarta.persistence.Query"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager"%>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<%
	HttpSession a = request.getSession();
	Usuario usuario = (Usuario) a.getAttribute("usuario");
	
	EntityManager em = HibernateUtils.getEmf().createEntityManager();
	
	Query query = em.createQuery("SELECT u.nombre FROM Usuario u WHERE u.id = :idUsuario");
	query.setParameter("idUsuario", usuario.getId_usuario());
	
	String nom = (String) query.getSingleResult();
	
	usuario.setNombre(nom);
	
	Query query2 = em.createQuery("SELECT u.tema FROM Usuario u WHERE u.id = :id");
	query2.setParameter("id", usuario.getId_usuario());
	
	Boolean tema = (Boolean) query2.getSingleResult();
	
	usuario.setTema(tema);
	
	Query query3 = em.createQuery("SELECT u.email FROM Usuario u WHERE u.id = :idUsuario");
	query3.setParameter("idUsuario", usuario.getId_usuario());
	
	String email = (String) query3.getSingleResult();
	
	usuario.setEmail(email);
	
	Query query4 = em.createQuery("SELECT u.contrasenia FROM Usuario u WHERE u.id = :idUsuario");
	query4.setParameter("idUsuario", usuario.getId_usuario());
	
	String password = (String) query4.getSingleResult();
	
	usuario.setContrasenia(password);
	
	Query query5 = em.createQuery("SELECT u.ultima_conexion FROM Usuario u WHERE u.id = :idUsuario");
	query5.setParameter("idUsuario", usuario.getId_usuario());
	
	LocalDateTime ultima_conexion = (LocalDateTime) query5.getSingleResult();
	
	usuario.setUltima_conexion(ultima_conexion);
	
	boolean principal = true, datPer = false, seguridad = false, privacidad = false;
	
	
	String principalParam = request.getParameter("principal");
	String datPerParam = request.getParameter("datPer");
	String seguridadParam = request.getParameter("seguridad");
	String privacidadParam = request.getParameter("privacidad");
	
	if (principalParam != null && principalParam.equals("true")) {
		principal = true;
		datPer = false;
		seguridad = false;
		privacidad = false;
	}
	if (datPerParam != null && datPerParam.equals("true")) {
		principal = false;
		datPer = true;
		seguridad = false;
		privacidad = false;
	}
	if (seguridadParam != null && seguridadParam.equals("true")) {
		principal = false;
		datPer = false;
		seguridad = true;
		privacidad = false;
	}
	if (privacidadParam != null && privacidadParam.equals("true")) {
		principal = false;
		datPer = false;
		seguridad = false;
		privacidad = true;
	}
	if(usuario.getTema() == false) {
%>
	
		<link rel="stylesheet" href="Styles/Configuracion/cssConfiguracion_Claro.css">
<%
	} else {
%>  
		<link rel="stylesheet" href="Styles/Configuracion/cssConfiguracion_Oscuro.css">
<%
	}
%>
<meta charset="UTF-8">
<title>Página Configuracion</title>
</head>
<body>
	<form name="datos" action="LoginController" method="post" onsubmit="return validarInputs()">
		<input type="hidden" name="opcion" value="validarUser">
		
		

		

				<header class="Encabezado">
					<div class="Contenedor_Logo">
						<img id="logo" alt="Logo" src="Resources/logo.png">
					</div>
					
					<div class="biblioteca">
<%
						if (principal == true){
%>
							<a class="Enlaces" id="Boton_1" href="configuracion.jsp?principal=true">Informacion Principal</a>
<%	
						}
						else {
%>
							<a class="Enlaces" href="configuracion.jsp?principal=true">Informacion Principal</a>
<%
						}
						if (datPer == true){
%>
							<a class="Enlaces" id="Boton_2" href="configuracion.jsp?datPer=true">Datos personales</a>
<%	
						}
						else {
%>
							<a class="Enlaces" href="configuracion.jsp?datPer=true">Datos personales</a>
<%
						}
						if (seguridad == true){
%>
							<a class="Enlaces" id="Boton_3" href="configuracion.jsp?seguridad=true">Seguridad</a>
<%	
						}
						else {
%>
							<a class="Enlaces" href="configuracion.jsp?seguridad=true">Seguridad</a>
<%
						}
						if (privacidad == true){
%>
							<a class="Enlaces" id="Boton_4" href="configuracion.jsp?privacidad=true">Privacidad</a>
<%	
						}
						else {
%>
							<a class="Enlaces" href="configuracion.jsp?privacidad=true">Privacidad</a>
<%
						}
%>
						<a class="Enlaces" href="perfilUsuario.jsp">Volver atras</a>
					</div>
				</header>

<%
    	if (datPer == true){
%>
				
			
			
				<table class="Tabla">
					<tr>
					    <th colspan="3" class="Contenedor_Titulo">
					    	<p class="Titulo">Información Básica<p>
					    	<p>
					    		<c:if test="${not empty error}">
								<p style="color: red;">${error}</p>
								</c:if>
							</p>
					    </th>	
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Foto de perfil</td>
					    <td class="Columna_2">Aquí va la foto de perfil</td>
					    <td class="Columna_3">Cambiar foto de perfil</td>
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Usuario</td>
					    <td class="Columna_2"><%= usuario.getNombre() %></td>
					    <td class="Columna_3"><input type="text" id="nombreUsuario" name="nombreUsuario" oninput="validarUsuario()"> <input class="Confirmar" id="confirmarUsuario" type="submit" value="Confirmar" disabled></td>
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Fecha de nacimiento</td>
					    <td class="Columna_2">Aquí va la fecha</td>
					    <td class="Columna_3">Cambiar fecha de nacimiento</td>
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Sexo</td>
					    <td class="Columna_2">Aquí va el sexo</td>
					    <td class="Columna_3">Cambiar sexo</td>
					</tr>
					<tr class="Filas">
			    		<td class="Columna_1">Tema</td>
<%
			    		if (usuario.getTema()){
%>
			    			<td class="Columna_2">Oscuro</td>
			    			<td class="Columna_3"><input class="Confirmar" id="confirmarTemaClaro" onclick="javascript:document.datos.opcion.value='validar_tema';document.datos.submit();" value="Cambiar Tema a Claro" type="submit"></td>
<% 
			    		} else {
%>
			    			<td class="Columna_2">Claro</td>
			    			<td class="Columna_3"><input class="Confirmar" id="confirmarTemaOscuro" onclick="javascript:document.datos.opcion.value='validar_tema';document.datos.submit();" value="Cambiar Tema a Oscuro" type="submit"></td>
<%
			    		}
%>
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Última Conexión</td>
<%
					    if (usuario.getUltima_conexion() != null) {
					    	
					    	LocalDateTime fechaActual = usuario.getUltima_conexion();
					        DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
					        String ultimaConexion = formatoFecha.format(fechaActual);
%>
			        		<td colspan="2" class="Columna_2">Última conexión: <%= ultimaConexion %></td>
<%
			    		} else {
%>
			        		<td colspan="2" class="Columna_2">No hay información de la última conexión disponible porque es la primera vez que inicias sesion.</td>
<%
			    		}
%>
					</tr>
				</table>
				
				<table class="Tabla">
					<tr class="Filas">
					    <th colspan="3" class="Contenedor_Titulo">
					    	<p class="Titulo">Información de Contacto<p>
					    	<p class="Texto">Esta información la pueden ver los usuarios de nuestra web para que puedan contactar contigo</p>
					    	<p>
					    		<c:if test="${not empty error}">
								<p style="color: red;">${error}</p>
								</c:if>
							</p>
					    </th>	
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Email</td>
					    <td class="Columna_2"><%= usuario.getEmail() %></td>
					    <td class="Columna_3"><input type="email" id="emailUsuario" name="emailUsuario" oninput="validarEmail()"> <input class="Confirmar" id="confirmarEmail" onclick="javascript:document.datos.opcion.value='validar_correo';document.datos.submit();" type="submit" value="Confirmar" disabled></td>
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Número de Telefono</td>
					    <td class="Columna_2">Aquí va el telefono</td>
					    <td class="Columna_3">Cambiar telefono</td>
					</tr>
				</table>
				
				<table class="Tabla">
					<tr>
					    <th colspan="3" class="Contenedor_Titulo">
					    	<p class="Titulo">Contraseña<p>
					    	<p class="Texto">Aseguraté de que nadie la sepa</p>
					    	<p>
					    		<c:if test="${not empty error}">
								<p style="color: red;">${error}</p>
								</c:if>
							</p>
					    </th>	
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Contraseña</td>
					    <td class="Columna_2"><input type="text" id="campo-oculto" readonly> <input type="hidden" id="contrasena" value="<%= usuario.getContrasenia() %>"></td>
					    <td class="Columna_3"><input type="password" id="passwordUsuario" name="passwordUsuario" oninput="validarPassword()"> <input id="confirmarPassword" class="Confirmar" onclick="javascript:document.datos.opcion.value='validar_password';document.datos.submit();" type="submit" value="Confirmar" disabled></td>
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Última Modificación</td>
<%
					    if (usuario.getUltima_conexion() != null) {
					    	
					    	LocalDateTime fechaActual = usuario.getUltima_conexion();
					        DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
					        String ultimaConexion = formatoFecha.format(fechaActual);
%>
			        		<td colspan="2" class="Columna_2">Última modificación: <%= ultimaConexion %></td>
<%
			    		} else {
%>
			        		<td colspan="2" class="Columna_2">No hay información de la última vez que la modificaste.</td>
<%
			    		}
%>
					</tr>
				</table>
		

<%
    		}
    		else if (seguridad == true){
%>
		
<%
    		}
    		else if (privacidad == true){
%>
		
<%
		    }
		    else {
%>
				<div class="Contenedor_Texto">
					<p class="Titulo2">
						Resumen del proyecto
					</p>
					<p class="Texto2">
						El proyecto GDV, abreviatura de Gestión de Viajes, tiene como objetivo primordial simplificar la búsqueda en línea de 
						ofertas de viajes y destinos turísticos. Esto será posible a través de una aplicación web diseñada para permitir 
						a los usuarios registrarse, generar itinerarios personalizados y crear viajes según sus preferencias y datos suministrados.
					</p>
					<br>
					<p class="Texto2">
						Registro e Inicio de Sesión: Los usuarios pueden registrarse con un nombre de usuario único, correo electrónico y contraseña. 
						Se establecen requisitos para cada campo, como longitud mínima y restricciones de caracteres. El correo electrónico debe ser 
						único y del dominio "@gmail.com". Se confirma la dirección de correo electrónico mediante tokens. Se implementa un sistema 
						de inicio de sesión que muestra la fecha de la última conexión del usuario.
					</p>
					<p class="Texto2">
						Creación de Viajes: Los usuarios pueden crear viajes proporcionando información como destino, fechas, número de personas, 
						rango de precios y origen del viaje. Tienen la opción de permitir que la aplicación acceda a su ubicación.
					</p>
					<p class="Texto2">
						Búsqueda de Ofertas y Creación de Itinerarios: La aplicación utiliza APIs para buscar ofertas de vuelos y alojamientos en 
						varias páginas web. Se genera un itinerario personalizado para cada usuario, que incluye lugares turísticos populares como museos, 
						restaurantes y actividades.
					</p>
					<p class="Texto2">		
						Notificaciones por Email: Se envían alertas por correo electrónico a los usuarios para recordar fechas importantes relacionadas 
						con sus viajes.
					</p>
					<p class="Texto2">		
						Gestión de Viajes: Los usuarios pueden eliminar los viajes que ya no deseen mantener.
					</p>
					<p class="Texto2">		
						Configuración de Usuario: Se proporciona un apartado de ajustes donde los usuarios pueden cambiar su nombre de usuario, 
						contraseña, correo electrónico, activar un modo oscuro y ver un historial de viajes realizados.
					</p>
					
					
				</div>
<%
    		}
%>

		<script>
		/*Comprueba que todos los campos esten rellenados, cuando todos esten completos
			comprobara que ambas contraseñas sean iguales,
			entonces habilitara el boton "Confirmar"
			*/
			function validarUsuario(){
				var nombreUsuario = document.getElementById("nombreUsuario").value;
				var btnNombre=document.getElementById("confirmarUsuario");
				
				if (nombreUsuario === "") {
					btnNombre.disabled = true;                	
	            } else {
	            	btnNombre.disabled = false;
	            }
			}
			
			function validarEmail(){
				var nombreUsuario = document.getElementById("emailUsuario").value;
				var btnEmail=document.getElementById("confirmarEmail");
				
				if (nombreUsuario === "") {
					btnEmail.disabled = true;                	
	            } else {
	            	btnEmail.disabled = false;
	            }
			}
			
			function validarPassword(){
				var passwordUsuario = document.getElementById("passwordUsuario").value;
				var btnPassword=document.getElementById("confirmarPassword");
				
				if (passwordUsuario === "") {
					btnPassword.disabled = true;                	
	            } else {
	            	btnPassword.disabled = false;
	            }
			}
			
			window.onload = function() {
	            // Obtener la contraseña predefinida
	            var contrasena = document.getElementById("contrasena").value;
	            // Obtener la longitud de la contraseña
	            var longitud = contrasena.length;
	            // Crear una cadena de puntos de la misma longitud
	            var puntos = "*".repeat(longitud);
	            // Asignar la cadena de puntos al campo de contraseña
	            document.getElementById("campo-oculto").value = puntos;
	        };
	        
	        $(document).ready(function(){
	            // Cuando se haga clic en un título
	            $('.Titulo2').click(function(){
	                // Encuentra el siguiente elemento de clase Texto2 y cambia su visibilidad
	                $(this).next('.Texto2').slideToggle();
	            });
	        });

		</script>
	</form>
</body>
</html>
