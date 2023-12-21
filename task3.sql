SELECT
    region_id AS region,
    avg(compensation_from) AS  average_compensation_from,
    avg(compensation_to) AS  average_compensation_to,
    avg((compensation_from + compensation_to) / 2) AS  average_compensation
FROM vacancy
GROUP BY region_id;
