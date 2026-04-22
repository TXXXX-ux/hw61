package kg.attractor.lesson55lab.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "vacancy_responses")
@Data @NoArgsConstructor @AllArgsConstructor
public class VacancyResponse {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDateTime responseDate = LocalDateTime.now();

    @ManyToOne @JoinColumn(name = "resume_id")
    private Resume resume;

    @ManyToOne @JoinColumn(name = "vacancy_id")
    private Vacancy vacancy;
}