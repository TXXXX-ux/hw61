package kg.attractor.lesson55lab.dto;

import jakarta.validation.constraints.*;
import lombok.Data;

@Data
public class VacancyCreateDto {
    @NotBlank(message = "Укажите название должности")
    private String title;

    @NotBlank(message = "Описание не может быть пустым")
    private String description;

    @NotNull(message = "Укажите зарплату")
    @Min(value = 0, message = "Зарплата не может быть меньше 0")
    private Double salary;
}