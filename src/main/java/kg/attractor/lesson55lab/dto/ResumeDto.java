package kg.attractor.lesson55lab.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ResumeDto {
    private Long id;
    private String title;
    private String description;
    private String authorName;
    private String categoryName;
}