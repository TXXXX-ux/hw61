package kg.attractor.lesson55lab.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "work_experience")
@Data @NoArgsConstructor @AllArgsConstructor
public class WorkExperience {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String company;
    private String position;
    private String responsibilities;
    private String startDate;
    private String endDate;

    @ManyToOne @JoinColumn(name = "resume_id")
    private Resume resume;
}