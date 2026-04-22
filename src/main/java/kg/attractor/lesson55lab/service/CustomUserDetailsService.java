package kg.attractor.lesson55lab.service;

import kg.attractor.lesson55lab.dao.UserDao;
import kg.attractor.lesson55lab.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserDao userDao;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userDao.findAll().stream()
                .filter(u -> u.getEmail().equalsIgnoreCase(email))
                .findFirst()
                .orElseThrow(() -> new UsernameNotFoundException("Пользователь не найден: " + email));

        List<SimpleGrantedAuthority> grantedAuthorities = new java.util.ArrayList<>();

        if (user.getAuthorities() != null && !user.getAuthorities().isEmpty()) {
            grantedAuthorities = user.getAuthorities().stream()
                    .map(authority -> new SimpleGrantedAuthority(authority.getRole()))
                    .collect(Collectors.toList());
        } else {
            grantedAuthorities.add(new SimpleGrantedAuthority("ROLE_" + user.getAccountType().name()));
        }

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .authorities(grantedAuthorities)
                .build();
    }
}