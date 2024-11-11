package until;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class SendEmail {

    /**
     * Sends an email to the specified recipient with the given title and
     * content.
     *
     * @param sentTo The email address of the recipient.
     * @param title The title of the email.
     * @param content The content of the email, which can be HTML formatted.
     */
    public static void sendMail(String sentTo, String title, String content) {
        // Email account credentials
        final String username = "hungtche176766@fpt.edu.vn";
        final String password = "pwxp frxk pfrv jkbj";
        // Set up email server properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        // Authenticate and establish session with email server
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        try {
            // Create a new email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // Set sender
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(sentTo)); // Set recipient
            message.setSubject(title); // Set email subject
            // Set content as HTML
            message.setContent(content, "text/html");
            // Send the email
            Transport.send(message);
            System.out.println("Email sent successfully!");
        } catch (MessagingException e) {
            // Print error message if sending fails
            System.out.println("Error at :" + e.getMessage());
        }
    }
    public static void main(String[] args) {
        SendEmail.sendMail("toantthe172722@fpt.edu.vn", "Your verification code",
                "<div>" +
                        "<p style=\"font-size:14px;\">Your confirmation code:</p>" +
                        "<h1 style=\"background-color:#e6f7ff;padding:16px 0;font-size:40px;line-height:140%;text-align:center;letter-spacing:0.04em\">9308</h1>" +
                        "<p style=\"font-size:14px;\">If you received this email by mistake, just ignore it.</p>" +
                        "</div>");
    }

}
