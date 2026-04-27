package kg.attractor.lesson55lab.controller;

import jakarta.validation.Valid;
import kg.attractor.lesson55lab.dto.VacancyCreateDto;
import kg.attractor.lesson55lab.service.VacancyService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller
@RequestMapping("/vacancies")
@RequiredArgsConstructor
public class VacancyController {

    private final VacancyService vacancyService;

    @GetMapping
    public String vacanciesPage(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "date") String sortType,
            Model model) {
        model.addAttribute("vacanciesPage", vacancyService.getVacancies(page, sortType));
        model.addAttribute("currentSort", sortType);
        return "vacancies";
    }

    @GetMapping("/{id}")
    public String vacancyInfo(@PathVariable Long id, Model model) {
        model.addAttribute("vacancy", vacancyService.getVacancyById(id));
        return "vacancy_info";
    }

    @GetMapping("/create")
    public String createVacancyPage(Model model) {
        model.addAttribute("vacancyDto", new VacancyCreateDto());
        return "create_vacancy";
    }

    @PostMapping("/create")
    public String saveVacancy(@Valid @ModelAttribute("vacancyDto") VacancyCreateDto dto,
                              BindingResult bindingResult,
                              Principal principal) { // Добавлен Principal для получения автора
        if (bindingResult.hasErrors()) {
            return "create_vacancy";
        }

        // Передаем DTO и email текущего пользователя
        vacancyService.createVacancy(dto, principal.getName());

        // После создания вакансии работодателя логичнее вернуть в профиль, чтобы он её увидел
        return "redirect:/auth/profile";
    }

    @GetMapping("/{id}/edit")
    public String editVacancyPage(@PathVariable Long id, Model model) {
        model.addAttribute("vacancyDto", vacancyService.getVacancyForEdit(id));
        model.addAttribute("vacancyId", id);
        return "edit_vacancy";
    }

    @PostMapping("/{id}/edit")
    public String updateVacancy(@PathVariable Long id,
                                @Valid @ModelAttribute("vacancyDto") VacancyCreateDto dto,
                                BindingResult bindingResult,
                                Model model) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("vacancyId", id);
            return "edit_vacancy";
        }
        vacancyService.updateVacancy(id, dto);
        return "redirect:/vacancies/" + id;
    }

    @PostMapping("/{id}/delete")
    public String deleteVacancy(@PathVariable Long id) {
        vacancyService.deleteVacancy(id);
        return "redirect:/vacancies";
    }
}