<%@page import="jakarta.persistence.Query"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="Styles/cssConfiguracion_Claro.css">
<meta charset="UTF-8">
<title>Página Configuracion</title>


</head>
<body>
  <form name="datos" action="LoginController" method="post" onsubmit="return validarInputs()">
		<input type="hidden" name="opcion" value="validarUser">



<p>Esta es la pagina de configuracion</p>


<%
// Obtiene la sesión actual
HttpSession a = request.getSession();
// Obtiene los datos del usuario almacenados en la sesión

Usuario usuario = (Usuario) a.getAttribute("usuario");

EntityManager em = HibernateUtils.getEmf().createEntityManager();

Query query = em.createQuery("SELECT u.nombre FROM Usuario u WHERE u.id = :id");
query.setParameter("id", usuario.getId_usuario());

String nom = (String) query.getSingleResult();

usuario.setNombre(nom);

boolean principal = true, datPer = false, seguridad = false, privacidad = false;

if(usuario != null) {
%>
	<p>Bienvenido, <%= usuario.getNombre() %> </p>
<%
} else {
	%><p>Bienvenido</p><%
}
%>

<div class="biblioteca">
	<ul>
		<li><a href="configuracion.jsp?principal=true">Informacion Principal</a></li>
		<li><a href="configuracion.jsp?datPer=true">Datos personales</a></li>
		<li><a href="configuracion.jsp?seguridad=true">Seguridad</a></li>
		<li><a href="configuracion.jsp?privacidad=true">Privacidad</a></li>
	</ul>
</div>


<%
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
<div class="resultados">
<%
    if (datPer == true){
%>
	
		<p>Mostrar Datos Personales</p>
		
		<table class="a">
			<tr>
			    <th>Datos</th>
			    <th>Información Personal</th>
			    <th>Cambiar datos</th>
			</tr>
			<tr>
			    <td>Usuario</td>
			    <td><%= usuario.getNombre() %></td>
			    <td><input type="text" id="nombreUsuario" name="nombreUsuario" oninput="validarUsuario()"> <input id="confirmarUsuario" type="submit" value="Confirmar" disabled></td>
			</tr>
			<tr>
			    <td>Email</td>
			    <td><%= usuario.getEmail() %></td>
			    <td></td>
			</tr>
			<tr>
			    <td>Tema</td>
			    <%if (usuario.getTema()){
			    %>
			    	<td>Oscuro</td>
			    	<td><input id="confirmarTemaClaro" onclick="javascript:document.datos.opcion.value='validar_tema';document.datos.submit();" value="Cambiar Tema a Claro"></td>
			    <% 
			    } else {
			    %>
			    <td>Claro</td>
			    <td><input id="confirmarTemaOscuro" onclick="javascript:document.datos.opcion.value='validar_tema';document.datos.submit();" value="Cambiar Tema a Oscuro"></td>
			    <%
			    }
			    %>
			    
			</tr>
			<tr>
			    <td>Contraseña</td>
			    <td><%= usuario.getContrasenia() %></td>
			    <td></td>
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
</div>
<a href="perfilUsuario.jsp">Volver atras</a>
	<script>
	/*Comprueba que todos los campos esten rellenados, cuando todos esten completos
		comprobara que ambas contraseñas sean iguales,
		entonces habilitara el boton "Confirmar"
		*/
		function validarUsuario(){
			var nombreUsuario = document.getElementById("nombreUsuario").value;
			var btnRegistrarme=document.getElementById("confirmarUsuario");
			
			if (nombreUsuario === "") {
				btnRegistrarme.disabled = true;                	
            } else {
                btnRegistrarme.disabled = false;
            }
		}
	</script>
	</form>
</body>
</html>
