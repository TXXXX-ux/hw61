package kg.attractor.lesson55lab.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "education")
@Data @NoArgsConstructor @AllArgsConstructor
public class Education {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String institution;
    private String degree;
    private String startDate;
    private String endDate;

    @ManyToOne @JoinColumn(name = "resume_id")
    private Resume resume;
}