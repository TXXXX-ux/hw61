CREATE TABLE users (
                       id BIGSERIAL PRIMARY KEY,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       name VARCHAR(255) NOT NULL,
                       account_type VARCHAR(50) NOT NULL,
                       avatar VARCHAR(255),
                       about TEXT
);

CREATE TABLE authorities (
                             id BIGSERIAL PRIMARY KEY,
                             role VARCHAR(255) NOT NULL
);

CREATE TABLE user_authority (
                                user_id BIGINT REFERENCES users(id),
                                authority_id BIGINT REFERENCES authorities(id),
                                PRIMARY KEY (user_id, authority_id)
);

CREATE TABLE categories (
                            id BIGSERIAL PRIMARY KEY,
                            name VARCHAR(255) NOT NULL
);

CREATE TABLE contact_types (
                               id BIGSERIAL PRIMARY KEY,
                               type_name VARCHAR(255) NOT NULL
);

CREATE TABLE vacancies (
                           id BIGSERIAL PRIMARY KEY,
                           title VARCHAR(255) NOT NULL,
                           description TEXT,
                           salary DOUBLE PRECISION,
                           published_date DATE,
                           responses_count INT DEFAULT 0,
                           user_id BIGINT REFERENCES users(id),
                           category_id BIGINT REFERENCES categories(id)
);

CREATE TABLE resumes (
                         id BIGSERIAL PRIMARY KEY,
                         title VARCHAR(255) NOT NULL,
                         description TEXT,
                         user_id BIGINT REFERENCES users(id),
                         category_id BIGINT REFERENCES categories(id)
);

CREATE TABLE contact_info (
                              id BIGSERIAL PRIMARY KEY,
                              contact_value VARCHAR(255) NOT NULL,
                              contact_type_id BIGINT REFERENCES contact_types(id),
                              resume_id BIGINT REFERENCES resumes(id) ON DELETE CASCADE
);

CREATE TABLE education (
                           id BIGSERIAL PRIMARY KEY,
                           institution VARCHAR(255) NOT NULL,
                           degree VARCHAR(255),
                           start_date VARCHAR(50),
                           end_date VARCHAR(50),
                           resume_id BIGINT REFERENCES resumes(id) ON DELETE CASCADE
);

CREATE TABLE work_experience (
                                 id BIGSERIAL PRIMARY KEY,
                                 company VARCHAR(255) NOT NULL,
                                 position VARCHAR(255) NOT NULL,
                                 responsibilities TEXT,
                                 start_date VARCHAR(50),
                                 end_date VARCHAR(50),
                                 resume_id BIGINT REFERENCES resumes(id) ON DELETE CASCADE
);

CREATE TABLE vacancy_responses (
                                   id BIGSERIAL PRIMARY KEY,
                                   response_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                   resume_id BIGINT REFERENCES resumes(id) ON DELETE CASCADE,
                                   vacancy_id BIGINT REFERENCES vacancies(id) ON DELETE CASCADE
);

CREATE TABLE messages (
                          id BIGSERIAL PRIMARY KEY,
                          content TEXT NOT NULL,
                          timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          response_id BIGINT REFERENCES vacancy_responses(id) ON DELETE CASCADE,
                          author_id BIGINT REFERENCES users(id)
);