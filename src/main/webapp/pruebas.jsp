<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Desplegar Leyenda</title>
    <style>
        /* Estilo para el contenedor principal */
        .container {
            position: relative;
            height: 100vh; /* Ajustamos la altura del contenedor al 100% de la ventana */
            overflow: hidden; /* Ocultamos el desbordamiento */
        }

        /* Estilo para el contenedor de la leyenda */
        .leyenda-container {
            position: absolute;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            padding-right: 10px; /* Añadimos un poco de espacio entre la imagen y la leyenda */
        }
        
        /* Estilo para el icono que activa la leyenda */
        .icono {
            width: 50px;
            height: 50px;
            cursor: pointer;
        }

        /* Estilo para el contenido de la leyenda */
        .leyenda-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            z-index: 1;
            bottom: calc(100% + 10px); /* Alineamos la parte inferior de la leyenda con la parte superior de la imagen */
            right: 0;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="leyenda-container">
        <!-- Icono del perfil -->
        <img src="perfil_icono.png" alt="Perfil" class="icono" onclick="mostrarLeyenda()">
        <!-- Contenido de la leyenda -->
        <div class="leyenda-content" id="leyenda">
            <p>Configuración</p>
            <p>Cerrar Sesión</p>
            <!-- Puedes añadir más elementos aquí -->
        </div>
    </div>
</div>

<script>
function mostrarLeyenda() {
    var leyenda = document.getElementById("leyenda");
    // Si la leyenda está oculta, la mostramos
    if (leyenda.style.display === "none") {
        leyenda.style.display = "block";
    } else {
        // Si ya está mostrada, la ocultamos
        leyenda.style.display = "none";
    }
}

// Evento de clic en cualquier parte del documento
document.addEventListener("click", function(event) {
    var leyenda = document.getElementById("leyenda");
    var icono = document.querySelector(".icono");
    // Si el clic no fue en la leyenda ni en el icono, ocultamos la leyenda
    if (event.target !== leyenda && event.target !== icono) {
        leyenda.style.display = "none";
    }
});
</script>

</body>
</html>

