package kg.attractor.lesson55lab.handler;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalControllerAdvice {

    // Перехватываем ошибку 403 (Нет прав доступа) от Spring Security
    @ExceptionHandler(AccessDeniedException.class)
    public String handleAccessDeniedException(AccessDeniedException ex, Model model, HttpServletRequest request) {

        // Передаем данные, которые ждет твой шаблон error.ftlh
        model.addAttribute("status", "403");
        model.addAttribute("reason", "Доступ запрещен! У вас нет прав для просмотра этой страницы.");

        // Передаем URL, на который пытался зайти юзер
        Map<String, String> details = new HashMap<>();
        details.put("requestURL", request.getRequestURL().toString());
        model.addAttribute("details", details);

        return "error"; // Вызываем твою фирменную страницу
    }

    @ExceptionHandler(Exception.class)
    public String handleGlobalException(Exception ex, Model model) {
        model.addAttribute("error", "Произошла непредвиденная ошибка: " + ex.getMessage());
        return "error"; // Должен существовать шаблон error.ftlh
    }
}