package kg.attractor.lesson55lab.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "contact_info")
@Data @NoArgsConstructor @AllArgsConstructor
public class ContactInfo {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String contactValue;

    @ManyToOne @JoinColumn(name = "contact_type_id")
    private ContactType contactType;

    @ManyToOne @JoinColumn(name = "resume_id")
    private Resume resume;
}