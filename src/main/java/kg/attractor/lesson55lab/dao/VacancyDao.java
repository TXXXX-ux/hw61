package kg.attractor.lesson55lab.dao;

import kg.attractor.lesson55lab.model.User;
import kg.attractor.lesson55lab.model.Vacancy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VacancyDao extends JpaRepository<Vacancy, Long> {
    Page<Vacancy> findByAuthor(User author, Pageable pageable);
}