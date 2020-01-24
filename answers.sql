-- Practice joins

-- 1.
SELECT *
FROM invoice
JOIN invoice_line
ON invoice.invoice_id = invoice_line.invoice_id
WHERE invoice_line.unit_price > 0.99;

-- 2.
SELECT invoice_date, first_name, last_name, total
FROM invoice i
JOIN customer c
ON i.customer_id = c.customer_id;

-- 3.
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e
ON c.support_rep_id = e.employee_id;

-- 4.
SELECT a.title, ar.name
FROM album a
JOIN artist ar
ON a.artist_id = ar.artist_id;

-- 5.
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p
ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

-- 6.
SELECT t.name
FROM track t
JOIN playlist_track pt
ON t.track_id  = pt.track_id
WHERE pt.playlist_id = 5;

-- 7.
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist p
ON pt.playlist_id = p.playlist_id;

-- 8.
SELECT t.name, a.title
FROM track t
JOIN genre g
ON t.genre_id = g.genre_id
JOIN album a
ON t.album_id = a.album_id
WHERE g.name = 'Alternative & Punk';

-- Black Diamond
SELECT t.name, g.name, a.title, ar.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
JOIN album a ON t.album_id = a.album_id
JOIN artist ar ON a.artist_id = ar.artist_id
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

-- =========================================================
-- Practice Nested Queries

-- 1.
select * from invoice
where invoice_id
IN (select invoice_id from invoice_line where unit_price > 0.99 );

-- 2.
select * from playlist_track
where playlist_id
in (select playlist_id from playlist where name = 'Music');

-- 3.
select name from track
where track_id
in (select track_id from playlist_track where playlist_id = 5);

-- 4.
select * from track
where genre_id
in (select genre_id from genre where name = 'Comedy');

-- 5.
select * from track
where album_id
in (select album_id from album where name = 'Fireball');

-- 6.
select * from track
where album_id
in (select album_id from album where artist_id
  in (select artist_id from artist where name ='Queen'));

-- =========================================================
-- Practice Updating Rows

-- 1.
update customer
set fax = null
where fax is not null;

-- 2.
update customer
set company = 'Self'
where company is null;

-- 3.
update customer
set last_name = 'Thompson'
where first_name = 'Julia' and last_name = 'Barnett';

-- 4.
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

-- 5.
update track
set composer = 'The darkness around us'
where genre_id = (select genre_id from genre where name = 'Metal') and composer is null;

-- =========================================================
-- Group By

-- 1.
select count(*), g.name from track t
join genre g on t.genre_id = g.genre_id
group by g.name;

-- 2.
select count(*), g.name from track t
join genre g on g.genre_id = t.genre_id
where g.name = 'Pop' or g.name = 'Rock'
group by g.name;

select ar.name, count(*) from album al
join artist ar on ar.artist_id = al.artist_id
group by ar.name;

-- =========================================================
-- Use Distinct

-- 1.
select distinct composer
from track;

-- 2.
select distinct billing_postal_code
from invoice;

-- 3.
select distinct company
from customer;

-- =========================================================
-- Delete Rows

-- 1.
-- Did the task

-- 2.
delete from practice_delete
where type = 'bronze';

-- 3.
delete from practice_delete
where type = 'silver';

-- 4.
delete from practice_delete
where value = 150;

-- =========================================================
-- eCommerce Simulation

-- Create 3 tables
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name text not null,
  email text not null
)

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name text not null,
  price float not null
)

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  product_id serial references products(product_id)
);

-- Add data to tables
INSERT INTO users (name, email)
VALUES
  ('jeff', 'jeff@email.com'),
  ('molly', 'molly@email.com'),
  ('luna', 'luna@email.com');

INSERT INTO products (name, price)
VALUES
  ('egg', 0.49),
  ('bread', 1.99),
  ('butter', 2.99);

INSERT INTO orders (product_id)
VALUES
	(1),
  (2),
  (3);