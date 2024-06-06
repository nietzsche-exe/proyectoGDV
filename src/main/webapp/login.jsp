<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="org.w3c.dom.Document"%>
<%@page import="modelo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@page import="jakarta.persistence.EntityManager" %>
<%@page import="jakarta.persistence.Query" %>
<%@page import="java.util.List" %>

<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
    
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager" %>
<%@page import="jakarta.persistence.EntityManagerFactory" %>
<%@page import="jakarta.persistence.Persistence" %>

<jsp:useBean id="actor" scope="request" class="modelo.Usuario"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inicio-Sesion</title>
<link rel="icon" type="image/jpeg" href="Resources/logo_03.png">
<link rel="stylesheet" href="Styles/Inicio_Sesion/cssInicioSesion.css">
</head>
<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada login");
%>
	<div class="Contenedor_InicoSesion">
		<div id="Contenedor_Cabecero">
			<img id="imgPerfil" alt="Imagen Perfil" src="Resources/inicioSesion_01.jpeg">
			<h1>Iniciar Sesión</h1>
		</div>
		
		
		<div id="Contenedor_Cuerpo">
			<c:if test="${not empty error}">
			    <p id="Texto_Error" style="color: red;">${error}</p>
			</c:if>
			
		    <form name="login" action="LoginController" method="post">
		    	
		    	<input type="hidden" name="opcion" value="iniciarSesion">
		    	
		        <label for="correoUsuario">Correo electrónico:</label><br>
		        <input class="Boton_Escribir" type="text" id="correoUsuario" name="correoUsuario"><br><br>
		        <label for="contrasenia">Contraseña:</label><br>
		        <input class="Boton_Escribir" type="password" id="contrasenia" name="contrasenia"><br><br>
		        
		        <input class="Botones" id="acceder" type="submit" value="Iniciar Sesión">
		        <a class="Botones" href="javascript:void(0)" onclick="javascript:document.login.opcion.value='registrarse';document.login.submit();">Registrarse</a>
		    	<a class="Botones" href="javascript:void(0)" onclick="javascript:document.login.opcion.value='default';document.login.submit();">Volver</a>
		    </form>
		</div>
		
	</div>
	
</body>
</html>