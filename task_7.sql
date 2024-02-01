-- ДАННУЮ СТРУКТУРУ ТАБЛИЦ Я НАШЁЛ БОЛЕЕ ПРИМЕНИМОЙ К ЖИЗНИ И УДОБНОЙ ДЛЯ УЧЁТА ЖИВОТНЫХ И ПРОВЕДЕНИЯ РАЗЛИЧНЫХ МАНИПУЛЯЦИЙ, ЧЕМ ДЕЛЕНИЕ ЕЁ НА ОТДЕЛЬНЫЕ ВИДЫ ЖИВОТНЫХ. 

-- 7. Работа с MySQL (Задача выполняется в случае успешного выполнения задачи “Работа с MySQL в Linux. “Установить MySQL на вашу машину”

-- 7.1. После создания диаграммы классов в 6 пункте, в 7 пункте база данных "Human Friends" должна быть структурирована в соответствии с этой диаграммой. Например, можно создать таблицы, которые будут соответствовать классам "Pets" и "Pack animals", и в этих таблицах будут поля, которые характеризуют каждый тип животных (например, имена, даты рождения, выполняемые команды и т.д.). 
-- 7.2   - В ранее подключенном MySQL создать базу данных с названием "Human Friends".
--    - Создать таблицы, соответствующие иерархии из вашей диаграммы классов.
--    - Заполнить таблицы данными о животных, их командах и датами рождения.

DROP DATABASE IF EXISTS human_friends;
CREATE DATABASE human_friends;
USE human_friends;

DROP TABLE IF EXISTS class;
CREATE TABLE class
(
	type VARCHAR(100) NOT NULL UNIQUE,
    id INT NOT NULL,
    class_name VARCHAR(100)
);
INSERT INTO class (type, id, class_name) VALUES
('Dog', 1, 'Pets'),
('Cat', 1, 'Pets'),
('Hamster', 1, 'Pets'),
('Horse', 2, 'PackAnimals'),
('Camel', 2, 'PackAnimals'),
('Donkey', 2, 'PackAnimals');


DROP TABLE IF EXISTS animals;
CREATE TABLE animals
(
	id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(100),
    birthdate DATE,
    class_id INT NOT NULL,
    
    FOREIGN KEY (type) REFERENCES class(type) ON UPDATE CASCADE ON DELETE CASCADE 
);
INSERT INTO animals (name, type, birthdate, class_id)
VALUES 
('Fido', 'Dog', '2020-01-01', 1),
('Whiskers', 'Cat', '2019-05-15', 1),
('Hammy', 'Hamster', '2021-03-10', 1),
('Buddy', 'Dog', '2018-12-10', 1),
('Smudge', 'Cat', '2020-02-20', 1),
('Peanut', 'Hamster', '2021-08-01', 1),
('Bella', 'Dog', '2019-11-11', 1),
('Oliver', 'Cat', '2020-06-30', 1),
('Thunder', 'Horse', '2015-07-21', 2),
('Sandy', 'Camel', '2016-11-03', 2),
('Eeyore', 'Donkey', '2017-09-18', 2),
('Storm', 'Horse', '2014-05-05', 2),
('Dune', 'Camel', '2018-12-12', 2),
('Burro', 'Donkey', '2019-01-23', 2),
('Blaze', 'Horse', '2016-02-29', 2),
('Sahara', 'Camel', '2015-08-14', 2);


DROP TABLE IF EXISTS comands;
CREATE TABLE comands
(
	id SERIAL PRIMARY KEY,
    comand_name VARCHAR(100) UNIQUE
);
INSERT INTO comands (comand_name) VALUES
('Sit'),
('Stay'),
('Fetch'),
('Pounce'),
('Roll'),
('Hide'),
('Paw'),
('Bark'),
('Scratch'),
('Spin'),
('Meow'),
('Jump'),
('Trot'),
('Canter'),
('Gallop'),
('Walk'),
('Carry Load'),
('Bray'),
('Kick'),
('Run');


DROP TABLE IF EXISTS comands_animal;
CREATE TABLE comands_animal
(
	animal_id BIGINT UNSIGNED NOT NULL,
    comand_id BIGINT UNSIGNED NOT NULL,
    
    FOREIGN KEY (animal_id) REFERENCES animals(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (comand_id) REFERENCES comands(id) ON UPDATE CASCADE ON DELETE CASCADE
);
INSERT INTO comands_animal (animal_id, comand_id) VALUES
(1, (SELECT id FROM comands WHERE comand_name = 'Sit')),
(1, (SELECT id FROM comands WHERE comand_name = 'Stay')),
(1, (SELECT id FROM comands WHERE comand_name = 'Fetch')),
(2, (SELECT id FROM comands WHERE comand_name = 'Sit')),
(2, (SELECT id FROM comands WHERE comand_name = 'Pounce')),
(3, (SELECT id FROM comands WHERE comand_name = 'Roll')),
(3, (SELECT id FROM comands WHERE comand_name = 'Hide')),
(4, (SELECT id FROM comands WHERE comand_name = 'Sit')),
(4, (SELECT id FROM comands WHERE comand_name = 'Paw')),
(4, (SELECT id FROM comands WHERE comand_name = 'Bark')),
(5, (SELECT id FROM comands WHERE comand_name = 'Sit')),
(5, (SELECT id FROM comands WHERE comand_name = 'Pounce')),
(5, (SELECT id FROM comands WHERE comand_name = 'Scratch')),
(6, (SELECT id FROM comands WHERE comand_name = 'Roll')),
(6, (SELECT id FROM comands WHERE comand_name = 'Spin')),
(7, (SELECT id FROM comands WHERE comand_name = 'Sit')),
(7, (SELECT id FROM comands WHERE comand_name = 'Stay')),
(7, (SELECT id FROM comands WHERE comand_name = 'Roll')),
(8, (SELECT id FROM comands WHERE comand_name = 'Meow')),
(8, (SELECT id FROM comands WHERE comand_name = 'Scratch')),
(8, (SELECT id FROM comands WHERE comand_name = 'Jump')),
(9, (SELECT id FROM comands WHERE comand_name = 'Trot')),
(9, (SELECT id FROM comands WHERE comand_name = 'Canter')),
(9, (SELECT id FROM comands WHERE comand_name = 'Gallop')),
(10, (SELECT id FROM comands WHERE comand_name = 'Walk')),
(10, (SELECT id FROM comands WHERE comand_name = 'Carry Load')),
(11, (SELECT id FROM comands WHERE comand_name = 'Walk')),
(11, (SELECT id FROM comands WHERE comand_name = 'Carry Load')),
(11, (SELECT id FROM comands WHERE comand_name = 'Bray')),
(12, (SELECT id FROM comands WHERE comand_name = 'Trot')),
(12, (SELECT id FROM comands WHERE comand_name = 'Canter')),
(13, (SELECT id FROM comands WHERE comand_name = 'Walk')),
(13, (SELECT id FROM comands WHERE comand_name = 'Sit')),
(14, (SELECT id FROM comands WHERE comand_name = 'Walk')),
(14, (SELECT id FROM comands WHERE comand_name = 'Bray')),
(14, (SELECT id FROM comands WHERE comand_name = 'Kick')),
(15, (SELECT id FROM comands WHERE comand_name = 'Trot')),
(15, (SELECT id FROM comands WHERE comand_name = 'Jump')),
(15, (SELECT id FROM comands WHERE comand_name = 'Gallop')),
(16, (SELECT id FROM comands WHERE comand_name = 'Walk')),
(16, (SELECT id FROM comands WHERE comand_name = 'Run'));


--    - Удалить записи о верблюдах и объединить таблицы лошадей и ослов.

DELETE FROM animals WHERE type = 'Camel';

SELECT * FROM animals WHERE type IN ('Horse', 'Donkey');


--    - Создать новую таблицу для животных в возрасте от 1 до 3 лет и вычислить их возраст с точностью до месяца.

DROP TABLE IF EXISTS animal_1_3_years;
CREATE TABLE animal_1_3_years AS SELECT id, name, type, birthdate, class_id, 
CONCAT(TIMESTAMPDIFF(YEAR, birthdate, NOW()), ' years, ',TIMESTAMPDIFF(MONTH, birthdate, NOW())-TIMESTAMPDIFF(YEAR, birthdate, NOW())*12, ' months') AS age_months FROM animals
WHERE birthdate > NOW() - INTERVAL 3 YEAR AND birthdate < NOW() - INTERVAL 1 YEAR;

SELECT * FROM animal_1_3_years;


--    - Объединить все созданные таблицы в одну, сохраняя информацию о принадлежности к исходным таблицам.

SELECT 
		a.id as 'id(animals)', 
        a.name as 'name(animals)', 
        a.type as 'type(animals)',
        a.birthdate as 'birthday(animals)',
        a.class_id as 'class_id(animals)',
		c.type as 'type(class)', 
        c.id as 'id(class)',
        c.class_name as 'class_name(class)',
        cm.id as 'id(comands)',
        cm.comand_name as 'comand_name(comands)',
        ca.animal_id as 'animal_id(comands_animal)',
        ca.comand_id as 'comand_id(comands_animal)',
		a13.id as 'id(animal_1_3_years)', 
        a13.name as 'name(animal_1_3_years)', 
        a13.type as 'type(animal_1_3_years)',
        a13.birthdate as 'birthday(animal_1_3_years)',
        a13.class_id as 'class_id(animal_1_3_years)',
        a13.age_months as 'age_months(animal_1_3_years)'
FROM animals a
LEFT JOIN animal_1_3_years a13 ON a.id=a13.id
LEFT JOIN class c ON a.type=c.type
LEFT JOIN comands_animal ca ON ca.animal_id=a.id
LEFT JOIN comands cm ON cm.id=ca.comand_id;