package kg.attractor.lesson55lab.controller;

import kg.attractor.lesson55lab.dao.UserDao;
import kg.attractor.lesson55lab.dto.UserRegistrationDto;
import kg.attractor.lesson55lab.model.User;
import kg.attractor.lesson55lab.model.AccountType;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UserDao userDao;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("types", AccountType.values());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(UserRegistrationDto userDto) {
        User user = new User();
        user.setEmail(userDto.getEmail());
        user.setName("Новый пользователь");

        user.setPassword(passwordEncoder.encode(userDto.getPassword()));
        user.setAccountType(AccountType.valueOf(userDto.getAccountType()));

        userDao.save(user);
        return "redirect:/auth/login";
    }

    @GetMapping("/profile")
    public String profilePage(Model model, Principal principal) {
        if (principal == null) {
            return "redirect:/auth/login";
        }
        String email = principal.getName();
        User user = userDao.findByEmail(email);
        model.addAttribute("user", user);
        return "profile";
    }
}