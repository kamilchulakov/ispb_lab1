-- 1
SELECT people."ОТЧЕСТВО", sess."УЧГОД"
FROM "Н_ЛЮДИ" people
LEFT JOIN "Н_СЕССИЯ" sess ON sess."ЧЛВК_ИД" = people."ИД"
WHERE people."ИМЯ" = 'Александр' AND sess."УЧГОД" < '2003/2004' AND sess."УЧГОД" > '2001/2002';

-- 2
SELECT people."ИМЯ", ved."ЧЛВК_ИД", sess."ДАТА"
FROM "Н_ЛЮДИ" people
LEFT JOIN "Н_СЕССИЯ" sess ON sess."ЧЛВК_ИД" = people."ИД"
LEFT JOIN "Н_ВЕДОМОСТИ" ved ON sess."ЧЛВК_ИД" = people."ИД"
WHERE ved."ЧЛВК_ИД" = 117219 AND people."ОТЧЕСТВО" > 'Сергеевич';

-- 3
SELECT exists(
    SELECT *
    FROM "Н_УЧЕНИКИ" uch
    JOIN "Н_ЛЮДИ" people ON people."ИД" = uch."ЧЛВК_ИД"
    JOIN "Н_ПЛАНЫ" plan ON uch."ПЛАН_ИД" = plan."ИД"
    JOIN "Н_ОТДЕЛЫ" otd ON otd."ИД" = plan."ОТД_ИД"
    WHERE people."ИНН" IS NULL AND otd."КОРОТКОЕ_ИМЯ"='КТиУ'
);

-- 4
SELECT COUNT(uch."ИД"), uch."ГРУППА"
FROM "Н_УЧЕНИКИ" uch
JOIN "Н_ПЛАНЫ" plan ON uch."ПЛАН_ИД" = plan."ИД"
JOIN "Н_ОТДЕЛЫ" otd ON otd."ИД" = plan."ОТД_ИД_ЗАКРЕПЛЕН_ЗА"
WHERE otd."КОРОТКОЕ_ИМЯ" = 'ВТ' AND (
    extract(year from uch."НАЧАЛО") = 2011 OR
    extract(year from uch."КОНЕЦ") = 2011
) GROUP BY uch."ГРУППА";

SELECT uch."ГРУППА"
FROM "Н_УЧЕНИКИ" uch
         JOIN "Н_ПЛАНЫ" plan ON uch."ПЛАН_ИД" = plan."ИД"
         JOIN "Н_ОТДЕЛЫ" otd ON otd."ИД" = plan."ОТД_ИД_ЗАКРЕПЛЕН_ЗА"
WHERE otd."КОРОТКОЕ_ИМЯ" = 'ВТ' AND (
            extract(year from uch."НАЧАЛО") = 2011 OR
            extract(year from uch."КОНЕЦ") = 2011
    ) GROUP BY uch."ГРУППА"
HAVING COUNT(uch."ИД") = 5;

-- 5
SELECT uch."ГРУППА", AVG(age(people."ДАТА_РОЖДЕНИЯ")) AS Средний_возраст
FROM "Н_УЧЕНИКИ" uch
JOIN "Н_ЛЮДИ" people ON people."ИД" = uch."ЧЛВК_ИД"
GROUP BY uch."ГРУППА"
HAVING AVG(age(people."ДАТА_РОЖДЕНИЯ")) > (SELECT MIN(age(people."ДАТА_РОЖДЕНИЯ"))
                                           FROM "Н_УЧЕНИКИ" uch
                                           JOIN "Н_ЛЮДИ" people ON people."ИД" = uch."ЧЛВК_ИД"
                                           WHERE uch."ГРУППА" = '1100');

-- 6
SELECT uch."ГРУППА", people."ФАМИЛИЯ", people."ИМЯ", people."ОТЧЕСТВО", uch."П_ПРКОК_ИД"
FROM "Н_УЧЕНИКИ" uch
JOIN "Н_ПЛАНЫ" plan ON uch."ПЛАН_ИД" = plan."ИД"
JOIN "Н_НАПРАВЛЕНИЯ_СПЕЦИАЛ" ННС on plan."НАПС_ИД" = ННС."ИД"
JOIN "Н_НАПР_СПЕЦ" napr on ННС."НС_ИД" = napr."ИД"
JOIN "Н_ФОРМЫ_ОБУЧЕНИЯ" form ON plan."ФО_ИД" = form."ИД"
JOIN "Н_ЛЮДИ" people on uch."ЧЛВК_ИД" = people."ИД"
WHERE uch."ПРИЗНАК"='отчисл'
  AND form."НАИМЕНОВАНИЕ" = 'Очная'
  AND napr."КОД_НАПРСПЕЦ"='230101'
AND uch."КОНЕЦ" = '01-09-2012';

-- 7
CREATE OR REPLACE VIEW csu_id AS SELECT otd."ИД" FROM "Н_ОТДЕЛЫ" otd
WHERE otd."КОРОТКОЕ_ИМЯ" ='КТиУ' ;

CREATE OR REPLACE VIEW uchCsu AS SELECT uch."ИД", uch."ЧЛВК_ИД"
FROM "Н_УЧЕНИКИ" uch
JOIN "Н_ПЛАНЫ" plan ON uch."ПЛАН_ИД" = plan."ИД"
WHERE plan."ОТД_ИД" = (SELECT * FROM csu_id);

SELECT *
FROM "Н_ЛЮДИ" people
LEFT JOIN uchcsu u on people."ИД" = u."ЧЛВК_ИД"
WHERE u."ИД" IS NULL;
