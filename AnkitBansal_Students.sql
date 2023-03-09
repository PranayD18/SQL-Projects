
https://www.youtube.com/watch?v=6CH7IU4yB5I&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=40

/*
write a query to report the students being 'quiet' in all exams
A 'Quite' student is the one who took atleast 1 exam and didn't score neither the high score nor the low score in any of the exam
don't return the student who has never taken any exam. 
return the table result ordered by student_id
*/

use SQLPractice;
--scripts:
create table students
(
student_id int,
student_name varchar(20)
);
insert into students values
    (1,'Daniel'),
    (2,'Jade'),
    (3,'Stella'),
    (4,'Jonathan'),
    (5,'Will');

create table exams
(
exam_id int,
student_id int,
score int);

insert into exams values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);

select * from students;
select * from exams;

