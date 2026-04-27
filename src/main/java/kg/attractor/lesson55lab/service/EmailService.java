package kg.attractor.lesson55lab.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import java.io.UnsupportedEncodingException;

@Service
@RequiredArgsConstructor
public class EmailService {
    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String EMAIL_FROM;

    public void sendEmail(String toEmail, String link) throws MessagingException, UnsupportedEncodingException {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);

        helper.setFrom(EMAIL_FROM, "JobPortal Support");
        helper.setTo(toEmail);
        helper.setSubject("Ссылка для сброса пароля");

        String content = "<p>Здравствуйте!</p>"
                + "<p>Вы запросили сброс пароля для вашего аккаунта.</p>"
                + "<p>Нажмите на ссылку ниже, чтобы изменить пароль:</p>"
                + "<p><a href=\"" + link + "\">Изменить пароль</a></p>"
                + "<br><p>Проигнорируйте это письмо, если вы ничего не запрашивали.</p>";

        helper.setText(content, true);
        mailSender.send(message);
    }
}