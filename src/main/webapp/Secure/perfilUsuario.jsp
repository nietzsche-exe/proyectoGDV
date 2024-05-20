<%@page import="jakarta.persistence.Query"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.HibernateUtils"%>
<%@page import="jakarta.persistence.EntityManager"%>
<%@page import="jakarta.persistence.EntityTransaction"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.Transaction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Perfil de Usuario</title>
<%
    // Obtiene la sesión actual
    HttpSession session2 = request.getSession(false);

    // Verifica si la sesión existe y si el usuario está autenticado
    if (session2 == null || session2.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Obtiene los datos del usuario almacenados en la sesión
    Usuario usuario = (Usuario) session2.getAttribute("usuario");

    // Manejo del EntityManager
    EntityManager em = HibernateUtils.getEmf().createEntityManager();
    try {
        Query query = em.createQuery("SELECT u.tema FROM Usuario u WHERE u.id = :id");
        query.setParameter("id", usuario.getId_usuario());

        Boolean tema = (Boolean) query.getSingleResult();
        usuario.setTema(tema);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (em != null) {
            em.close();
        }
    }

    // Establecer el tema según la preferencia del usuario
    if (usuario.getTema() == false) {
%>
    <link rel="stylesheet" href="../Styles/Perfil_Usuario/cssPerfilUsuario_Claro.css">
<%
    } else {
%>
    <link rel="stylesheet" href="../Styles/Perfil_Usuario/cssPerfilUsuario_Oscuro.css">
<%
    }
%>
</head>
<body>
    <form name="tema" action="../LoginController" method="POST">
        <input type="hidden" name="opcion" value="cambiar_tema">
        
        <header class="Encabezado">
            <div class="Contenedor_Logo">
                <img id="logo" alt="Logo" src="../Resources/logo_2.0.jpeg">
            </div>
            
            <div class="Contenedor_Botones">
                <button id="btnCreacionViaje" onclick="javascript:document.tema.opcion.value='NuevoViaje';document.tema.submit();" class="Botones">Creación de viaje</button>
                <button id="btnEliminacionViaje" class="Botones">Eliminación de Viaje</button>
            </div>
            
            <div id="menu-container">
                <img src="../Resources/perfil.png" alt="Menú" id="menu-icon">
                <ul id="menu">
                    <li id="nada">&nbsp;</li>
                    <li id="usuario"><%= usuario.getNombre() %></li>
                    <li id="correo"><%= usuario.getEmail() %></li>
                    <li>&nbsp;</li>
                    <li class="Botones_Despliegue"><a href="../index.jsp"><img id="imgSalir" src="../Resources/salir.png"> &nbsp; &nbsp; Cerrar Sesion</a></li>
                    <li class="Botones_Despliegue"><a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='config';document.tema.submit();"><img id="imgConfig" src="../Resources/configuracion.png"> &nbsp; &nbsp; Configuracion</a></li>
<% 
                        if (usuario.getTema() == false) { 
%>         
                            <li id="btnCambiarTema" class="Botones_Despliegue"><a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='cambiar_tema';document.tema.submit();"><img id="imgConfig" src="../Resources/oscuro.png"> &nbsp; &nbsp; Cambiar tema a oscuro</a></li>
<% 
                        } else { 
%>  
                            <li id="btnCambiarTema" class="Botones_Despliegue"><a href="javascript:void(0)" onclick="javascript:document.tema.opcion.value='cambiar_tema';document.tema.submit();"><img id="imgConfig" src="../Resources/claro.png"> &nbsp; &nbsp; Cambiar tema a claro</a></li>
<% 
                        } 
%>
                </ul>
            </div>
        </header>
    
        <script src="../JavaScript/script.js"></script>
    </form>
</body>
</html>

