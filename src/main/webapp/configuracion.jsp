<%@page import="java.time.LocalDate"%>
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
	
	Query query = em.createQuery("SELECT u.nombre, u.tema, u.email, u.contrasenia, u.ultima_conexion, u.sexo, " + 
									"u.num_telefono, u.fecha_nacimiento, u.ultima_modificacion_contrasenna FROM Usuario u WHERE u.id = :idUsuario");
	query.setParameter("idUsuario", usuario.getId_usuario());

	Object[] resultado = (Object[]) query.getSingleResult();

	String nom = (String) resultado[0];
	Boolean tema = (Boolean) resultado[1];
	String email = (String) resultado[2];
	String password = (String) resultado[3];
	LocalDateTime ultima_Conexion = (LocalDateTime) resultado[4];
	String sexo = (String) resultado[5];
	String telefono = (String) resultado[6];
	LocalDate fecha_nacimiento = (LocalDate) resultado[7];
	LocalDate ultima_modificacion_contrasenna = (LocalDate) resultado[8];
	
	
	usuario.setNombre(nom);
	usuario.setTema(tema);
	usuario.setEmail(email);
	usuario.setContrasenia(password);
	usuario.setUltima_conexion(ultima_Conexion);
	usuario.setSexo(sexo);
	usuario.setNum_telefono(telefono);
	usuario.setFecha_nacimiento(fecha_nacimiento);
	usuario.setUltima_modificacion_contrasenna(ultima_modificacion_contrasenna);
	
	
	boolean principal = true, datPer = false, seguridad = false;
	
	
	String principalParam = request.getParameter("principal");
	String datPerParam = request.getParameter("datPer");
	String seguridadParam = request.getParameter("seguridad");
	
	if (principalParam != null && principalParam.equals("true")) {
		principal = true;
		datPer = false;
		seguridad = false;
	}
	if (datPerParam != null && datPerParam.equals("true")) {
		principal = false;
		datPer = true;
		seguridad = false;
	}
	if (seguridadParam != null && seguridadParam.equals("true")) {
		principal = false;
		datPer = false;
		seguridad = true;
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
							<a class="Enlaces" id="Boton_3" href="configuracion.jsp?seguridad=true">Seguridad / Privacidad</a>
<%	
						}
						else {
%>
							<a class="Enlaces" href="configuracion.jsp?seguridad=true">Seguridad / Privacidad</a>
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
<%
					    	LocalDate fecha_N = usuario.getFecha_nacimiento();
					        DateTimeFormatter formatoNacimiento = DateTimeFormatter.ofPattern("dd / MM / yyyy");
					        String nacimiento = formatoNacimiento.format(fecha_N);
%>
					    <td class="Columna_2"><%= nacimiento %></td>
<%
							LocalDate fechaMinima = LocalDate.now().minusYears(18);
%>
					    <td class="Columna_3">
							<input type="date" id="fechaUsuario" name="fechaUsuario" max="<%= fechaMinima %>" oninput="validarFecha()">
							<input class="Confirmar" id="confirmarFecha" onclick="javascript:document.datos.opcion.value='validar_fecha';document.datos.submit();" type="submit" value="Confirmar" disabled>
						</td>
					</tr>
					<tr class="Filas">
					    <td class="Columna_1">Sexo</td>
					    <td class="Columna_2"><%= usuario.getSexo() %></td>
					    <td class="Columna_3">
						    <select id="sexoUsuario" class="Opciones" name="sexoUsuario">
								<option value="Masculino">Masculino</option>
					            <option value="Femenino">Femenino</option>
					            <option value="Otro">Otro</option>
					        </select>
					        <input class="Confirmar" id="confirmarSexo" onclick="javascript:document.datos.opcion.value='validar_sexo';document.datos.submit();" type="submit" value="Confirmar">
					    </td>
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
					    <td class="Columna_2"><%= usuario.getNum_telefono() %></td>
					    <td class="Columna_3"><input type="number" id="telefonoUsuario" name="telefonoUsuario" oninput="validarTelefono()"> <input class="Confirmar" id="confirmarTelefono" onclick="javascript:document.datos.opcion.value='validar_telefono';document.datos.submit();" type="submit" value="Confirmar" disabled></td>
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
					    if (usuario.getUltima_modificacion_contrasenna() != null) {
					    	
					    	LocalDate fecha = usuario.getUltima_modificacion_contrasenna();
					        DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("dd / MM / yyyy");
					        String ultimaConexion = formatoFecha.format(fecha);
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
				<div class="Contenedor_Texto_Seguridad">
					<div class="Contenedor_Arriba">
						<p>Aqui va el contenido de acceso</p>
					</div>
					<div class="Contenedor_Arriba">
						<p>Aqui va el contenido de contrasenna</p>
					</div>
					<div class="Contenedor_Centro">
						<p>Aqui va el contenido de seguridad del sistema</p>
					</div>
				</div>
<%
    		}
		    else {
%>
				<div class="Contenedor_Informacion_Principal">
					<div class="Titulo-Resumen">
						<p class="Titulo2">
							Resumen del proyecto
						</p>
						<p class="Texto1">
							El proyecto GDV, abreviatura de Gestión de Viajes, tiene como objetivo primordial simplificar la búsqueda en línea de 
							ofertas de viajes y destinos turísticos. Esto será posible a través de una aplicación web diseñada para permitir 
							a los usuarios registrarse, generar itinerarios personalizados y crear viajes según sus preferencias y datos suministrados.
						</p>
					</div>
					
					<div class="Contenedor_Informacion_Arriba">
						<p class="titulo3"><b>Registro e Inicio de Sesión: </b></p>
						<p class="Texto2">
							Los usuarios pueden registrarse con un nombre de usuario único, correo electrónico y contraseña. 
							Se establecen requisitos para cada campo, como longitud mínima y restricciones de caracteres. El correo electrónico debe ser 
							único y del dominio "@gmail.com". Se confirma la dirección de correo electrónico mediante tokens. Se implementa un sistema 
							de inicio de sesión que muestra la fecha de la última conexión del usuario.
						</p>
					</div>
					
					
					<div class="Contenedor_Informacion_Arriba">
						<p class="titulo3"><b>Creación de Viajes: </b></p>
						<p class="Texto2">
							Los usuarios pueden crear viajes proporcionando información como destino, fechas, número de personas, 
							rango de precios y origen del viaje. Tienen la opción de permitir que la aplicación acceda a su ubicación.
						</p>
					</div>
					
					<div class="Contenedor_Informacion_Arriba">
						<p class="titulo3"><b>Búsqueda de Ofertas y Creación de Itinerarios: </b></p>
						<p class="Texto2">
							La aplicación utiliza APIs para buscar ofertas de vuelos y alojamientos en 
							varias páginas web. Se genera un itinerario personalizado para cada usuario, que incluye lugares turísticos populares como museos, 
							restaurantes y actividades.
						</p>
					</div>
					
					<div class="Contenedor_Informacion_Arriba">
						<p class="titulo3"><b>Notificaciones por Email: </b></p>
						<p class="Texto2">		
							Se envían alertas por correo electrónico a los usuarios para recordar fechas importantes relacionadas 
							con sus viajes.
						</p>
					</div>
					
					<div class="Contenedor_Informacion_Arriba">
						<p class="titulo3"><b>Gestión de Viajes: </b></p>
						<p class="Texto2">		
							Los usuarios pueden eliminar los viajes que ya no deseen mantener.
						</p>
					</div>
					
					<div class="Contenedor_Informacion_Arriba">
						<p class="titulo3"><b>Configuración de Usuario: </b></p>
						<p class="Texto2">		
							Se proporciona un apartado de ajustes donde los usuarios pueden cambiar su nombre de usuario, 
							contraseña, correo electrónico, activar un modo oscuro y ver un historial de viajes realizados.
						</p>
					</div>
				</div>
<%
    		}
%>

		<script>
			/*	
				Comprueba que todos los campos esten rellenados, cuando todos esten completos
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
				var emailUsuario = document.getElementById("emailUsuario").value;
				var btnEmail=document.getElementById("confirmarEmail");
				
				if (emailUsuario === "") {
					btnEmail.disabled = true;                	
	            } else {
	            	btnEmail.disabled = false;
	            }
			}
			
			function validarTelefono() {
			    var telefonoUsuario = document.getElementById("telefonoUsuario").value;
			    var btnTelefono = document.getElementById("confirmarTelefono");
			    var regex = /^[6-7]\d{8}$/;

			    if (telefonoUsuario === "" || !regex.test(telefonoUsuario)) {
			        btnTelefono.disabled = true;
			    } else {
			        btnTelefono.disabled = false;
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
			
			function validarFecha() {
			    var fechaUsuario = document.getElementById("fechaUsuario").value;
			    var btnFecha = document.getElementById("confirmarFecha");
			    var fechaNacimiento = new Date(fechaUsuario);
			    var hoy = new Date();
			    var edad = hoy.getFullYear() - fechaNacimiento.getFullYear();
			    var mes = hoy.getMonth() - fechaNacimiento.getMonth();
			    
			    if (mes < 0 || (mes === 0 && hoy.getDate() < fechaNacimiento.getDate())) {
			        edad--;
			    }

			    if (fechaUsuario === "" || edad < 18 || edad > 130) {
			        btnFecha.disabled = true;
			    } else {
			        btnFecha.disabled = false;
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
