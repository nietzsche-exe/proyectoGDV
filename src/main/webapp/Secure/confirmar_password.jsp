<%@page import="controlador.LoginController"%>
<%@page import="util.EmailValidator"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="modelo.Usuario"%>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <jsp:useBean id="usuario" scope="request" class="modelo.Usuario"/>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Verificar correo</title>
<link rel="icon" type="image/jpeg" href="../Resources/logo_03.png">
<link rel="stylesheet" href="../Styles/Confirmar_Correo/cssConfirmar_Correo_Claro.css">
<link rel="stylesheet" href="Styles/Confirmar_Correo/cssConfirmar_Correo.css">

</head>
<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada confirmar_password");
%>
	<header id="Cabecero">
		<form id="form_cabecero" action="LoginController?opcion=config" method="post">
			<input id="Cancelar" type="submit" value="cancelar">
		</form>
	</header>
	<div class="Contenedor_Todo">
		<div class="Contenedor_Error">
			<c:if test="${not empty error}">
			    <p id="Texto_Error" style="color: red;">${error}</p>
			</c:if>
		</div>
		
		<div class="Contenedor_Verificacion">
		
			<form name="register" action="LoginController" method="post">
			
				<input type="hidden" name="opcion" value="verificar_password">
			
				<label id="Texto_Encavecado">Codigo de verificación</label>
				<label>Se ha enviado un codigo de verificación a tu correo</label>
				<input id="cod_verificacion" name="cod_verificacion" type="text">
				
				<button id="btnVerificar" type="submit" >Verificar Contraseña</button>
			</form>
			
		</div>
	</div>

</body>
</html>