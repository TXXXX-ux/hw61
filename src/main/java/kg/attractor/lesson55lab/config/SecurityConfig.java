package kg.attractor.lesson55lab.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        // 1. Статика и авторизация - доступны всем
                        .requestMatchers("/", "/auth/**", "/login", "/register").permitAll()

                        // 2. Вакансии: просмотр всем, создание/правка/удаление - только работодателю
                        .requestMatchers(HttpMethod.GET, "/vacancies", "/vacancies/{id}").permitAll()
                        .requestMatchers("/vacancies/create", "/vacancies/*/edit", "/vacancies/*/delete").hasAuthority("ROLE_EMPLOYER")

                        // 3. Резюме: список видит работодатель, само резюме - все, CRUD - соискатель
                        .requestMatchers(HttpMethod.GET, "/resumes").hasAuthority("ROLE_EMPLOYER")
                        .requestMatchers(HttpMethod.GET, "/resumes/{id}").permitAll()
                        .requestMatchers("/resumes/create", "/resumes/*/edit", "/resumes/*/delete").hasAuthority("ROLE_APPLICANT")

                        // 4. Всё остальное только для авторизованных
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/auth/login")
                        .loginProcessingUrl("/login")
                        .usernameParameter("email")
                        .passwordParameter("password")
                        // ИСПРАВЛЕНО: Теперь перекидывает по правильному адресу!
                        .defaultSuccessUrl("/auth/profile", true)
                        .failureUrl("/auth/login?error=true")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/auth/login?logout")
                        .permitAll());

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}