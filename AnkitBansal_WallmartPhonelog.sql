/*Write a SQL query to find out the caller's first and last call was the same person on a given day*/

--script:

use SQLPractice;

create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');

select * from phonelog

With CallLog AS (
    select Callerid,
    CAST(Datecalled as Date) as Called_date,
    min(Datecalled) as FirstCalled,
    max(Datecalled) as lastCalled
    from phonelog
    Group by Callerid,CAST(Datecalled as Date)
) 
    SELECT c.*,
    p1.Recipientid,
    p1.Recipientid
    from CallLog c
    INNER JOIN phonelog p1 on p1.Callerid=c.Callerid and p1.Datecalled=c.FirstCalled
    INNER JOIN phonelog p2 on p2.Callerid=c.Callerid and p2.Datecalled=c.lastCalled
    where p1.Recipientid=p2.Recipientid;
