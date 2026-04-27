package kg.attractor.lesson55lab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import kg.attractor.lesson55lab.dao.UserDao;
import kg.attractor.lesson55lab.dto.UserRegistrationDto;
import kg.attractor.lesson55lab.model.User;
import kg.attractor.lesson55lab.model.AccountType;
import kg.attractor.lesson55lab.service.ResumeService;
import kg.attractor.lesson55lab.service.VacancyService;
import kg.attractor.lesson55lab.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserDao userDao;
    private final PasswordEncoder passwordEncoder;
    private final UserService userService;
    private final VacancyService vacancyService;
    private final ResumeService resumeService;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("types", AccountType.values());
        model.addAttribute("userDto", new UserRegistrationDto());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@Valid UserRegistrationDto userDto,
                               BindingResult bindingResult,
                               HttpServletRequest request,
                               Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("types", AccountType.values());
            return "register";
        }

        if (userDao.findByEmail(userDto.getEmail()) != null) {
            model.addAttribute("types", AccountType.values());
            model.addAttribute("errorMessage", "Пользователь с таким email уже существует!");
            return "register";
        }

        User user = new User();
        user.setEmail(userDto.getEmail());
        user.setName("Новый пользователь");
        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        user.setAccountType(AccountType.valueOf(userDto.getAccountType()));
        userDao.saveAndFlush(user);

        try {
            request.login(userDto.getEmail(), userDto.getPassword());
        } catch (ServletException e) {
            e.printStackTrace();
            return "redirect:/auth/login";
        }
        return "redirect:/auth/profile";
    }

    @GetMapping("/profile")
    public String profilePage(Model model, Principal principal, @RequestParam(defaultValue = "0") int page) {
        if (principal == null) {
            return "redirect:/auth/login";
        }
        String email = principal.getName();
        User user = userDao.findByEmail(email);
        model.addAttribute("user", user);

        if (user.getAccountType() == AccountType.EMPLOYER) {
            model.addAttribute("vacanciesPage", vacancyService.getVacanciesByAuthor(user, page));
        } else {
            model.addAttribute("resumesPage", resumeService.getResumesByAuthor(user, page));
        }

        return "profile";
    }

    @GetMapping("/forgot_password")
    public String showForgotPasswordForm() {
        return "forgot_password_form";
    }

    @PostMapping("/forgot_password")
    public String processForgotPassword(HttpServletRequest request, Model model) {
        try {
            userService.makeResetPasswdLink(request);
            model.addAttribute("message", "Ссылка для сброса пароля отправлена вам на email!");
        } catch (Exception ex) {
            model.addAttribute("error", ex.getMessage());
        }
        return "forgot_password_form";
    }

    @GetMapping("/reset_password")
    public String showResetPasswordForm(@RequestParam String token, Model model) {
        try {
            userService.getByResetPasswordToken(token);
            model.addAttribute("token", token);
        } catch (Exception ex) {
            model.addAttribute("error", "Недействительный или устаревший токен.");
        }
        return "reset_password_form";
    }

    @PostMapping("/reset_password")
    public String processResetPassword(HttpServletRequest request, Model model) {
        String token = request.getParameter("token");
        String password = request.getParameter("password");
        try {
            User user = userService.getByResetPasswordToken(token);
            userService.updatePassword(user, password);
            model.addAttribute("message", "Вы успешно изменили пароль!");
        } catch (Exception ex) {
            model.addAttribute("error", "Ошибка при смене пароля. Попробуйте еще раз.");
        }
        return "message_page";
    }
}