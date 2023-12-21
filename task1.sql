CREATE TABLE region(
    region_id   serial PRIMARY KEY,
    region_name varchar NOT NULL
);

CREATE TABLE specialization(
    specialization_id   serial PRIMARY KEY,
    specialization_name varchar NOT NULL
);

CREATE TABLE applicant(
    applicant_id    serial PRIMARY KEY,
    applicant_name  varchar NOT NULL
);

CREATE TABLE resume
(
  resume_id         serial PRIMARY KEY,
  resume_title      text      NOT NULL,
  region_id         integer  NOT NULL REFERENCES region (region_id),
  applicant_id      integer   NOT NULL REFERENCES applicant (applicant_id),
  compensation_from integer,
  compensation_to   integer,
  specialization_id integer   NOT NULL REFERENCES specialization (specialization_id),
  publication_time  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employer(
    employer_id     serial PRIMARY KEY,
    employer_name   varchar NOT NULL,
    region_id       integer NOT NULL REFERENCES region (region_id)
);

CREATE TABLE vacancy(
    vacancy_id        serial PRIMARY KEY,
    vacancy_title     varchar NOT NULL,
    description       text,
    employer_id       integer  NOT NULL REFERENCES employer (employer_id),
    region_id         integer  NOT NULL REFERENCES region (region_id),
    compensation_from integer,
    compensation_to   integer,
    specialization_id integer   NOT NULL REFERENCES specialization (specialization_id),
    publication_time  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE response(
    vacancy_id  integer  NOT NULL REFERENCES vacancy (vacancy_id),
    resume_id   integer  NOT NULL REFERENCES resume (resume_id),
    PRIMARY KEY (resume_id, vacancy_id),
    response_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);
