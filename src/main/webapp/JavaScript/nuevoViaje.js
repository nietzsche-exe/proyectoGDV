/**
 * 
 */

function validateDates() {
        const checkInDate = new Date(document.getElementById("fechaEntrada").value);
        const checkOutDate = new Date(document.getElementById("fechaSalida").value);

        if (checkOutDate < checkInDate) {
            alert("La fecha de salida no puede ser anterior a la fecha de entrada.");
            return false;
        }
        return true;
    }