<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Página Principal</title>
<link rel="stylesheet" href="Styles/Pagina_Principal/cssQuienSomos.css">
</head>
<body>
<%
	boolean principal = true, inicio_registro = false, destino = false, reserva = false, itinerarios = false, opiniones = false, soporte = false;
%>	

	<header class="Encabezado">
		<div class="Contenedor_Logo">
			<img id="logo" alt="Logo" src="Resources/logo.png">
		</div>
		<div class="Contenedor_Botones">
	    	<button id="btnIniciarSesion" class="Botones"><b>Iniciar Sesión</b></button>
	    	<button id="btnRegistro" class="Botones"><b>Registrarse</b></button>
		</div>
		<div class="biblioteca">
			<a href="quienSomos.jsp?principal=true" class="Enlaces"><b>Informacion Principal</b></a>
			<a href="quienSomos.jsp?inicio_registro=true" class="Enlaces"><b>Inicio/Registro</b></a>
			<a href="quienSomos.jsp?destino=true" class="Enlaces"><b>Destinos</b></a>
			<a href="quienSomos.jsp?reserva=true" class="Enlaces"><b>Reservas</b></a>
			<a href="quienSomos.jsp?itinerarios=true" class="Enlaces"><b>Itinerarios</b></a>
			<a href="quienSomos.jsp?opiniones=true" class="Enlaces"><b>Opiniones</b></a>
			<a href="quienSomos.jsp?soporte=true" class="Enlaces"><b>Soporte</b></a>
		</div>
	</header>
    
    <%
    String principalParam = request.getParameter("principal");
    String ini_reg_Param = request.getParameter("inicio_registro");
    String dastinoParam = request.getParameter("destino");
    String reservaParam = request.getParameter("reserva");
    String itinerariosParam = request.getParameter("itinerarios");
    String opinionesParam = request.getParameter("opiniones");
    String soporteParam = request.getParameter("soporte");

    if (principalParam != null && principalParam.equals("true")) {
    	principal = true;
    	inicio_registro = false;
    	destino = false;
    	reserva = false;
    	itinerarios = false;
    	opiniones = false;
    	soporte = false;
    }
    if (ini_reg_Param != null && ini_reg_Param.equals("true")) {
    	principal = false;
    	inicio_registro = true;
    	destino = false;
    	reserva = false;
    	itinerarios = false;
    	opiniones = false;
    	soporte = false;
    }
    if (dastinoParam != null && dastinoParam.equals("true")) {
    	principal = false;
    	inicio_registro = false;
    	destino = true;
    	reserva = false;
    	itinerarios = false;
    	opiniones = false;
    	soporte = false;
    }
    if (reservaParam != null && reservaParam.equals("true")) {
    	principal = false;
    	inicio_registro = false;
    	destino = false;
    	reserva = true;
    	itinerarios = false;
    	opiniones = false;
    	soporte = false;
    }
    if (itinerariosParam != null && itinerariosParam.equals("true")) {
    	principal = false;
    	inicio_registro = false;
    	destino = false;
    	reserva = false;
    	itinerarios = true;
    	opiniones = false;
    	soporte = false;
    }
    if (opinionesParam != null && opinionesParam.equals("true")) {
    	principal = false;
    	inicio_registro = false;
    	destino = false;
    	reserva = false;
    	itinerarios = false;
    	opiniones = true;
    	soporte = false;
    }
    if (soporteParam != null && soporteParam.equals("true")) {
    	principal = false;
    	inicio_registro = false;
    	destino = false;
    	reserva = false;
    	itinerarios = false;
    	opiniones = false;
    	soporte = true;
    }

	if (inicio_registro) {
    
%>
		<div id="Contenedor_Texto1" class="Contenedor_Texto">
			<h2 class="titulo" >Inicio de Sesión y Registro</h2>
			<p>
				Nuestro sistema de inicio de sesión y registro proporciona a los usuarios una plataforma segura y personalizada para acceder a todas las funciones disponibles en nuestro sitio. Al crear una cuenta personal, los usuarios pueden disfrutar de una experiencia completa y adaptada a sus necesidades individuales.
			</p>
			<p>	
				El proceso de inicio de sesión no solo garantiza la seguridad de la información del usuario, sino que también facilita la gestión de reservas y viajes anteriores. Al iniciar sesión, los usuarios tienen acceso instantáneo a su historial de reservas, itinerarios pasados y preferencias de viaje. Esto les permite realizar fácilmente cambios, cancelaciones o nuevas reservas sin tener que volver a ingresar toda su información cada vez.
			</p>
			<br>
			<p>		
				Además, el registro en nuestro sitio brinda a los usuarios la oportunidad de personalizar su experiencia aún más. Pueden guardar destinos favoritos, establecer notificaciones para ofertas especiales o eventos relevantes, y recibir recomendaciones personalizadas basadas en sus intereses y actividades anteriores.
			</p>
			<br>
			<p>		
				En resumen, nuestro sistema de inicio de sesión y registro no solo garantiza la seguridad de la información del usuario, sino que también mejora significativamente su experiencia general en nuestro sitio, ofreciendo comodidad, personalización y acceso rápido a todas las funciones disponibles.
			</p>
		</div>
	
<%
    }
    else if (destino == true){
    
%>
		<div id="Contenedor_Texto2" class="Contenedor_Texto">
			<h2 class="titulo">Búsqueda de Destinos y Ofertas</h2>
			<p>	
				En nuestro sitio, nos enorgullece ofrecer una amplia gama de destinos y paquetes turísticos diseñados para satisfacer las preferencias de todos los viajeros, desde aquellos que buscan aventuras emocionantes hasta quienes prefieren escapadas relajantes. Con una selección diversa y cuidadosamente curada, garantizamos que cada usuario encuentre la experiencia de viaje perfecta que se ajuste a sus deseos y necesidades individuales.
			</p>
			<br>
			<p>	
				Los usuarios tienen la libertad de explorar nuestro extenso catálogo de destinos, desde los icónicos puntos de interés hasta los rincones menos conocidos pero igualmente fascinantes del mundo. Ya sea que estén buscando un destino específico o estén abiertos a nuevas aventuras, nuestra plataforma les ofrece herramientas intuitivas para encontrar la escapada perfecta.
			</p>
			<p>		
				Además de la variedad de destinos, también proporcionamos una amplia gama de paquetes turísticos y ofertas especiales que permiten a los usuarios aprovechar al máximo su experiencia de viaje al obtener descuentos exclusivos y beneficios adicionales. Desde paquetes todo incluido hasta ofertas de última hora, nuestro objetivo es brindar a nuestros usuarios opciones flexibles y atractivas que se adapten a su presupuesto y preferencias.
			</p>
			<br>
			<p>		
				Nuestra plataforma también facilita la comparación de precios de vuelos, alojamientos y actividades, lo que permite a los usuarios tomar decisiones informadas y obtener el mejor valor por su dinero. Con herramientas de búsqueda avanzadas y filtros personalizados, pueden encontrar las mejores ofertas y planificar su viaje de manera eficiente y sin complicaciones.
			</p>
			<br>
			<p>		
				En resumen, en nuestro sitio, nos esforzamos por ofrecer a nuestros usuarios una experiencia de viaje completa y sin preocupaciones, desde la planificación hasta la ejecución. Con una amplia selección de destinos, paquetes turísticos y herramientas de comparación de precios, estamos aquí para hacer que cada viaje sea inolvidable y satisfacer las necesidades de todos los viajeros.
			</p>
		</div>
	
<%
    }
    else if (reserva == true){
    
%>
		<div id="Contenedor_Texto3" class="Contenedor_Texto">
			<h2 class="titulo">Reservas y Pagos</h2>
			<p>
				En nuestra plataforma, ofrecemos a los usuarios la conveniencia de reservar una amplia gama de servicios relacionados con sus viajes, todo en un solo lugar. Desde vuelos hasta alojamientos, alquiler de vehículos y actividades turísticas, nuestra plataforma integra todas estas opciones para facilitar la planificación y reserva de viajes de manera eficiente y sin problemas.
			</p>
			<br>
			<p>		
				Al ofrecer una variedad de servicios de viaje, nuestra plataforma permite a los usuarios personalizar completamente su experiencia de viaje de acuerdo con sus preferencias y necesidades individuales. Ya sea que estén buscando vuelos económicos, alojamientos de lujo, vehículos de alquiler cómodos o emocionantes actividades turísticas, nuestros usuarios pueden encontrar y reservar todo lo que necesitan con solo unos pocos clics.
			</p>
			<br>
			<p>		
				Una de nuestras principales prioridades es garantizar la seguridad y la protección de la información financiera de nuestros usuarios. Es por eso que integramos opciones de pago seguro en nuestra plataforma para todas las transacciones. Utilizamos tecnologías de encriptación avanzadas y colaboramos con proveedores de servicios de pago confiables para garantizar que todas las transacciones se realicen de manera segura y sin problemas. De esta manera, nuestros usuarios pueden tener la tranquilidad de saber que su información financiera está protegida en todo momento.
			</p>
			<p>		
				Además de ofrecer opciones de pago seguro, también nos esforzamos por brindar un proceso de reserva intuitivo y sin complicaciones. Nuestra plataforma está diseñada para ser fácil de usar, con interfaces claras y navegación sencilla que permiten a los usuarios completar sus reservas rápidamente y sin estrés.
			</p>
			<br>
			<p>		
				En resumen, nuestra plataforma no solo ofrece una amplia gama de servicios de viaje para satisfacer todas las necesidades de nuestros usuarios, sino que también se compromete a garantizar la seguridad y la protección de su información financiera durante todo el proceso de reserva. Con opciones de pago seguro y una experiencia de reserva intuitiva, estamos aquí para hacer que la planificación y reserva de viajes sean lo más convenientes y sin problemas posible para nuestros usuarios.			
			</p>
		</div>
<%
    }
    else if (itinerarios == true){
    
%>
		<div id="Contenedor_Texto4" class="Contenedor_Texto">
		<h2 class="titulo">Gestión de Itinerarios</h2>
			<p>
				Nuestra plataforma ofrece a los usuarios una serie de herramientas poderosas para organizar y gestionar sus itinerarios de viaje de manera eficiente, desde la etapa inicial de planificación hasta la confirmación de reservas y más allá. Nos esforzamos por brindar una experiencia integral que simplifique todo el proceso de viaje y garantice una experiencia sin problemas desde el principio hasta el final.
			</p>
			<p>	
				Desde el momento en que los usuarios comienzan a planificar su viaje, nuestra plataforma les ofrece herramientas intuitivas para explorar destinos, comparar opciones y tomar decisiones informadas. Con funciones de búsqueda avanzadas y filtros personalizables, pueden encontrar fácilmente vuelos, alojamientos, actividades y más que se adapten a sus preferencias y presupuesto.
			</p>
			<br>
			<p>		
				Una vez que los usuarios han seleccionado sus opciones de viaje preferidas, nuestra plataforma facilita la reserva y la confirmación de todas las reservas necesarias. Con unos pocos clics, los usuarios pueden asegurar vuelos, reservar alojamientos, alquilar vehículos y reservar actividades turísticas, todo desde la comodidad de nuestra plataforma en línea. Además, ofrecemos la opción de recibir confirmaciones de reserva por correo electrónico para que los usuarios tengan una referencia fácil de sus planes de viaje.
			</p>
			<br>
			<p>		
				Pero nuestra dedicación a una experiencia de viaje sin problemas no termina con la confirmación de las reservas. Nuestra plataforma también ofrece herramientas para que los usuarios gestionen sus itinerarios de viaje de manera efectiva antes y durante su viaje. Pueden realizar cambios en sus reservas, agregar nuevas actividades, acceder a información útil sobre sus destinos y más, todo desde una ubicación centralizada y fácil de usar.
			</p>
			<br>
			<p>		
				En resumen, nuestra plataforma está diseñada para proporcionar a los usuarios todas las herramientas y recursos que necesitan para organizar y gestionar sus itinerarios de viaje de manera eficiente y sin problemas. Desde la planificación inicial hasta la confirmación de reservas y la gestión de itinerarios, estamos aquí para garantizar que cada paso del viaje sea lo más fácil y conveniente posible para nuestros usuarios.
			</p>
		</div>
<%
    }
    else if (opiniones == true){
    
%>	
		<div id="Contenedor_Texto5" class="Contenedor_Texto">
			<h2 class="titulo">Interacción Social y Opiniones</h2>
			<p>
				En nuestro sitio, valoramos enormemente la interacción entre los usuarios y fomentamos una comunidad activa de viajeros que comparten sus experiencias, recomendaciones y opiniones. Creemos que cada viaje es único y que al compartir nuestras vivencias, podemos enriquecer la experiencia de viaje de otros y ayudarles a tomar decisiones informadas.
			</p>
			<br>
			<p>		
				Para facilitar esta interacción, ofrecemos a los usuarios la capacidad de compartir sus experiencias de viaje, recomendar destinos y dar opiniones sobre los servicios que han utilizado. Ya sea una reseña detallada sobre un hotel, una recomendación sobre una actividad turística imperdible o simplemente un consejo útil para otros viajeros, animamos a nuestros usuarios a contribuir con su conocimiento y experiencias.
			</p>
			<br>
			<p>		
				Las reseñas y calificaciones son una parte integral de nuestra plataforma y desempeñan un papel crucial en ayudar a otros viajeros a tomar decisiones informadas. Al leer las experiencias y opiniones de otros usuarios, los viajeros pueden obtener una visión más completa de lo que pueden esperar de un destino, un alojamiento o una actividad turística específica. Esto les permite tomar decisiones que se ajusten mejor a sus necesidades y preferencias individuales.
			</p>
			<p>		
				Además de ayudar a otros viajeros, las reseñas y calificaciones también nos brindan información valiosa que utilizamos para mejorar continuamente la calidad de nuestros servicios. Tomamos en serio los comentarios de nuestros usuarios y los utilizamos para identificar áreas de mejora, corregir problemas y adaptar nuestras ofertas para satisfacer mejor las necesidades de nuestra comunidad de viajeros.
			</p>
			<br>
			<p>		
				En resumen, en nuestro sitio, creemos en la importancia de la comunidad y en el poder de compartir experiencias. Al permitir a los usuarios compartir sus experiencias de viaje, recomendar destinos y dar opiniones sobre servicios, creamos una comunidad vibrante de viajeros que se apoyan mutuamente, comparten conocimientos y enriquecen la experiencia de viaje de todos.
			</p>
		</div>
<%
    }
    else if (soporte == true){
    
%>
		<div id="Contenedor_Texto6" class="Contenedor_Texto">
			<h2 class="titulo">Soporte al Cliente</h2>
			<p>
				En nuestro compromiso de proporcionar una experiencia de viaje excepcional, contamos con un equipo de atención al cliente altamente capacitado y disponible en todo momento para ayudar a los usuarios en cada etapa de su viaje. Entendemos que cada viajero puede enfrentarse a preguntas, consultas o incluso imprevistos durante el proceso de planificación y ejecución de su viaje, y estamos aquí para ofrecer asistencia experta y apoyo en cualquier momento que sea necesario.
			</p>
			<br>
			<p>		
				Nuestro equipo de atención al cliente está preparado para abordar una amplia gama de consultas, desde preguntas generales sobre destinos y servicios hasta asistencia con reservas específicas y solución de problemas técnicos. Ya sea que un usuario necesite ayuda para encontrar el alojamiento perfecto, asesoramiento sobre actividades locales, o resolver un problema con su reserva, nuestro equipo está listo para brindar orientación personalizada y soluciones eficientes.
			</p>
			<br>
			<img id="soporte_02" alt="soporte_02" src="Resources/soporte_02.png"> <img id="soporte_01" alt="soporte_01" src="Resources/soporte_01.png">
			<br>
			<p>		
				Nos enorgullece ofrecer un servicio al cliente excepcional, caracterizado por una respuesta rápida y una resolución efectiva de problemas. Nuestro objetivo es asegurarnos de que cada usuario se sienta apoyado y atendido en todo momento, y hacemos todo lo posible para garantizar una experiencia sin preocupaciones y satisfactoria para todos nuestros clientes.
			</p>
			<p>		
				Además de proporcionar asistencia durante el proceso de reserva y planificación, nuestro equipo de atención al cliente también está disponible para ayudar en caso de cambios de último minuto, emergencias durante el viaje o cualquier otra situación imprevista que pueda surgir. Estamos comprometidos a estar siempre a disposición de nuestros usuarios, brindando tranquilidad y seguridad en cada paso del viaje.
			</p>
			<img id="soporte_03" alt="soporte_03" src="Resources/soporte_03.jpeg">
			<p>		
				En resumen, nuestro equipo de atención al cliente es una parte fundamental de nuestra misión de proporcionar una experiencia de viaje excepcional. Con una atención personalizada, respuesta rápida y soluciones efectivas, estamos aquí para garantizar que cada usuario reciba el apoyo necesario en cada etapa de su viaje y disfrute de una experiencia sin preocupaciones y satisfactoria en todo momento.
			
			</p>
		</div>
<%
    }
	else {
%>
		<div class="Contenedor_Texto">
			<h2 class="titulo">Resumen del Sitio Web de Gestión de Viajes</h2>
			
		    <p>
				Nuestro sitio web de gestión de viajes es una plataforma integral diseñada para facilitar la planificación, reserva y gestión de viajes para usuarios individual o grupos. Con una interfaz intuitiva y diversas funcionalidades, proporcionamos una experiencia completa para satisfacer las necesidades de nuestros usuarios.
			</p>
			<p>
				En resumen, nuestro sitio web de gestión de viajes es una herramienta integral que ofrece una experiencia personalizada y sin complicaciones para planificar, reservar y gestionar viajes de manera eficiente y segura. Con una amplia gama de destinos y servicios, así como un sólido soporte al cliente, estamos comprometidos a hacer que cada viaje sea una experiencia inolvidable para nuestros usuarios.    	
	    	</p>
		</div>
<%
	}
%>
    
	
	
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
