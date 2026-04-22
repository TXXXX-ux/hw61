package kg.attractor.lesson55lab.model;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "messages")
@Data @NoArgsConstructor @AllArgsConstructor
public class Message {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String content;
    private LocalDateTime timestamp = LocalDateTime.now();

    @ManyToOne @JoinColumn(name = "response_id")
    private VacancyResponse vacancyResponse;

    @ManyToOne @JoinColumn(name = "author_id")
    private User author;
}