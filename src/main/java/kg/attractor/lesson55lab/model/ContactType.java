package kg.attractor.lesson55lab.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "contact_types")
@Data @NoArgsConstructor @AllArgsConstructor
public class ContactType {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String typeName;
}