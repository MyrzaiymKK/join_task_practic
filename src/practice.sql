--Получите все записи таблицы groups;
select * from groups;
--Получите общее количество записей таблицы groups
select count(*) from groups;
--Выведите группы их курсы
select * from groups g join courses c on g.id = c.group_id;
-- Выведите курсы групп у которых курс начался с 2020-1-1 по 2023-3-3
select * from courses c inner join groups g on c.group_id = g.id where date_of_start between '2020-1-1' and '2023-3-3';
-- Выведите имена, дату рождения студентов , которые родились с 1980-1-1 по 2004-12-12, и название группы
select s.first_name, s.date_of_birth,group_name from students s inner join groups g on s.group_id = g.id where date_of_birth between '1980-1-1' and '2004-12-12';
-- Выведите суммарный возраст всех студентов курса 'Python'
select sum(extract(year from age(now(), s.date_of_birth))) as sum from students s
    inner join groups g on s.group_id = g.id
    inner join courses c on g.id = c.group_id
where course_name = 'Python';
-- Вывести полное имя, возраст, почту студентов и название группы, где айди группы равен 3
select g.group_name, s.first_name,extract(year from age(now(), s.date_of_birth)) as age,s.email from students s inner join groups g on s.group_id = g.id where g.id = 3;
-- Вывести все курсы одной группы, где название группы 'Java-12'
select * from courses c inner join groups g on c.group_id = g.id where g.group_name = 'Java-12';
-- Вывести название всех групп и количество студентов в группе
select g.id, g.group_name, count(s.id) from groups g inner join students s on s.group_id = g.id group by g.id, g.group_name;
-- Вывести название всех групп и количество студентов в группе, если в группе больше 4 студентов
select g.id, g.group_name, count(s.id) from groups g inner join students s on s.group_id = g.id group by g.id, g.group_name having s.count >= 4;
-- Отсортируйте имена студентов группы по убыванию, где айди группы равна 4 и выведите айди студента, имя, пол и название группы
select s.first_name from students s inner join groups g on g.id = s.group_id where group_id = 4 order by s.first_name desc ;

-- Вывести все курсы
select * from courses;
-- Вывести все уроки курса 'Technical English'
select * from courses inner join lessons l on courses.id = l.course_id where course_name = 'Technical English';
-- Вывести количество всех студентов курса id = 4
select count(c.id) from courses c inner join students s on c.group_id = s.group_id where c.id = 4;
-- Вывести имя, почту, специализацию ментора и название курса где курс айди равен 2
select m.first_name,m.email,m.specialization from mentors m inner join courses c on m.course_id = c.id where c.id = 2;
-- Посчитить сколько менторов в каждом курсе
select c.course_name,count(m.id) from courses c inner join mentors m on m.course_id = c.id group by c.course_name ;
-- Сгруппируйте и посчитайте менторов в каждом курсе и выведите только те курсы, где в курсе больше 2 менторов
select c.course_name,count(m.id) from courses c inner join mentors m on m.course_id = c.id group by c.course_name having m.count >= 2;
-- Вывести название, дату и полное имя ментора, все курсы которые начинаются с 2020-1-1 по 2023-3-3
select m.first_name,c.course_name,c.date_of_start from courses c inner join mentors m on m.course_id = c.id where c.date_of_start between '2020-1-1' and '2023-3-3';
-- Вывести имя, почту, возраст студентов курса 'Java'
select s.first_name,s.email,extract(year from age(now(), s.date_of_birth)) as age from students s inner join courses c on s.group_id = c.group_id where c.course_name = 'Java';
-- Вывести тот курс  где нет ментора
select * from courses c left join  mentors m on c.id = m.course_id where m.id is null ;
-- Вывести тот курс  где нет уроков
select * from courses c left join lessons l on c.id = l.course_id where l.id is null;
-- Вывести тот курс  где нет студентов
select * from courses c left join students s on c.id = s.group_id where s.group_id is null;

