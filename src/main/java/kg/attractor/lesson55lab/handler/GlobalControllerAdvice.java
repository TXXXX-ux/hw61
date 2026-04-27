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

    @ExceptionHandler(AccessDeniedException.class)
    public String handleAccessDeniedException(AccessDeniedException ex, Model model, HttpServletRequest request) {

        model.addAttribute("status", "403");
        model.addAttribute("reason", "Доступ запрещен! У вас нет прав для просмотра этой страницы.");

        Map<String, String> details = new HashMap<>();
        details.put("requestURL", request.getRequestURL().toString());
        model.addAttribute("details", details);

        return "error";
    }

    @ExceptionHandler(Exception.class)
    public String handleGlobalException(Exception ex, Model model) {
        model.addAttribute("error", "Произошла непредвиденная ошибка: " + ex.getMessage());
        return "error";
    }
}