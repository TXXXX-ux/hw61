package kg.attractor.lesson55lab.controller;

import jakarta.validation.Valid;
import kg.attractor.lesson55lab.dto.ResumeCreateDto;
import kg.attractor.lesson55lab.service.ResumeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller
@RequestMapping("/resumes")
@RequiredArgsConstructor
public class ResumeController {

    private final ResumeService resumeService;

    @GetMapping
    public String resumesPage(@RequestParam(defaultValue = "0") int page, Model model) {
        model.addAttribute("resumesPage", resumeService.getResumes(page));
        return "resumes";
    }

    @GetMapping("/{id}")
    public String resumeInfo(@PathVariable Long id, Model model) {
        model.addAttribute("resume", resumeService.getResumeById(id));
        return "resume_info";
    }

    @GetMapping("/create")
    public String createResumePage(Model model) {
        model.addAttribute("resumeDto", new ResumeCreateDto());
        return "create_resume";
    }

    @PostMapping("/create")
    public String saveResume(@Valid @ModelAttribute("resumeDto") ResumeCreateDto dto,
                             BindingResult bindingResult,
                             Principal principal) { // Добавляем Principal
        if (bindingResult.hasErrors()) {
            return "create_resume";
        }
        // Передаем email текущего пользователя
        resumeService.createResume(dto, principal.getName());

        // ИСПРАВЛЕНО: Редирект в профиль, чтобы не поймать 403 ошибку
        return "redirect:/auth/profile";
    }

    @PostMapping("/{id}/edit")
    public String updateResume(@PathVariable Long id,
                               @Valid @ModelAttribute("resumeDto") ResumeCreateDto dto,
                               BindingResult bindingResult,
                               Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("resumeId", id);
            return "edit_resume";
        }
        resumeService.updateResume(id, dto);
        return "redirect:/resumes/" + id;
    }



    @GetMapping("/{id}/edit")
    public String editResumePage(@PathVariable Long id, Model model) {
        model.addAttribute("resumeDto", resumeService.getResumeForEdit(id));
        model.addAttribute("resumeId", id);
        return "edit_resume";
    }

    @PostMapping("/{id}/delete")
    public String deleteResume(@PathVariable Long id) {
        resumeService.deleteResume(id);
        // ИСПРАВЛЕНИЕ 2: После удаления тоже кидаем в профиль
        return "redirect:/auth/profile";
    }
}