package kg.attractor.lesson55lab.handler;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import java.util.NoSuchElementException;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerAdvice {

    @ExceptionHandler(NoSuchElementException.class)
    public String notFound(HttpServletRequest request, Model model) {
        model.addAttribute("status", HttpStatus.NOT_FOUND.value());
        model.addAttribute("reason", HttpStatus.NOT_FOUND.getReasonPhrase());
        model.addAttribute("details", request);
        return "error";
    }

    @ExceptionHandler(Exception.class)
    public String internalServerError(HttpServletRequest request, Model model, Exception ex) {
        model.addAttribute("status", HttpStatus.INTERNAL_SERVER_ERROR.value());
        model.addAttribute("reason", "Internal Server Error");
        model.addAttribute("details", request);
        return "error";
    }
}
