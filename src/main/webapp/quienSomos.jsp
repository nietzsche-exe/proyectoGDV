<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Página Principal</title>
<link rel="stylesheet" href="Styles/Pagina_Principal/cssQuienSomos.css">
</head>
<body>

	<div class="Encabezado">
		<div class="Contenedor_Logo">
			<img alt="Logo" src="Resources/logo.png">
		</div>
		<div class="Contenedor_Botones">
	    	<button id="btnIniciarSesion" class="Botones">Iniciar Sesión</button>
	    	<button id="btnRegistro" class="Botones">Registrarse</button>
		</div>
		<div class="biblioteca">
			<a href="quienSomos.jsp?principal=true">Informacion Principal</a>
			<a href="quienSomos.jsp?datPer=true">Inicio/Registro</a>
			<a href="quienSomos.jsp?seguridad=true">Destinos</a>
			<a href="quienSomos.jsp?privacidad=true">Reservas</a>
			<a href="quienSomos.jsp?privacidad=true">Itinerarios</a>
		</div>
	</div>
    
    
    
    
	<div class="Contenedor_Titulo">
		<h2 id="titulo1">Resumen del Sitio Web de Gestión de Viajes</h2>
	    <p>
	    
			Nuestro sitio web de gestión de viajes es una plataforma integral diseñada para facilitar la planificación, reserva y gestión de viajes para usuarios individual o grupos. Con una interfaz intuitiva y diversas funcionalidades, proporcionamos una experiencia completa para satisfacer las necesidades de nuestros usuarios. A continuación se presentan los aspectos principales de nuestro sitio web:
		
		</p>
	</div>
	<div id="Contenedor_Texto1" class="Contenedor_Texto">
		<h4>Inicio de Sesión y Registro:</h4>
		<p>
			Los usuarios pueden crear cuentas personales para acceder a las funciones completas del sitio. El inicio de sesión garantiza la seguridad de la información del usuario y facilita la gestión de reservas y viajes anteriores.
		</p>
	</div>
	<div id="Contenedor_Texto2" class="Contenedor_Texto">
	<p>	
		<h4>Búsqueda de Destinos y Ofertas:</h4>
		Ofrecemos una amplia gama de destinos y paquetes turísticos para satisfacer las preferencias de todos los viajeros. Los usuarios pueden buscar destinos específicos, explorar ofertas especiales y comparar precios de vuelos, alojamientos y actividades.
	</p>
	</div>
	<div id="Contenedor_Texto3" class="Contenedor_Texto">
	<p>
		<h4>Reservas y Pagos:</h4>
		Nuestra plataforma permite a los usuarios reservar vuelos, hoteles, alquiler de vehículos y actividades turísticas de manera conveniente. Integramos opciones de pago seguro para garantizar transacciones sin problemas y proteger la información financiera del usuario.
	</p>
	</div>
	<div id="Contenedor_Texto4" class="Contenedor_Texto">
	<p>
		<b>Gestión de Itinerarios:</b> Los usuarios pueden organizar y gestionar sus itinerarios de viaje de manera eficiente. Desde la planificación inicial hasta la confirmación de reservas y la recepción de confirmaciones por correo electrónico, proporcionamos herramientas para garantizar una experiencia de viaje sin problemas.
	</p>
	</div>
	<div id="Contenedor_Texto5" class="Contenedor_Texto">
	<p>
		<b>Interacción Social y Opiniones:</b> Fomentamos la interacción entre los usuarios al permitirles compartir sus experiencias de viaje, recomendar destinos y dar opiniones sobre servicios. Las reseñas y calificaciones ayudan a otros viajeros a tomar decisiones informadas y a mejorar la calidad de nuestros servicios.
	</p>
	</div>
	<div id="Contenedor_Texto6" class="Contenedor_Texto">
	<p>
		<b>Soporte al Cliente:</b> Nuestro equipo de atención al cliente está disponible para ayudar a los usuarios en cualquier etapa del proceso de viaje. Desde consultas generales hasta asistencia con reservas y problemas técnicos, nos esforzamos por brindar un servicio excepcional y resolver cualquier problema de manera rápida y eficiente.
	
	</p>
	</div>
	<div id="Contenedor_Texto7" class="Contenedor_Texto">
	<p>
		En resumen, nuestro sitio web de gestión de viajes es una herramienta integral que ofrece una experiencia personalizada y sin complicaciones para planificar, reservar y gestionar viajes de manera eficiente y segura. Con una amplia gama de destinos y servicios, así como un sólido soporte al cliente, estamos comprometidos a hacer que cada viaje sea una experiencia inolvidable para nuestros usuarios.
		    	
    </p>
    </div>
    
	
	
	<script>
        // Función para redirigir al usuario a la página de inicio de sesión
        function redirectToLoginPage() {
            window.location.href = "login.jsp"; // Cambia "pagina-de-inicio-de-sesion.jsp" por la ruta de tu página de inicio de sesión
        }

        // Función para redirigir al usuario a la página de registro
        function redirectToRegistroPage() {
            window.location.href = "registro.jsp"; // Cambia "pagina-de-registro.jsp" por la ruta de tu página de registro
        }

        // Agregar un event listener al botón de inicio de sesión para que llame a la función redirectToLoginPage cuando se haga clic en él
        document.getElementById("btnIniciarSesion").addEventListener("click", redirectToLoginPage);

        // Agregar un event listener al botón de registro para que llame a la función redirectToRegistroPage cuando se haga clic en él
        document.getElementById("btnRegistro").addEventListener("click", redirectToRegistroPage);
    </script>
</body>
</html>
