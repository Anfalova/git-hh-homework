WITH month_and_year_with_max_vacancies_count AS
(
  SELECT
    date_part('month', publication_time) AS month,
    date_part('year', publication_time) AS year
  FROM vacancy
  GROUP BY date_part('month', publication_time), date_part('year', publication_time)
  ORDER BY count(*) DESC
  LIMIT 1
), month_and_year_with_max_resume_count AS
(
  SELECT
    date_part('month', publication_time) AS month,
    date_part('year', publication_time) AS year
  FROM resume
  GROUP BY date_part('month', publication_time), date_part('year', publication_time)
  ORDER BY count(*) DESC
  LIMIT 1
)
SELECT month_and_year_with_max_vacancies_count.month as month_with_max_vacancies_count,
       month_and_year_with_max_resume_count.month as month_with_max_resume_count
FROM month_and_year_with_max_vacancies_count, month_and_year_with_max_resume_count;