-- Вывести общее количество студентов
select count(*) as total_students from students;
-- Вывести общее количество студентов, которым 18 и старше
select count(*) from students s where extract(year from age(now(), s.date_of_birth)) >= 18;
-- Вывести имя, почту и пол студента, айди группы которого равна 2
select s.first_name,s.email,s.gender from students s inner join groups g on s.group_id = g.id where g.id = 2;
-- Вывести суммарный возраст всех студентов, которые младше 20
select sum(extract(year from age(now(), s.date_of_birth))) as sum from students s where extract(year from age(now(), s.date_of_birth)) < 20;
-- Вывести группу студента, айди которого равна 4
select * from groups g inner join students s on g.id = s.group_id where s.id = 4;
-- Сгруппируйте студентов по gender и выведите общее количество gender
select gender,count(s.gender) as counter from students s  group by gender;
select count(gender) from students;
-- Найдите студента с айди 8 и обновите его данные
update students set first_name = 'Myrzaiym' where id = 8;
select * from students;
-- Найдите самого старшего студента курса, айди курса которого равна 5
select max(extract(year from now()) - extract(year from s.date_of_birth)) as max_age from students s inner join courses c on s.group_id = c.group_id where c.id = 5;
-- Добавьте unique constraint email в столбец таблицы students
alter table students add constraint email unique (email);
-- Добавьте check constraint gender в столбец таблицы mentors
alter table mentors add constraint gender check( gender in ('Male','Female') );
-- Переименуйте таблицу mentors в instructors
alter table mentors rename to instructors;

--mentor
-- Вывести имя, почту и специализацию ментора группы 'Java-9'
select m.first_name, m.email,m.specialization from instructors m inner join groups g on m.id = g.id where g.group_name = 'Java-9';
-- Вывести всех менторов, чей опыт превышает 1 год
select * from instructors where experience > 1;
-- Вывести ментора у которого нет курса

select * from instructors i left join courses c on c.id = i.course_id where c.id is null;
-- Вывести айди, имя ментора и его студентов
select s.first_name, i.first_name,i.id from instructors i inner join courses c on i.course_id = c.id inner join students s on c.group_id = s.group_id ;
-- Посчитать сколько студентов у каждого ментора, и вывести полное имя ментора и количество его студентов
select i.first_name, count(i.id) from instructors i inner join courses c on i.course_id = c.id inner join students s on c.group_id = s.group_id group by i.first_name;
-- Вывести ментора у которого нет студентов
select i.first_name,i.id from instructors i left join courses c on i.course_id = c.id left join groups g on c.group_id = g.id left join students s on g.id = s.group_id where course_id is null;
-- Вывести ментора у которого студентов больше чем 2
select i.first_name, count(i.id) from instructors i inner join courses c on i.course_id = c.id inner join students s on c.group_id = s.group_id  group by i.first_name having i.count > 2 ;
-- Вывести курсы ментора с айди 5
select * from instructors i inner join courses c on i.course_id = c.id where i.id = 5;
-- Вывести все уроки ментора, айди которого равен 5
select * from instructors i inner join lessons l on i.course_id = l.course_id where i.id=5;

--lesson
-- Вывести все уроки
select * from lessons;
-- Получить все уроки студента, айди которого равен 2
select * from lessons l inner join courses c on l.course_id = c.id inner join groups g on c.group_id = g.id inner join students s on g.id = s.group_id where s.id = 2;
-- Посчитать уроки каждой группы и вывести название группы и количество уроков, где количество уроков больше чем 2
select g.group_name,count(l.id) from lessons l inner join courses c on l.course_id = c.id inner join groups g on c.group_id = g.id group by g.group_name having l.count >= 2;
-- Отсортировать уроки студента по названию, где айди студента равна 7
select * from lessons l inner join courses c on l.course_id = c.id inner join groups g on c.group_id=g.id inner join students s on g.id = s.group_id where s.id = 7 order by l.lesson_name;
-- Получить все уроки курса, где название курса 'Python kids'
select * from lessons l inner join courses c on l.course_id = c.id inner join groups g on c.group_id=g.id inner join students s on g.id = s.group_id where l.lesson_name = 'Python kids';
-- Получить все уроки ментора, айди которого равен 5
select * from instructors i inner join lessons l on i.course_id = l.course_id where i.id=5;
