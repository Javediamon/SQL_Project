use ig_clone;
#Q2) We want to reward the user who has been around the longest, Find the 5 oldest users.

select * ,dense_rank() over (order by created_at  desc) as Oldest_user from users
limit 5;

#Q3)  To target inactive users in an email ad campaign, find the users who have never posted a photo.

SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM photos);

#Q4)  Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?

SELECT  users.username as username, photos.id as photo_id, COUNT(*) as Most_liked FROM likes
 INNER JOIN photos ON likes.photo_id=photos.id JOIN users ON photos.user_id=users.id 
GROUP BY likes.photo_id ORDER BY Most_liked DESC LIMIT 1;


#Q5)  The investors want to know how many times does the average user post.

SELECT ROUND((SELECT COUNT(id) FROM photos)/(SELECT COUNT(id) FROM users),2) as photo_posting_avg_time;

create temporary table posts (select user_id,count(*) as no_of_posts from photos group by user_id);
select avg(no_of_posts) from posts;

#Q6)   A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.

	 SELECT tags.id as tag_id, tags.tag_name as tag_name, COUNT(photo_tags.tag_id) as tag_count FROM tags 
     JOIN photo_tags 
     ON tags.id=photo_tags.tag_id 
     GROUP BY tags.id
     ORDER BY tag_count
     DESC LIMIT 5;
     
#Q7)  To find out if there are bots, find users who have liked every single photo on the site.

 SELECT users.id as user_id, users.username as username, COUNT(users.id) as total_likes_by_user FROM users 
 JOIN likes ON users.id=likes.user_id
 GROUP BY users.id 
 HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);
 -- ------------------------------------------------------------------------------------------------
 with cte as
(select user_id,count(user_id) as tl from likes group by user_id having tl =
(select count(distinct id) from photos))
select user_id,username,tl from cte join users u on u.id=cte.user_id ;
 
#Q8)   Find the users who have created instagramid in may and select top 5 newest joinees from it?

        select * from users where monthname(created_at)='May' order by created_at desc limit 5;
        
 #Q9)  Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?

      select distinct u.id,u.username from users u Inner join photos p 
      on u.id=p.user_id Inner join likes l
      on u.id=l.user_id where u.username regexp '^c' and u.username regexp '[0-9]$';
      
    #Q10)   Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
    
    create view user_tposts as
    select user_id,count(user_id) as total_posts from photos group by user_id;
    select * from user_tposts;
    select user_id,username,total_posts from user_tposts ups join users u on ups.user_id=u.id
	where total_posts in (3,4,5) order by total_posts desc limit 30;
 

 
        


