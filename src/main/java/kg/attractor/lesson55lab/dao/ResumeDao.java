package kg.attractor.lesson55lab.dao;

import kg.attractor.lesson55lab.model.Resume;
import kg.attractor.lesson55lab.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResumeDao extends JpaRepository<Resume, Long> {
    Page<Resume> findByAuthor(User author, Pageable pageable);
}
