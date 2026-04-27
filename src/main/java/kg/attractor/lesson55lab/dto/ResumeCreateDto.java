package kg.attractor.lesson55lab.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class ResumeCreateDto {
    @NotBlank(message = "Укажите должность")
    private String title;

    @NotBlank(message = "Расскажите о себе")
    private String description;
}