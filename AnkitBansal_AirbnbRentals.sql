

--https://www.youtube.com/watch?v=5O4Tx72-CKU&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=46

-- Write a query to determine if two Airbnb rentals have the same exact amenities offered

CREATE TABLE [rental_amenities](
 [rental_id] int ,
 [amenity] varchar(255) 
)

insert into rental_amenities
VALUES 
(123,'pool'),
(123,'kitchen'),
(234,'hot tub'),
(234,'fireplace'),
(345,'kitchen'),
(345,'pool'),
(456,'pool'),
(452,'beach'),
(452,'free parking');

SELECT distinct rental_id
from rental_amenities;

SELECT distinct rental_id,
--string_agg(amenity) as list
STRING_AGG(amenity,'|') as list
from rental_amenities
group by rental_id;
