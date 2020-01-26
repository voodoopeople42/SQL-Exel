
-- 1. Вывести самую объемную книгу +

SELECT TOP (1)
	MAX(pages) as book_pages
	, name_book
FROM Book
GROUP BY name_book
ORDER BY book_pages DESC;


--  2. Вывести всех студентов, которые брали книгу name_1 +


SELECT s.name_student 
FROM Students as s 
join Book as b on b.id_book=s.id_book
WHERE b.name_book='name_1';


-- 3. Какое кол-во студентов брали книгу name_2 +
SELECT 
	COUNT(*) 
FROM 
	Students as s
join Book as b on b.id_book=s.id_book
WHERE b.name_book='name_2';

-- 4. Вывести в алфавитном порядке названия самых дорогих книг в каждом жанре. C условием, что все цены уникальны +
SELECT name_book
		, genre
		, price
FROM Book
WHERE price IN (
SELECT
    MAX(distinct(price))
FROM Book
GROUP BY genre
)
ORDER BY name_book

-- 5. Вывести все возможные данные по книгам, в названии которых присутствует символ "%" +
SELECT *
FROM Book
where name_book LIKE '%[%]%';

-- 6. Вывести имена последних (по дате) трех студентов и книги, которые они брали +
-- MSSQL
SELECT TOP 3
	s.name_student
	,b.name_book
FROM Students AS S
JOIN Book AS B ON S.id_book=B.id_book
ORDER BY s.date DESC

-- Oracle
SELECT 
	s.name_student
	,b.name_book
FROM Students AS S
JOIN Book AS B ON S.id_book=B.id_book
WHERE ROWNUM <= 3;
ORDER BY s.date DESC;

--7. Вывести книги, которые студенты не брали в течение последнего месяца

--MSSQL 
SELECT
	name_book
FROM Book
Where id_book IN (
SELECT 
	id_book
FROM Students 
WHERE DATE<DATEADD(MONTH,DATEDIFF(MONTH,0,CURRENT_TIMESTAMP)-1,0)
  OR  DATE>DATEADD(MONTH,DATEDIFF(MONTH,0,CURRENT_TIMESTAMP)  ,0)
  )
-- Oracle
SELECT
	name_book
FROM Book
Where id_book IN (
SELECT 
	id_book
FROM Students 
WHERE DATE<add_months(sysdate,-1)
  OR  DATE>sysdate
  )

