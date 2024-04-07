<%@page import="modelo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@page import="jakarta.persistence.EntityManager" %>
<%@page import="jakarta.persistence.Query" %>
<%@page import="java.util.List" %>
    
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager" %>
<%@page import="jakarta.persistence.EntityManagerFactory" %>
<%@page import="jakarta.persistence.Persistence" %>

<jsp:useBean id="actor" scope="request" class="modelo.Usuario"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<script>
        function validarCampos() {
            var correoUsuario = document.getElementById("correoUsuario").value;
            var contraseniaUsuario = document.getElementById("contrasenia").value;
            var btnIniciarSesion = document.getElementById("acceder");

            if (correoUsuario === "" || contraseniaUsuario === "") {
                btnIniciarSesion.disabled = true;
            } else {
                btnIniciarSesion.disabled = false;
            }
        }
    </script>
</head>
<body>
<h2>Iniciar Sesión</h2>
	<c:if test="${not empty error}">
	    <p style="color: red;">${error}</p>
	</c:if>
	
    <form name="login" action="LoginController" method="post" onsubmit="return validarCampos()">

    	<input type="hidden" name="opcion" value="iniciarSesion">
    	
        <label for="correoUsuario">Correo electronico:</label><br>
        <input type="text" id="correoUsuario" name="correoUsuario" oninput="validarCampos()"><br>
        <label for="contrasenia">Contraseña:</label><br>
        <input type="password" id="contrasenia" name="contrasenia" oninput="validarCampos()"><br><br>
        
        <input id="acceder" type="submit" value="Iniciar Sesión" disabled>
        <a href="javascript:void(0)" onclick="javascript:document.login.opcion.value='registrarse';document.login.submit();">Registrarse</a>
    	
    </form>
    <form>
    <table>
    	<tr>
    		<th colspan="3">Lista Usuarios</th>
    	</tr>
 			<%! @SuppressWarnings("unchecked") %>
 			<%
 			EntityManager em = modelo.HibernateUtils.getEmf().createEntityManager();
			//LOGGER.info("EntityManager creado");
			try{
				Query consulta = em.createQuery("FROM Usuario");
				List<modelo.Usuario> usuarios = consulta.getResultList();
				//LOGGER.info("Consulta SELECT de Actores realizada");
					
				if (usuarios.isEmpty()){
					%>
					<tr> <td colspan="3"> No existen usuarios </td></tr>
					<%

				}
				else{
					for(modelo.Usuario usuario: usuarios){
			%>
						<tr> 
							<td> <%= usuario.getId_usuario() %></td>
							<td> <%= usuario.getNombre() %></td>
							<td> <%= usuario.getContrasenia() %></td>
							<td> <%= usuario.getEmail() %></td>
						</tr>
						<%
					}
					//LOGGER.info("Se han mostrado los actores");
				}
					
				}
				catch (Exception e){
					//LOGGER.error("Error:"+e.getMessage());
				}
				finally{
					em.close();
					//LOGGER.info("EntityManager cerrado");
				}
			%> 		
    		
    </table>
    </form>
</body>
</html>