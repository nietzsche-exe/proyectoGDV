package util;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controlador.LoginController;

public class EmailValidator {
	private static final Logger LOGGER = LoggerFactory.getLogger(EmailValidator.class);
	static ConfigLoader configLoader = new ConfigLoader();
    public static void enviarCorreo(String destinatario, String token) {
        final String remitente = configLoader.getProperty("util.email"); 
        final String clave = configLoader.getProperty("util.emailKey"); 

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
           new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                 return new PasswordAuthentication(remitente, clave);
              }
           });
        
        try {

            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(remitente));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Confirmación de registro");

            String cuerpo = "¡Gracias por registrarte en nuestra aplicación!";
            cuerpo += "Este es su codigo de autetificacion: \n" + token;
            mensaje.setText(cuerpo);

            Transport.send(mensaje);

            System.out.println("¡Correo enviado exitosamente!");
         } catch (MessagingException e) {
            throw new RuntimeException("Error al enviar el correo electrónico: " + e);
         }
     }
    
    public static void cambio_correo(String destinatario, String token) {
    	final String remitente = configLoader.getProperty("util.email");
        final String clave = configLoader.getProperty("util.emailKey"); 
  
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587");

   
        Session session = Session.getInstance(props,
           new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                 return new PasswordAuthentication(remitente, clave);
              }
           });
        
        try {
        
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(remitente));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Confirmación de registro");

          
            String cuerpo = "Gracias por cambiarte de correo en nuestra web. ";
            cuerpo += "Este es su codigo de autetificacion: \n" + token;
            mensaje.setText(cuerpo);

       
            Transport.send(mensaje);

            System.out.println("¡Correo enviado exitosamente!");
         } catch (MessagingException e) {
            throw new RuntimeException("Error al enviar el correo electrónico: " + e);
         }
	}
    
    public static void cambio_password(String destinatario, String token) {
    	final String remitente = configLoader.getProperty("util.email"); 
        final String clave = configLoader.getProperty("util.emailKey"); 

      
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); 
        props.put("mail.smtp.port", "587");

       
        Session session = Session.getInstance(props,
           new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                 return new PasswordAuthentication(remitente, clave);
              }
           });
        
        try {
          
            Message mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(remitente));
            mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            mensaje.setSubject("Confirmación de registro");

        
            String cuerpo = "Confirma que te quieres cambiar de contraseña. ";
            cuerpo += "Este es su codigo de autetificacion: \n" + token;
            mensaje.setText(cuerpo);

            Transport.send(mensaje);

            System.out.println("¡Correo enviado exitosamente!");
         } catch (MessagingException e) {
            throw new RuntimeException("Error al enviar el correo electrónico: " + e);
         }
	}
}