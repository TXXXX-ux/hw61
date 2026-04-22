INSERT INTO categories (name) VALUES ('IT'), ('Сервис'), ('Транспорт'), ('Дизайн');

INSERT INTO authorities (role) VALUES ('ROLE_EMPLOYER'), ('ROLE_APPLICANT');

INSERT INTO users (email, password, name, account_type, about) VALUES
                                                                   ('boss@mail.com', '$2a$10$EACO4tTIsA8gg6fQHE0joOsVzKIF4/JDrgA4Y6k4RKEyVHdh8iSxC', 'Админ', 'EMPLOYER', 'Лучшая IT компания'),
                                                                   ('worker@mail.com', '$2a$10$EACO4tTIsA8gg6fQHE0joOsVzKIF4/JDrgA4Y6k4RKEyVHdh8iSxC', 'Тестер', 'APPLICANT', 'Ищу работу');

INSERT INTO user_authority (user_id, authority_id) VALUES
                                                       (1, 1), -- boss берет себе 'ROLE_EMPLOYER'
                                                       (2, 2); -- worker берет 'ROLE_APPLICANT'

INSERT INTO vacancies (title, description, salary, published_date, responses_count, user_id, category_id) VALUES
                                                                                                              ('Java Разработчик', 'Нужен джун со знанием Spring Boot', 50000, '2026-04-15', 5, 1, 1),
                                                                                                              ('Frontend Developer', 'Знание React обязательно', 60000, '2026-04-18', 12, 1, 1),
                                                                                                              ('Уборщик в IT', 'Мыть серверную, провода не трогать', 15000, '2026-04-19', 1, 1, 2),
                                                                                                              ('Java Backend (Middle)', 'Разработка микросервисов', 120000, '2026-04-10', 20, 1, 1),
                                                                                                              ('Автомеханик', 'Обслуживание японских авто', 70000, '2026-04-11', 8, 1, 3),
                                                                                                              ('Веломеханик', 'Ремонт MTB, сборка фиксов', 40000, '2026-04-12', 3, 1, 3),
                                                                                                              ('Game Developer (C++)', 'Разработка шутеров', 150000, '2026-04-14', 45, 1, 1),
                                                                                                              ('QA Engineer', 'Ручное тестирование', 45000, '2026-04-16', 30, 1, 1),
                                                                                                              ('Системный администратор', 'Поддержка парка ПК', 55000, '2026-04-17', 4, 1, 1),
                                                                                                              ('DevOps Engineer', 'Настройка пайплайнов, Linux', 180000, '2026-04-01', 15, 1, 1),
                                                                                                              ('Data Analyst', 'SQL, Excel, Отчеты', 80000, '2026-04-05', 22, 1, 1),
                                                                                                              ('Специалист техподдержки', 'Ответы на звонки', 35000, '2026-04-08', 10, 1, 2),
                                                                                                              ('UI/UX Дизайнер', 'Рисовать в Figma', 90000, '2026-04-09', 18, 1, 4),
                                                                                                              ('Project Manager', 'Управление командой', 110000, '2026-04-13', 7, 1, 1),
                                                                                                              ('Android Разработчик', 'Писать на Kotlin', 95000, '2026-04-19', 11, 1, 1);

INSERT INTO resumes (title, description, user_id, category_id) VALUES
                                                                   ('Java Junior', 'Пишу код без багов (почти)', 2, 1),
                                                                   ('React Middle', 'Делаю красивые кнопочки', 2, 1),
                                                                   ('Студент-программист', 'Учусь на заочке', 2, 1),
                                                                   ('Автомеханик-любитель', 'Разбираюсь в машинах', 2, 3),
                                                                   ('Веломастер', 'Перебираю втулки', 2, 3),
                                                                   ('QA Junior', 'Готов кликать по кнопкам', 2, 1),
                                                                   ('Геймер / Тестировщик', 'Знаю все виды багов', 2, 1);