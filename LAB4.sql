-- вариант 171122

-- 1. Таблицы: Н_ЛЮДИ, Н_СЕССИЯ.
-- Вывести атрибуты: Н_ЛЮДИ.ИМЯ, Н_СЕССИЯ.ДАТА.
-- Фильтры (AND):
-- a) Н_ЛЮДИ.ИМЯ > Роман.
-- b) Н_СЕССИЯ.ДАТА > 2004-01-17.
-- Вид соединения: INNER JOIN.

SELECT person."ИМЯ", session."ДАТА" FROM
    "Н_СЕССИЯ" session
        JOIN "Н_ЛЮДИ" person on session."ЧЛВК_ИД" = person."ИД"
WHERE person."ИМЯ" > 'Роман'
  AND session."ДАТА" > '2004-01-17';

-- first: execution: 71 ms
-- second: execution: 66 ms
-- third: execution: 68 ms
BEGIN;
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON ) SELECT person."ИМЯ", session."ДАТА" FROM
    "Н_СЕССИЯ" session
        JOIN "Н_ЛЮДИ" person on session."ЧЛВК_ИД" = person."ИД"
WHERE person."ИМЯ" > 'Роман'
  AND session."ДАТА" > '2004-01-17';
ROLLBACK;

SELECT count(*)
FROM "Н_СЕССИЯ" session
WHERE session."ДАТА" <= '2004-01-17';

-- 2. Таблицы: Н_ЛЮДИ, Н_ВЕДОМОСТИ, Н_СЕССИЯ.
-- Вывести атрибуты: Н_ЛЮДИ.ИМЯ, Н_ВЕДОМОСТИ.ДАТА, Н_СЕССИЯ.ЧЛВК_ИД.
-- Фильтры (AND):
-- a) Н_ЛЮДИ.ИД = 100865.
-- b) Н_ВЕДОМОСТИ.ЧЛВК_ИД < 142390.
-- c) Н_СЕССИЯ.ДАТА > 2012-01-25.
-- Вид соединения: RIGHT JOIN

SELECT person."ИМЯ", ved."ДАТА", session."ЧЛВК_ИД" FROM
"Н_СЕССИЯ" session
RIGHT JOIN "Н_ЛЮДИ" person on session."ЧЛВК_ИД" = person."ИД"
JOIN "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК" soes ON soes."ИД" = session."СЭС_ИД"
JOIN "Н_ВЕДОМОСТИ" ved on session."ИД" = ved."СЭС_ИД"
WHERE person."ИД" = 100865 AND ved."ЧЛВК_ИД" < 142390 AND session."ДАТА" > '2012-01-25';

BEGIN;
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) SELECT person."ИМЯ",  ved."ДАТА", session."ЧЛВК_ИД" FROM
    "Н_СЕССИЯ" session
        RIGHT JOIN "Н_ЛЮДИ" person on session."ЧЛВК_ИД" = person."ИД"
        RIGHT JOIN "Н_СОДЕРЖАНИЯ_ЭЛЕМЕНТОВ_СТРОК" soes ON soes."ИД" = session."СЭС_ИД"
        RIGHT JOIN "Н_ВЕДОМОСТИ" ved on soes."ИД" = ved."СЭС_ИД"
WHERE person."ИД" = 100865 AND ved."ЧЛВК_ИД" < 142390 AND session."ДАТА" > '2010-01-25';
ROLLBACK;

-- 1) 30 ms
-- 2) 23 ms
-- 3) 21 ms
