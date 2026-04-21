package kg.attractor.lesson55lab.service;

import kg.attractor.lesson55lab.dao.UserDao;
import kg.attractor.lesson55lab.dto.UserProfileDto;
import kg.attractor.lesson55lab.dto.UserRegistrationDto;
import kg.attractor.lesson55lab.model.AccountType;
import kg.attractor.lesson55lab.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserDao userDao;

    public void register(UserRegistrationDto dto) {
        User user = User.builder()
                .email(dto.getEmail())
                .password(dto.getPassword())
                .accountType(AccountType.valueOf(dto.getAccountType()))
                .name("Новый пользователь")
                .build();
        userDao.save(user);
    }

    public User getUserByEmail(String email) {
        return userDao.findAll().stream()
                .filter(u -> u.getEmail().equals(email))
                .findFirst()
                .orElse(null);
    }

    public void updateProfile(String email, UserProfileDto dto, MultipartFile photo) {
        User user = getUserByEmail(email);
        if (user != null) {
            user.setName(dto.getName());
            user.setAbout(dto.getAbout());

            if (!photo.isEmpty()) {
                String contentType = photo.getContentType();

                boolean isValidFormat = contentType != null && (
                        contentType.equals("image/jpeg") ||
                                contentType.equals("image/png") ||
                                contentType.equals("image/gif")
                );

                if (!isValidFormat) {
                    throw new RuntimeException("Неподдерживаемый формат файла! Разрешены только JPG, PNG и GIF.");
                }

                String fileName = System.currentTimeMillis() + "_" + photo.getOriginalFilename();
                Path path = Paths.get("src/main/resources/static/images/" + fileName);

                try {
                    Files.createDirectories(path.getParent());
                    Files.copy(photo.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                    user.setAvatar(fileName);
                } catch (IOException e) {
                    throw new RuntimeException("Ошибка при сохранении файла на сервере.");
                }
            }
            userDao.save(user);
        }
    }
}