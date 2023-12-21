INSERT INTO region (region_name)
VALUES ('Москва'),
       ('Санкт-Петербург'),
       ('Владивосток'),
       ('Воронеж'),
       ('Екатеринбург'),
       ('Казань'),
       ('Калуга'),
       ('Краснодар'),
       ('Нижний Новгород'),
       ('Челябинск'),
       ('Самара'),
       ('Омск'),
       ('Ростов-на-Дону'),
       ('Уфа'),
       ('Пермь'),
       ('Ярославль');


INSERT INTO specialization (specialization_name)
VALUES ('Автомобильный бизнес'),
       ('Административный персонал'),
       ('Безопасность'),
       ('Высший менеджмент'),
       ('Добыча сырья'),
       ('Домашний, обслуживающий персонал'),
       ('Закупки'),
       ('Информационные технологии'),
       ('Искусство, развлечения, масс-медиа'),
       ('Маркетинг, реклама, PR'),
       ('Медицина, фармацевтика'),
       ('Наука, образование'),
       ('Продажи, обслуживание клиентов'),
       ('Производство, сервисное обслуживание'),
       ('Рабочий персонал'),
       ('Розничная торговля'),
       ('Сельское хозяйство'),
       ('Спортивные клубы, фитнес, салоны красоты'),
       ('Стратегия, инвестиции, консалтинг'),
       ('Страхование'),
       ('Строительство, недвижимость'),
       ('Транспорт, логистика, перевозки'),
       ('Туризм, гостиницы, рестораны'),
       ('Управление персоналом, тренинги'),
       ('Финансы, бухгалтерия'),
       ('Юристы'),
       ('Другое');


-- Генерирую 1000 работодателей
WITH test_data(id, employer_name, region_id) AS (
  SELECT
    GENERATE_SERIES(1, 1000) AS id,
    MD5(RANDOM()::TEXT)      AS employer_name,
    FLOOR(RANDOM() * 16) + 1 AS region_id
)
INSERT
INTO employer(employer_name,
              region_id)
SELECT
  employer_name,
  region_id
FROM test_data;


-- Генерирую 10000 вакансий
WITH test_data AS (
  SELECT
    GENERATE_SERIES(1, 10000)    AS id,
    MD5(RANDOM()::TEXT)          AS vacancy_title,
    FLOOR(RANDOM() * 1000) + 1   AS employer_id,
    MD5(RANDOM()::TEXT)          AS description,
    FLOOR(RANDOM() * 100000) + 1 AS compensation,
    FLOOR(RANDOM() * 16) + 1     AS region_id,
    FLOOR(RANDOM() * 27) + 1     AS specialization_id
)
INSERT
INTO vacancy(vacancy_title,
             employer_id,
             description,
             compensation_from,
             compensation_to,
             region_id,
             specialization_id,
             publication_time)
SELECT
  vacancy_title,
  employer_id,
  description,
  compensation,
  compensation + (RANDOM() * (10001))::INT,
  region_id,
  specialization_id,
  CURRENT_TIMESTAMP - RANDOM() * 90 * INTERVAL '1 day'
FROM test_data;


-- Генерирую 50 000 соискателей
WITH test_data(id, applicant_name) AS (
  SELECT
    GENERATE_SERIES(1, 50000) AS id,
    MD5(RANDOM()::TEXT)       AS applicant_name
)
INSERT
INTO applicant(applicant_name)
SELECT
  applicant_name
FROM test_data;


-- Генерирую 100 000 резюме
WITH test_data AS (
  SELECT
    GENERATE_SERIES(1, 100000)   AS id,
    MD5(RANDOM()::TEXT)          AS resume_title,
    FLOOR(RANDOM() * 50000) + 1  AS applicant_id,
    FLOOR(RANDOM() * 100000) + 1 AS compensation,
    FLOOR(RANDOM() * 16) + 1     AS region_id,
    FLOOR(RANDOM() * 27) + 1     AS specialization_id
)
INSERT
INTO resume(resume_title,
            applicant_id,
            compensation_from,
            compensation_to,
            region_id,
            specialization_id,
            publication_time)
SELECT
  resume_title,
  applicant_id,
  compensation,
  compensation + (RANDOM() * (10001))::INT,
  region_id,
  specialization_id,
  CURRENT_TIMESTAMP - RANDOM() * 90 * INTERVAL '1 day'
FROM test_data;

-- Заполняю таблицу откликов
WITH test_data AS (
  SELECT
    GENERATE_SERIES(1, 100100) AS id,
    FLOOR(random() * 100000) + 1 AS resume_id,
    FLOOR(random() * 10000) + 1 AS vacancy_id
)
INSERT INTO response(resume_id, vacancy_id, response_time)
SELECT
    test_data.resume_id,
    test_data.vacancy_id,
    greatest(vacancy.publication_time, resume.publication_time) + FLOOR(RANDOM() * 10) * interval '1 day'
FROM test_data
INNER JOIN vacancy ON test_data.vacancy_id = vacancy.vacancy_id
INNER JOIN resume ON test_data.resume_id = resume.resume_id
ON CONFLICT DO NOTHING;
