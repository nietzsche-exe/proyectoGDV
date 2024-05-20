<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="jakarta.persistence.Query"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Viaje"%>
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.Hotel"%>
<%@page import="modelo.HibernateUtils"%>

<%@page import="jakarta.persistence.EntityManager"%>
<%@page import="jakarta.persistence.EntityTransaction"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>

<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Transaction"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Perfil de Usuario</title>
<%
// Obtiene la sesión actual
HttpSession a = request.getSession();
// Obtiene los datos del usuario almacenados en la sesión

Usuario usuario = (Usuario) a.getAttribute("usuario");

EntityManager em = HibernateUtils.getEmf().createEntityManager();
Query query = em.createQuery("SELECT u.tema FROM Usuario u WHERE u.id = :id");
query.setParameter("id", usuario.getId_usuario());

Boolean tema = (Boolean) query.getSingleResult();

usuario.setTema(tema);

if(usuario.getTema() == false) {
%>
    <link rel="stylesheet" href="Styles/Perfil_Usuario/cssPerfilUsuario_Claro.css">
<%
} else {
%>  
    <link rel="stylesheet" href="Styles/Perfil_Usuario/cssPerfilUsuario_Oscuro.css">
<%
}
%>
<%
Query queryViajes=em.createQuery("SELECT v FROM Viaje v "
				        + "JOIN FETCH v.habitacion h "
				        + "JOIN FETCH h.hotel "
				        + "WHERE v.usuario.id_usuario = :idUsuario");
queryViajes.setParameter("idUsuario", usuario.getId_usuario());
List<Viaje> listaViajes=queryViajes.getResultList();


%>
</head>
<body>
	<form name="tema" action="LoginController" method="POST">
		<input type="hidden" name="opcion" value="cambiar_tema">
		
		<header class="Encabezado">
			<div class="Contenedor_Logo">
				<img id="logo" alt="Logo" src="Resources/logo_2.0.jpeg">
			</div>
			
			<div class="Contenedor_Botones">
				<input type="hidden" name="sesionUsuario" value="<%= usuario%>">
				<button id="btnCreacionViaje" onclick="javascript:document.tema.opcion.value='NuevoViaje';document.tema.submit();" class="Botones">Creación de viaje</button>
			    <button id="btnEliminacionViaje" class="Botones">Eliminación de Viaje</button>
			</div>
			
			<div id="menu-container">
				<img src="Resources/perfil.png" alt="Menú" id="menu-icon">
				    <ul id="menu">
						<li id="nada">&nbsp;</li>
			            <li id="usuario"><%= usuario.getNombre() %></li>
			            <li id="correo"><%= usuario.getEmail() %></li>
			            <li>&nbsp;</li>
			            <li class="Botones_Despliegue"><a href="index.jsp"><img id="imgSalir" src="Resources/salir.png"> &nbsp; &nbsp; Cerrar Sesion</a></li>
			            <li class="Botones_Despliegue"><a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='config';document.tema.submit();"><img id="imgConfig" src="Resources/configuracion.png"> &nbsp; &nbsp; Configuracion</a></li>
	<%          
				        if(usuario.getTema() == false) {
	%>			
				            <li id="btnCambiarTema" class="Botones_Despliegue"><a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='cambiar_tema';document.tema.submit();"><img id="imgConfig" src="Resources/oscuro.png"> &nbsp; &nbsp; Cambiar tema a oscuro</a></li>
							
	<%
				        } else {
	%>  
				            <li id="btnCambiarTema" class="Botones_Despliegue"><a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='cambiar_tema';document.tema.submit();"><img id="imgConfig" src="Resources/claro.png"> &nbsp; &nbsp; Cambiar tema a claro</a></li>
				            
	<%
				        }
	%>
				            
					</ul>
			</div>
			
		</header>
	<%for (Viaje viaje : listaViajes) {
	    Habitacion habitacion = viaje.getHabitacion();
	    Hotel hotel = habitacion.getHotel();
	%>
	
	<table>
	
		<thead>Viaje</thead>
		<tr>
			<td>Codigo Viaje</td>
			<td>Nombre Hotel</td>
			<td>Precio</td>
			<td>Noche</td>
			<td>Fecha Entrada</td>
			<td>Fecha Salida</td>
			<td>NºCamas</td>
		</tr>
		<tr>
			<td><%=viaje.getId_viaje() %></td>
			<td><%=hotel.getNombre_hotel() %></td>
			<td><%=habitacion.getPrecio_total() %></td>
			<td><%=habitacion.getPrecio_noche() %></td>
			<td><%=habitacion.getFecha_entrada() %></td>
			<td><%=habitacion.getFecha_salida() %></td>
			<td><%=habitacion.getNumero_camas()%></td>
		</tr>
	</table>
	
	<%
	    System.out.println("Viaje ID: " + viaje.getId_viaje());
	    System.out.println("Habitacion ID: " + habitacion.getId_habitacion());
	    System.out.println("Hotel Nombre: " + hotel.getNombre_hotel());
	} %>
    <script src="JavaScript/script.js"></script>

    </form>
</body>
</html>
