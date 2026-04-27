package kg.attractor.lesson55lab.dto;

import lombok.Builder;
import lombok.Data;
import java.time.LocalDate;

@Data
@Builder
public class VacancyDto {
    private Long id;
    private String title;
    private String description;
    private Double salary;
    private LocalDate publishedDate;
    private Integer responsesCount;
    private String authorName;
    private String authorEmail;
    private String categoryName;
}