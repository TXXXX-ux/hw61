package kg.attractor.lesson55lab.dao;

import kg.attractor.lesson55lab.model.User;
import kg.attractor.lesson55lab.model.AccountType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserDao extends JpaRepository<User, Long> {
    User findByEmail(String email);

    Page<User> findByAccountType(AccountType accountType, Pageable pageable);
    Optional<User> findByResetPasswordToken(String token);
}