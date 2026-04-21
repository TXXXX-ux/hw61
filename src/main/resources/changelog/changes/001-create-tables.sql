CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       name VARCHAR(255) NOT NULL,
                       account_type VARCHAR(50) NOT NULL,
                       avatar VARCHAR(255),
                       about TEXT
);

CREATE TABLE vacancies (
                           id BIGSERIAL PRIMARY KEY,
                           title VARCHAR(255) NOT NULL,
                           description TEXT,
                           salary DOUBLE PRECISION,
                           published_date DATE,
                           responses_count INT DEFAULT 0
);

CREATE TABLE resumes (
                         id BIGSERIAL PRIMARY KEY,
                         title VARCHAR(255) NOT NULL,
                         description TEXT
);