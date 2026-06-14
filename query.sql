Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.
  --01
select match_id,fixture,base_ticket_price
from matches
where tournament_category = 'Champions League'
  and match_status = 'Available';

Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
  --02
select user_id,full_name,email from users
where full_name like 'Tanvir%' or full_name ilike '%Haque%';

Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
  --03
select booking_id,user_id,match_id,coalesce(payment_status,'Action Required')
  as systematic_status from bookings
where payment_status is null;

Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.
--04

select booking_id,full_name,fixture,total_cost 
from bookings b inner join users u on b.user_id=u.user_id
inner join matches m on b.match_id=m.match_id;

Query 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have never bought a ticket are still listed.

--05
select u.user_id,u.full_name,booking_id 
from users u left join bookings b
on b.user_id=u.user_id;

Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.

--06

select booking_id,m.match_id,total_cost from bookings b
join matches m on b.match_id=m.match_id
where total_cost> (select avg(total_cost) from bookings);
  
Query 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.

--07

select match_id,fixture,base_ticket_price from matches
order by base_ticket_price desc limit 2 offset 1;
