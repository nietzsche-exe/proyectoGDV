package util;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controlador.LoginController;

/**
 * Clase encargada de validar/verficar la existencia de un correo electronico introducido por el usuario durante su registro
 * mediante la creacion de un token de verificacion
 */
public class EmailValidator {
	private static final Logger LOGGER = LoggerFactory.getLogger(EmailValidator.class);
	
    /**
     * Metodo encargado de enviar un correo al correo introducido por el usuario
     * @param destinatario	String Correo introducido por el usuario
     * @param token	String Token de verificacion
     */
	public static void enviarCorreo(String destinatario, String token) {
        final String remitente = "me.llamo.jjulian@gmail.com"; // Cambia esto por tu dirección de correo electrónico
        final String clave = "dvol ntwn qixu dxwn"; // Cambia esto por tu contraseña de correo electrónico

        // Configuración de propiedades para la sesión de correo
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Cambia esto si usas otro servidor de correo
        props.put("mail.smtp.port", "587");

        // Crear una sesión de correo con autenticación
        Session session = Session.getInstance(props,
           new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                 return new PasswordAuthentication(remitente, clave);
              }
           });
        
        try {
            // Crear un objeto de mensaje
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(remitente));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Confirmación de registro");

            // Construir el cuerpo del correo electrónico con el enlace de confirmación
            String cuerpo = "¡Gracias por registrarte en nuestra aplicación!";
            cuerpo += "Este es su codigo de autetificacion: \n" + token;
            mensaje.setText(cuerpo);

            // Enviar el mensaje
            Transport.send(mensaje);

            System.out.println("¡Correo enviado exitosamente!");
         } catch (MessagingException e) {
            throw new RuntimeException("Error al enviar el correo electrónico: " + e);
         }
     }
    
	/**
	 * Metodo encargado de enviar un correo de verificacion al nuevo correo electronico introducido por el usuario
	 * @param destinatario String nuevo correo electronico del usuario
	 * @param token String Token de verificacion
	 */
    public static void cambio_correo(String destinatario, String token) {
    	final String remitente = "me.llamo.jjulian@gmail.com"; // Cambia esto por tu dirección de correo electrónico
        final String clave = "dvol ntwn qixu dxwn"; // Cambia esto por tu contraseña de correo electrónico

        // Configuración de propiedades para la sesión de correo
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Cambia esto si usas otro servidor de correo
        props.put("mail.smtp.port", "587");

        // Crear una sesión de correo con autenticación
        Session session = Session.getInstance(props,
           new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                 return new PasswordAuthentication(remitente, clave);
              }
           });
        
        try {
            // Crear un objeto de mensaje
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(remitente));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Confirmación de registro");

            // Construir el cuerpo del correo electrónico con el enlace de confirmación
            String cuerpo = "Gracias por cambiarte de correo en nuestra web. ";
            cuerpo += "Este es su codigo de autetificacion: \n" + token;
            mensaje.setText(cuerpo);

            // Enviar el mensaje
            Transport.send(mensaje);

            System.out.println("¡Correo enviado exitosamente!");
         } catch (MessagingException e) {
            throw new RuntimeException("Error al enviar el correo electrónico: " + e);
         }
	}
    
    /**
     * Metodo encargado de enviar un correo electronico de verificacion al correo electronico del usuario
     * al querer cambiarse este de contraseña
     * @param destinatario	String correo electronico del usuario
     * @param token	String Token de verificacion
     */
    public static void cambio_password(String destinatario, String token) {
    	final String remitente = "me.llamo.jjulian@gmail.com"; // Cambia esto por tu dirección de correo electrónico
        final String clave = "dvol ntwn qixu dxwn"; // Cambia esto por tu contraseña de correo electrónico

        // Configuración de propiedades para la sesión de correo
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Cambia esto si usas otro servidor de correo
        props.put("mail.smtp.port", "587");

        // Crear una sesión de correo con autenticación
        Session session = Session.getInstance(props,
           new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                 return new PasswordAuthentication(remitente, clave);
              }
           });
        
        try {
            // Crear un objeto de mensaje
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(remitente));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Confirmación de registro");

            // Construir el cuerpo del correo electrónico con el enlace de confirmación
            String cuerpo = "Confirma que te quieres cambiar de contraseña. ";
            cuerpo += "Este es su codigo de autetificacion: \n" + token;
            mensaje.setText(cuerpo);

            // Enviar el mensaje
            Transport.send(mensaje);

            System.out.println("¡Correo enviado exitosamente!");
         } catch (MessagingException e) {
            throw new RuntimeException("Error al enviar el correo electrónico: " + e);
         }
	}
}