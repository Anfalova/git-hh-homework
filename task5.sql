SELECT
    vacancy.vacancy_id,
    vacancy_title
FROM vacancy
INNER JOIN response on vacancy.vacancy_id = response.vacancy_id
AND response.response_time <= vacancy.publication_time + 7 * INTERVAL '1 day'
GROUP BY vacancy.vacancy_id
HAVING count(vacancy.vacancy_id) > 5;