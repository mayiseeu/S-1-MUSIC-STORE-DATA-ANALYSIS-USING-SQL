------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SET 1
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM album
SELECT * FROM artist
--Q1. Who is the senoior most employee based on job tiitle?------------------
SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1

--Q.2 Which country have the most invoices?-------------------------

SELECT count(*) as c  -- It will give the total count of the invoice mmeans how much data is here not in toital but in count.
FROM invoice

SELECT billing_country, count(*) as C --it will give the count of the billing country means how many time the country have appeared mean the same country have appeared how many time it will give the count of that ,you can write in that way and you can write in this way also {COUNT(*) , billing_country} both are same .
FROM invoice
GROUP BY billing_country
ORDER BY C desc
limit 5

--Q.3 What are top 3 values of total invoice?--------------------------------

SELECT total FROM invoice
ORDER BY total DESC
limit 3

--Q.4 Which city has the best customers? We would like to throw a promotional Music Festival in the city we madde the most money,Write a query that returns one city that has the the highest sum of invoice totals . Return both the city name And sum of all invoice totals--------------------------------

SELECT SUM(total) as invoice_total , billing_city 
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC

--Q.5 Who is the best customer? The customer who spent the most money will be declared as the best customer .W.A.Q that returns the person who has the spent the most money------------------------------------


SELECT * FROM customer
SELECT * FROM invoice

SELECT customer.customer_id,customer.first_name,customer.last_name,SUM(invoice.total) as total
FROM customer
JOIN invoice ON customer.customer_id=invoice.customer_id
GROUP BY customer.customer_id
ORDER BY total DESC
LIMIT 1
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SET2
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Q.1 W.A.Q to return the email,first_name,last_name & Genre of all Rock Music listeners.
--return your list ordered alphabetically by email starting with A----------------------------------------------

select track_id --we have join the track and genre and fetch out the tracki_d data with the genre name ROCK  
from track_id
JOIN genre ON track.genre_id=genre.genre_id
where genre.name LIKE 'Rock'

-- now we will combine the the other three table

SELECT customer.first_name,customer.last_name,customer.email
FROM customer
JOIN invoice ON invoice.customer_id=customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id= invoice.invoice_id--we have combined the customer,invoice and invoice line table till here
WHERE track_id IN
(select track.track_id --we have join the track and genre and fetch out the tracki_d data with the genre name ROCK  
from track
JOIN genre ON track.genre_id=genre.genre_id
where genre.name LIKE 'Rock')
ORDER BY customer.email

--practicing this question again

SELECT * FROM genre

SELECT track_id
FROM track
JOIN genre on genre.genre_id=track.genre_id
WHERE genre.name LIKE 'Rock'

SELECT email,first_name,last_name,genre.name
FROM customer
JOIN invoice ON invoice.customer_id=customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id=invoice.invoice_id
WHERE track_id IN (SELECT track_id
FROM track
JOIN genre on genre.genre_id=track.genre_id
WHERE genre.name LIKE 'Rock')
ORDER BY email
----------------------------------------------------------------------------------------------------
--Q.2 Let invite the artist who have written the most rock music
--in our dataset. W.A.Q  that returns the artist name and the total
--track count of the top 10 rock bands.

--trying

SELECT  
FROM artist
JOIN track ON track.album_id=album.album_id
JOIN album ON album.artist_id = artist.artist_id
WHERE 
(SELECT track_id
FROM track
JOIN genre.genre_id=track.genre_id
WHERE genre.name LIKE 'Rock')--this is wrong below is right

---------------      --------
SELECT artist.name,COUNT(album.artist_id) AS id--we have put the count in artist-id because 
                                               ---of one name there can be two artist and we can only differentiate both of 
											   --them on the basis of unique id only and the no. of time the unique id will repeat means 
											   --the no. of  genre rock have been sung by her/him so we have put the group by clause on the basis of artist_id 
FROM track                                     -- now say it id or number of song both are same


JOIN album ON  album.album_id=track.album_id
JOIN genre ON genre.genre_id=track.genre_id

JOIN artist ON artist.artist_id= album.artist_id

WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id-- because two artist can be of same name so i have group by id
ORDER BY id DESC
LIMIT 10
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--practice of set 2 q1
SELECT track_id
FROM track
join genre ON genre.genre_id=track.genre_id
where genre.name LIKE 'Rock'

select first_name,last_name,email
FROM customer
JOIN invoice ON invoice.customer_id=customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE track_id IN(SELECT track_id
FROM track
join genre ON genre.genre_id=track.genre_id
where genre.name LIKE 'Rock')
ORDER BY email

-- the data you canfetch out is only from the join table not what data yoou have fetch inside the join table

--practice of set 2 q2
SELECT artist.artist_id,artist.name,COUNT(track_id) as tracks
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id

ORDER BY tracks desc
LIMIT 10

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Q.3 Return all the track name that have a song length longer
--than the average song length.Return the name and milloseconds 
--for each track order by the song length with the longest song listed first.

--solution
--this is the wrong solution, no aggregate function can be used with the where clause
SELECT track.name, Avg(milliseconds) AS AVERG
FROM track
WHERE track.milliseconds > Avg(milliseconds)


--right solution


SELECT  Avg(milliseconds) AS AVERG
FROM track
--firSt i have taaken out the average THen i
-- will put it with the where clause


SELECT track.name,track.milliseconds
FROM track
where track.milliseconds > (SELECT  Avg(milliseconds) AS AVERG
FROM track)
ORDER BY track.milliseconds desc
LIMIT 10
