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
<link rel="stylesheet" href="Styles/Configuracion/cssConfiguracion_Claro.css">
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
			<div class="Contenedor_Botones">
				<button id="btnQuienSomos" class="Botones"><b>Quienes Somos</b></button>
			</div>
			<div class="biblioteca">
				<a class="Enlaces" href="configuracion.jsp?principal=true">Informacion Principal</a>
				<a class="Enlaces" href="configuracion.jsp?datPer=true">Datos personales</a>
				<a class="Enlaces" href="configuracion.jsp?seguridad=true">Seguridad</a>
				<a class="Enlaces" href="configuracion.jsp?privacidad=true">Privacidad</a>
				<a class="Enlaces" href="perfilUsuario.jsp">Volver atras</a>
			</div>
		</header>


		
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

%>

<%
    	if (datPer == true){
%>
				
			
			
				<table class="Tabla">
					<tr>
					    <th colspan="3" class="Contenedor_Titulo">
					    	<p class="Titulo">Información Básica<p>
					    	<p class="Texto">Esta información la pueden ver los usuarios de nuestra web para que puedan contactar contigo</p>
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
					    <td class="Columna_3"><input type="text" id="nombreUsuario" name="nombreUsuario" oninput="validarUsuario()"> <input id="confirmarUsuario" type="submit" value="Confirmar" disabled></td>
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
				</table>
				
				<table class="Tabla">
					<tr>
					    <td>Email</td>
					    <td><%= usuario.getEmail() %></td>
					    <td><input type="email" id="emailUsuario" name="emailUsuario" oninput="validarEmail()"> <input id="confirmarEmail" onclick="javascript:document.datos.opcion.value='validar_correo';document.datos.submit();" type="submit" value="Confirmar" disabled></td>
					</tr>
					<tr>
			    		<td>Tema</td>
<%
			    		if (usuario.getTema()){
%>
			    			<td>Oscuro</td>
			    			<td><input id="confirmarTemaClaro" onclick="javascript:document.datos.opcion.value='validar_tema';document.datos.submit();" value="Cambiar Tema a Claro" type="submit"></td>
<% 
			    		} else {
%>
			    			<td>Claro</td>
			    			<td><input id="confirmarTemaOscuro" onclick="javascript:document.datos.opcion.value='validar_tema';document.datos.submit();" value="Cambiar Tema a Oscuro" type="submit"></td>
<%
			    		}
%>
			    
					</tr>
					<tr>
					    <td>Contraseña</td>
					    <td ><input type="text" id="campo-oculto" readonly> <input type="hidden" id="contrasena" value="<%= usuario.getContrasenia() %>"></td>
					    <td><input type="password" id="passwordUsuario" name="passwordUsuario" oninput="validarPassword()"> <input id="confirmarPassword" onclick="javascript:document.datos.opcion.value='validar_password';document.datos.submit();" type="submit" value="Confirmar" disabled></td>
					</tr>
					<tr>
					    <td>Ultima Conexion</td>
<%
			    

					    if (usuario.getUltima_conexion() != null) {
					    	LocalDateTime fechaActual = usuario.getUltima_conexion();
					        DateTimeFormatter formatoFecha = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
					        String ultimaConexion = formatoFecha.format(fechaActual);
%>
			        		<td colspan="2">Última conexión: <%= ultimaConexion %></td>
<%
			    		} else {
%>
			        		<td colspan="2">No hay información de la última conexión disponible porque es la primera vez que inicias sesion.</td>
<%
			    		}
%>
					</tr>
				</table>
		

<%
    		}
    		else if (seguridad == true){
%>
				<p>Mostrar Seguridad</p>
		
<%
    		}
    		else if (privacidad == true){
%>
				<p>Mostrar Privacidad</p>
		
<%
		    }
		    else {
%>
				<p>Mostrar Informacion Principal</p>
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
		</script>
	</form>
</body>
</html>
