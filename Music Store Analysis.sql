create database Music;
use music;
--------------------------------------------------------------------------------------------------------------------------------------

-- Q1)Who is the senior most employee on thee bases of job title?
select * from employee;
SELECT employee_id,concat(first_name,' ',last_name) Name_of_employee,title,levels 
FROM EMPLOYEE 
order by LEVELS desc
LIMIT 1;
--------------------------------------------------------------------------------------------------------------------------------------
-- Q2)Which country have the most invoices
select * from invoice; 

select billing_country Country,count(invoice_id) Total_number_of_invoice
from invoice
group by billing_country
order by count(invoice_id) desc
limit 1;
--------------------------------------------------------------------------------------------------------------------------------------

-- Q3) Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money.  
-- Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals
select * from invoice;

select billing_city as city,sum(total) as Total_Money
from invoice
group by billing_city
order by sum(total) desc
limit 1;
--------------------------------------------------------------------------------------------------------------------------------------

-- Q4)Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money
select * from customer;
select * from invoice;

select c.customer_id,concat(c.first_name,' ',c.last_name),sum(i.total) as Total_payment
from customer c
inner join invoice i
on c.customer_id=i.customer_id
group by c.customer_id,concat(c.first_name,' ',c.last_name)
order by sum(i.total) desc limit 1;
--------------------------------------------------------------------------------------------------------------------------------------

-- Q5)Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A
select * from customer;
select * from invoice;
select * from invoice_line;
select * from track;
select * from genre;

select c.email,concat(c.first_name,' ',c.last_name) as full_name ,g.name 
from customer c
inner join invoice i 
on c.customer_id=i.customer_id
inner join invoice_line il 
on i.invoice_id=il.invoice_id
inner join track t 
on il.track_id=t.track_id
inner join genre g 
on t.genre_id=g.genre_id
where g.name='Rock' and c.email like 'a%'
order by c.email desc
;
--------------------------------------------------------------------------------------------------------------------------------------

-- Q6) Let's invite the artists who have written the most rock music in our dataset.
-- Write a query that returns the Artist name and total track count of the top 10 rock bands
select * from artist;
select * from album;
select * from track;
select * from genre;

select a.name,count(case when g.name='Rock' then 0 end) 
from artist a
inner join album al 
on a.artist_id=al.artist_id
inner join track t 
on al.album_id=t.album_id
inner join genre g 
on t.genre_id=g.genre_id 
group by a.name;
--------------------------------------------------------------------------------------------------------------------------------------

-- q7) Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

select * from track;
select avg(milliseconds) from track;

select name,milliseconds from track
where milliseconds> (select avg(milliseconds) from track);
--------------------------------------------------------------------------------------------------------------------------------------
-- Q8)Find how much amount spent by each customer on artists? 
-- Write a query to return customer name, artist name and total spent
select * from customer;
select * from invoice_line;
select * from invoice;
select * from track;
select * from album;

select c.customer_id, a.name,sum(il.unit_price*il.quantity) as Total_price
from customer c 
inner join invoice i 
on c.customer_id=i.customer_id  
inner join invoice_line il 
on i.invoice_id=il.invoice_id
inner join track t 
on il.track_id=t.track_id
inner join album al 
on t.album_id=al.album_id
inner join artist a 
on al.artist_id=a.artist_id
group by c.customer_id,a.name
order by sum(il.unit_price*il.quantity) 
desc limit 10;
--------------------------------------------------------------------------------------------------------------------------------------

-- Q9) We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. 

select * from genre;
select * from invoice;

SELECT i.billing_state, i.billing_city,g.name genre_name,sum(i.total)
FROM invoice i 
INNER JOIN invoice_line il 
ON i.invoice_id = il.invoice_id
INNER JOIN track t 
ON il.track_id = t.track_id
INNER JOIN genre g 
ON t.genre_id = g.genre_id
GROUP BY i.billing_state,i.billing_city, g.name
order by sum(i.total) desc;
--------------------------------------------------------------------------------------------------------------------------------------

-- Q10)Write a query that determines the customer that has spent the most on music for each country. 
-- Write a query that returns the country along with the top customer and how much they spent. 

select * from invoice;
select c.customer_id,concat(c.first_name,' ',c.last_name) as Name_of_customer,i.billing_country,
a.name as name_of_artist,sum(total) as Total_spent
from customer c
inner join invoice i 
on c.customer_id=i.customer_id
inner join invoice_line il 
on i.invoice_id=il.invoice_id
inner join track t 
on il.track_id=t.track_id
inner join album al 
on t.album_id=al.album_id
inner join artist a 
on al.artist_id=a.artist_id
group  by c.customer_id,concat(c.first_name,' ',c.last_name),
i.billing_country,i.invoice_id,a.name
order by sum(total) 
desc limit 10;
--------------------------------------------------------------------------------------------------------------------------------------
