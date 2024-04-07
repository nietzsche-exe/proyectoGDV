<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Página Principal</title>
</head>
<body>
    <button id="btnIniciarSesion">Iniciar Sesión</button>
    <button id="btnRegistro">Registrarse</button>

    <script>
        // Función para redirigir al usuario a la página de inicio de sesión
        function redirectToLoginPage() {
            window.location.href = "login.jsp"; 
        }

        // Función para redirigir al usuario a la página de registro
        function redirectToRegistroPage() {
            window.location.href = "registro.jsp"; 
        }

        document.getElementById("btnIniciarSesion").addEventListener("click", redirectToLoginPage);
		
        document.getElementById("btnRegistro").addEventListener("click", redirectToRegistroPage);
    </script>
    <h1>Resumen del Sitio Web de Gestión de Viajes</h1>
    <p>
    
		Nuestro sitio web de gestión de viajes es una plataforma integral diseñada para facilitar la planificación, reserva y gestión de viajes para usuarios individual o grupos. Con una interfaz intuitiva y diversas funcionalidades, proporcionamos una experiencia completa para satisfacer las necesidades de nuestros usuarios. A continuación se presentan los aspectos principales de nuestro sitio web:
	
	</p>
	<p>
		<b>Inicio de Sesión y Registro:</b> Los usuarios pueden crear cuentas personales para acceder a las funciones completas del sitio. El inicio de sesión garantiza la seguridad de la información del usuario y facilita la gestión de reservas y viajes anteriores.
	</p>
	<p>	
		<b>Búsqueda de Destinos y Ofertas:</b> Ofrecemos una amplia gama de destinos y paquetes turísticos para satisfacer las preferencias de todos los viajeros. Los usuarios pueden buscar destinos específicos, explorar ofertas especiales y comparar precios de vuelos, alojamientos y actividades.
	</p>
	<p>
		<b>Reservas y Pagos:</b> Nuestra plataforma permite a los usuarios reservar vuelos, hoteles, alquiler de vehículos y actividades turísticas de manera conveniente. Integramos opciones de pago seguro para garantizar transacciones sin problemas y proteger la información financiera del usuario.
	</p>
	<p>
		<b>Gestión de Itinerarios:</b> Los usuarios pueden organizar y gestionar sus itinerarios de viaje de manera eficiente. Desde la planificación inicial hasta la confirmación de reservas y la recepción de confirmaciones por correo electrónico, proporcionamos herramientas para garantizar una experiencia de viaje sin problemas.
	</p>
	<p>
		<b>Interacción Social y Opiniones:</b> Fomentamos la interacción entre los usuarios al permitirles compartir sus experiencias de viaje, recomendar destinos y dar opiniones sobre servicios. Las reseñas y calificaciones ayudan a otros viajeros a tomar decisiones informadas y a mejorar la calidad de nuestros servicios.
	</p>
	<p>
		<b>Soporte al Cliente:</b> Nuestro equipo de atención al cliente está disponible para ayudar a los usuarios en cualquier etapa del proceso de viaje. Desde consultas generales hasta asistencia con reservas y problemas técnicos, nos esforzamos por brindar un servicio excepcional y resolver cualquier problema de manera rápida y eficiente.
	
	</p>
	<p>
		En resumen, nuestro sitio web de gestión de viajes es una herramienta integral que ofrece una experiencia personalizada y sin complicaciones para planificar, reservar y gestionar viajes de manera eficiente y segura. Con una amplia gama de destinos y servicios, así como un sólido soporte al cliente, estamos comprometidos a hacer que cada viaje sea una experiencia inolvidable para nuestros usuarios.
		    	
    </p>
</body>
</html>
