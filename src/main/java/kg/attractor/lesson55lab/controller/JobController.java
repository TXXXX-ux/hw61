package kg.attractor.lesson55lab.controller;

import kg.attractor.lesson55lab.dao.UserDao;
import kg.attractor.lesson55lab.model.AccountType;
import kg.attractor.lesson55lab.model.User;
import kg.attractor.lesson55lab.service.VacancyService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class JobController {

    private final UserDao userDao;
    private final VacancyService vacancyService;

    @GetMapping("/companies")
    public String companiesPage(@RequestParam(defaultValue = "0") int page, Model model) {
        Pageable pageable = PageRequest.of(page, 5);
        model.addAttribute("companiesPage", userDao.findByAccountType(AccountType.EMPLOYER, pageable));
        return "companies";
    }

    @GetMapping("/companies/{id}")
    public String companyInfo(@PathVariable Long id, @RequestParam(defaultValue = "0") int page, Model model) {
        User company = userDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Компания не найдена"));

        model.addAttribute("company", company);
        model.addAttribute("vacanciesPage", vacancyService.getVacanciesByAuthor(company, page));

        return "company_info";
    }
}