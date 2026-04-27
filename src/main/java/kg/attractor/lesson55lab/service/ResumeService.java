package kg.attractor.lesson55lab.service;

import kg.attractor.lesson55lab.dao.ResumeDao;
import kg.attractor.lesson55lab.dao.UserDao; // Добавь этот импорт
import kg.attractor.lesson55lab.dto.ResumeCreateDto;
import kg.attractor.lesson55lab.dto.ResumeDto;
import kg.attractor.lesson55lab.model.Resume;
import kg.attractor.lesson55lab.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ResumeService {

    private final ResumeDao resumeDao;
    private final UserDao userDao; // Внедряем UserDao

    // Исправленный метод создания с привязкой автора
    @Transactional
    public void createResume(ResumeCreateDto dto, String email) {
        User author = userDao.findByEmail(email);
        Resume resume = new Resume();
        resume.setTitle(dto.getTitle());
        resume.setDescription(dto.getDescription());
        resume.setAuthor(author); // ОБЯЗАТЕЛЬНО: Привязываем тебя как автора!
        resumeDao.save(resume);
    }

    public Page<ResumeDto> getResumes(int page) {
        Pageable pageable = PageRequest.of(page, 5);
        return resumeDao.findAll(pageable).map(this::convertToDto);
    }

    public ResumeDto getResumeById(Long id) {
        Resume resume = resumeDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Резюме не найдено"));
        return convertToDto(resume);
    }

    public ResumeCreateDto getResumeForEdit(Long id) {
        Resume resume = resumeDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Резюме не найдено"));
        ResumeCreateDto dto = new ResumeCreateDto();
        dto.setTitle(resume.getTitle());
        dto.setDescription(resume.getDescription());
        return dto;
    }

    @Transactional
    public void updateResume(Long id, ResumeCreateDto dto) {
        Resume resume = resumeDao.findById(id)
                .orElseThrow(() -> new RuntimeException("Резюме не найдено"));
        resume.setTitle(dto.getTitle());
        resume.setDescription(dto.getDescription());
        resumeDao.save(resume);
    }

    @Transactional
    public void deleteResume(Long id) {
        resumeDao.deleteById(id);
    }

    public Page<ResumeDto> getResumesByAuthor(User author, int page) {
        Pageable pageable = PageRequest.of(page, 5);
        return resumeDao.findByAuthor(author, pageable).map(this::convertToDto);
    }

    private ResumeDto convertToDto(Resume resume) {
        return ResumeDto.builder()
                .id(resume.getId())
                .title(resume.getTitle())
                .description(resume.getDescription())
                .authorName(resume.getAuthor() != null ? resume.getAuthor().getName() : "Неизвестно")
                .build();
    }
}