-- Write a SQL query to count the number of characters except for the spaces for each actor. Return the first 10 actors' name lengths along with their names.

select concat(first_name,' ',last_name) as Actor_Name,length(concat(first_name,last_name)) as Actor_Name_Lengths from actor
limit 10;

-- List all Oscar awardees(Actors who received the Oscar award) with their full names and the length of their names.

select concat(first_name,' ',last_name) as Actor_Name,length(concat(first_name,last_name)) as Actor_Name_Lengths from actor_award
where awards like '%Oscar%';

-- Find the actors who have acted in the film ‘Frost Head.’

select First_name,Last_name from actor A
Inner Join film_actor FA
On A.actor_id = FA.actor_id
Inner Join Film F
On FA.film_id = F.film_id
where title = 'FROST HEAD';

-- Pull all the films acted by the actor ‘Will Wilson.’

select title as Films from film F
Inner Join film_actor FA
ON F.film_id = FA.film_id
Inner Join Actor A
ON FA.actor_id = A.actor_id
where first_name = 'Will' and last_name = 'Wilson'

-- Pull all the films which were rented and return them in the month of May.



select title as Films from rental R
Inner Join inventory I
on R.inventory_id = I.inventory_id
Inner Join film F
on I.film_id = F.film_id
where month(return_date) =05


-- Pull all the films with ‘Comedy’ category.

select Title from film F
Inner Join film_category FC
on F.film_id = FC.film_id
Inner Join category C
on FC.category_id = C.category_id
where name = 'comedy'