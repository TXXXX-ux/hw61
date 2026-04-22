package kg.attractor.lesson55lab.model;

import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String email;
    private String password;
    private String name;
    private String about;

    @Enumerated(EnumType.STRING)
    private AccountType accountType;

    private String avatar;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name = "user_authority",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "authority_id")
    )
    private List<Authority> authorities;

    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL)
    private List<Vacancy> vacancies;

    @OneToMany(mappedBy = "author", cascade = CascadeType.ALL)
    private List<Resume> resumes;
}