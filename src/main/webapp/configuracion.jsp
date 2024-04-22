<%@page import="jakarta.persistence.Query"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Página Configuracion</title>
<style type="Styles/cssConfiguracion_Claro.css"></style>

</head>
<body>
  



<p>Esta es la pagina de configuracion</p>


<%
// Obtiene la sesión actual
HttpSession a = request.getSession();
// Obtiene los datos del usuario almacenados en la sesión

Usuario usuario = (Usuario) a.getAttribute("usuario");

EntityManager em = HibernateUtils.getEmf().createEntityManager();

boolean principal = true, datPer = false, seguridad = false, privacidad = false;

if(usuario != null) {
%>
	<p>Bienvenido, <%= usuario.getNombre() %> </p>
<%
} else {
	%><p>Bienvenido</p><%
}
%>


<ul>
	<li><a href="configuracion.jsp?principal=true">Informacion Principal</a></li>
	<li><a href="configuracion.jsp?datPer=true">Datos personales</a></li>
	<li><a href="configuracion.jsp?seguridad=true">Seguridad</a></li>
	<li><a href="configuracion.jsp?privacidad=true">Privacidad</a></li>
</ul>

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
    
    if (datPer == true){
%>
		<p>Mostrar Datos Personales</p>
		
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

<%-- <%
	if (datPer == false){
%>
	<p> datPer FALSO</p>
<%	
	} else{
%>
		<p> datPer VERDADERO</p>
<%		
	}
%>

<%
	if (seguridad == false){
%>
	<p> seguridad FALSO</p>
<%	
	} else{
%>
		<p> seguridad VERDADERO</p>
<%		
	}
%>

<%
	if (privacidad == false){
%>
	<p> privacidad FALSO</p>
<%	
	} else{
%>
		<p> privacidad VERDADERO</p>
<%		
	}
%> --%>

</body>
</html>
