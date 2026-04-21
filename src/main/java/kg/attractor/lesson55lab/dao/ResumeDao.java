package kg.attractor.lesson55lab.dao;

import kg.attractor.lesson55lab.model.Resume;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResumeDao extends JpaRepository<Resume, Long> {
}
