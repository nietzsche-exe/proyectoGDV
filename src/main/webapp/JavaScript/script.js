// Obtener la referencia de la imagen del menú y el menú desplegable
    var menuIcon = document.getElementById("menu-icon");
    var menu = document.getElementById("menu");

    // Agregar un evento de clic a la imagen del menú
    menuIcon.addEventListener("click", function(event) {
        // Si el menú está oculto, mostrarlo; si no, ocultarlo
        if (menu.style.display === "none") {
            menu.style.display = "block";
        } else {
            menu.style.display = "none";
        }
        // Detener la propagación del clic para evitar que se cierre el menú inmediatamente después de abrirlo
        event.stopPropagation();
    });

    // Agregar un evento de clic al documento entero
    document.addEventListener("click", function(event) {
        // Si el clic no ocurre dentro del menú, ocultar el menú
        if (!menu.contains(event.target) && menu.style.display === "block") {
            menu.style.display = "none";
        }
    });
    
    