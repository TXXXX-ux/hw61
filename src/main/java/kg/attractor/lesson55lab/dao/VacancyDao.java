package kg.attractor.lesson55lab.dao;

import kg.attractor.lesson55lab.model.Vacancy;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VacancyDao extends JpaRepository<Vacancy, Long> {
}