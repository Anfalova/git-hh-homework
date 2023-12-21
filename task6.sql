-- Создание индекса по специализациям и наименованиям в резюме
-- Работодатель может искать возможных сотрудников по данным параметрам, указывая специализацию и уточненяя
-- наименование должности
CREATE INDEX resume_title_and_specialization_index ON resume (resume_title, specialization_id);
-- Создание индекса по наименованию, региону и зарплате в вакансиях
-- На мой взгляд, наиболее частно осуществляется поиск именно по такой связке параметров, поэтому разумно было бы
-- сделать по ней индекс
CREATE INDEX vacancy_title_and_region_and_compensation_from_index ON vacancy (vacancy_title, region_id, compensation_from);
