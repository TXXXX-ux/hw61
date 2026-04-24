package kg.attractor.lesson55lab.controller;

import kg.attractor.lesson55lab.dao.ResumeDao;
import kg.attractor.lesson55lab.dao.UserDao;
import kg.attractor.lesson55lab.dao.VacancyDao;
import kg.attractor.lesson55lab.model.AccountType;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class JobController {

    private final VacancyDao vacancyDao;
    private final ResumeDao resumeDao;
    private final UserDao userDao;

    @GetMapping("/vacancies")
    public String vacanciesPage(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "date") String sortType,
            Model model) {

        Sort sort = Sort.by("publishedDate").descending();
        if ("responses".equals(sortType)) {
            sort = Sort.by("responsesCount").descending();
        }
        Pageable pageable = PageRequest.of(page, 9, sort);
        model.addAttribute("vacanciesPage", vacancyDao.findAll(pageable));
        model.addAttribute("currentSort", sortType);

        return "vacancies";
    }

    @GetMapping("/resumes")
    public String resumesPage(@RequestParam(defaultValue = "0") int page, Model model) {
        Pageable pageable = PageRequest.of(page, 5);
        model.addAttribute("resumesPage", resumeDao.findAll(pageable));
        return "resumes";
    }

    @GetMapping("/companies")
    public String companiesPage(@RequestParam(defaultValue = "0") int page, Model model) {
        Pageable pageable = PageRequest.of(page, 5);
        model.addAttribute("companiesPage", userDao.findByAccountType(AccountType.EMPLOYER, pageable));
        return "companies";
    }

    @GetMapping("/vacancies/{id}")
    public String vacancyInfo(@PathVariable Long id, Model model) {
        model.addAttribute("vacancy", vacancyDao.findById(id).orElse(null));
        return "vacancy_info";
    }

    @GetMapping("/resumes/{id}")
    public String resumeInfo(@PathVariable Long id, Model model) {
        model.addAttribute("resume", resumeDao.findById(id).orElse(null));
        return "resume_info";
    }

    @GetMapping("/vacancies/create")
    public String createVacancyPage() {
        return "create_vacancy";
    }

    @GetMapping("/resumes/create")
    public String createResumePage() {
        return "create_resume";
    }

    @PostMapping("/vacancies/create")
    public String saveVacancy(kg.attractor.lesson55lab.model.Vacancy vacancy) {
        vacancy.setPublishedDate(java.time.LocalDate.now());
        vacancy.setResponsesCount(0);
        vacancyDao.save(vacancy);
        return "redirect:/vacancies";
    }

    @PostMapping("/resumes/create")
    public String saveResume(kg.attractor.lesson55lab.model.Resume resume) {
        resumeDao.save(resume);
        return "redirect:/resumes";
    }
}