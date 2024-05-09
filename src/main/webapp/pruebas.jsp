<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
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
		<%
			LocalDate fechaMinima = java.time.LocalDate.now().minusYears(18);
		%>
		<label for="fecha">Fecha anterior a hoy:</label>
        <!-- Campo de entrada de tipo 'date' con atributo 'max' -->
        <input type="date" id="fecha" name="fecha" max="<%= fechaMinima %>">
        <br><br>
		

	</form>
</body>
</html>

