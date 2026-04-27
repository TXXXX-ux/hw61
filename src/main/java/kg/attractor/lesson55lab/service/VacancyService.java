package kg.attractor.lesson55lab.service;

import kg.attractor.lesson55lab.dao.UserDao;
import kg.attractor.lesson55lab.dao.VacancyDao;
import kg.attractor.lesson55lab.dto.VacancyCreateDto;
import kg.attractor.lesson55lab.dto.VacancyDto;
import kg.attractor.lesson55lab.model.Vacancy;
import kg.attractor.lesson55lab.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class VacancyService {

    private final VacancyDao vacancyDao;
    private final UserDao userDao;

    public Page<VacancyDto> getVacancies(int page, String sortType) {
        Sort sort = Sort.by("publishedDate").descending();
        if ("responses".equals(sortType)) {
            sort = Sort.by("responsesCount").descending();
        }
        Pageable pageable = PageRequest.of(page, 9, sort);
        return vacancyDao.findAll(pageable).map(this::convertToDto);
    }

    public VacancyDto getVacancyById(Long id) {
        Vacancy vacancy = vacancyDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Вакансия не найдена"));
        return convertToDto(vacancy);
    }

    @Transactional
    public void createVacancy(VacancyCreateDto dto, String email) { // Исправлен тип DTO и добавлен email
        User author = userDao.findByEmail(email); // Находим автора по email

        Vacancy vacancy = new Vacancy();
        vacancy.setTitle(dto.getTitle());
        vacancy.setDescription(dto.getDescription());
        vacancy.setSalary(dto.getSalary());
        vacancy.setPublishedDate(java.time.LocalDate.now());
        vacancy.setResponsesCount(0);
        vacancy.setAuthor(author); // КРИТИЧЕСКИ ВАЖНО: Привязываем автора!

        vacancyDao.save(vacancy);
    }

    public VacancyCreateDto getVacancyForEdit(Long id) {
        Vacancy vacancy = vacancyDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Вакансия не найдена"));
        VacancyCreateDto dto = new VacancyCreateDto();
        dto.setTitle(vacancy.getTitle());
        dto.setDescription(vacancy.getDescription());
        dto.setSalary(vacancy.getSalary());
        return dto;
    }

    @Transactional
    public void updateVacancy(Long id, VacancyCreateDto dto) {
        Vacancy vacancy = vacancyDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Вакансия не найдена"));

        // Обновляем поля из DTO
        vacancy.setTitle(dto.getTitle());
        vacancy.setDescription(dto.getDescription());
        vacancy.setSalary(dto.getSalary());

        // В Spring Data JPA при @Transactional вызывать save() не обязательно,
        // но для наглядности оставим
        vacancyDao.save(vacancy);
    }

    @Transactional
    public void deleteVacancy(Long id) {
        vacancyDao.deleteById(id);
    }

    public Page<VacancyDto> getVacanciesByAuthor(User author, int page) {
        Pageable pageable = PageRequest.of(page, 5);
        return vacancyDao.findByAuthor(author, pageable).map(this::convertToDto);
    }

    private VacancyDto convertToDto(Vacancy vacancy) {
        return VacancyDto.builder()
                .id(vacancy.getId())
                .title(vacancy.getTitle())
                .description(vacancy.getDescription())
                .salary(vacancy.getSalary())
                .publishedDate(vacancy.getPublishedDate())
                .responsesCount(vacancy.getResponsesCount())
                .authorName(vacancy.getAuthor() != null ? vacancy.getAuthor().getName() : "Неизвестно")
                .categoryName(vacancy.getCategory() != null ? vacancy.getCategory().getName() : "Без категории")
                .build();
    }
}