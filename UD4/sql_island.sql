############## SQL ISLAND ########################
-- https://datalemur.com/blog/sql-island-in-english-answers
-- 1 It seems there are a few people living in these villages. How can I see a list of all inhabitants?
select * from inhabitant;
-- 2 Thank you, Edward! Okay, let's see who is friendly on this island...
select * from inhabitant where state='friendly';
-- 3 I will now try to find a friendly weaponsmith to forge me one.
select * from inhabitant where state='friendly' and job ='weaponsmith';
-- 4 Oh, that does not look good. Maybe other friendly smiths can help you out, e.g. a blacksmith. Try out: job LIKE '%smith' to find all inhabitants whose job ends with 'smith' (% is a wildcard for any number of characters)
select * from inhabitant where state='friendly' and job like'%smith';
-- 5 No need to call me stranger! What's my personid? (Hint: Use a SELECT query without an asterisk. In former queries, the * stands for: all columns. Instead of the star, you can also address one or more columns (seperated by a comma) and you will only get the columns you need.)
select personid from  inhabitant where name = 'Stranger';
-- 6 I can offer to make you a sword for 150 gold. That's the cheapest you will find! How much gold do you have?
select gold from  inhabitant where name = 'Stranger';
-- 7 Damn! No mon, no fun. There has to be another option to earn gold other than going to work. Maybe I could collect ownerless items and sell them! Can I make a list of all items that don't belong to anyone? (Hint: You can recognize ownerless items by: WHERE owner IS NULL)
select * from item WHERE owner IS NULL;
-- 8 Do you know a trick how to collect all the ownerless items?
UPDATE item SET owner = 20 WHERE owner IS NULL;
-- 9. Now list all of the items I have!
select * from item where owner=20;
-- 10. Find a friendly inhabitant who is either a dealer or a merchant. Maybe they want to buy some of my items. (Hint: When you use both AND and OR, don't forget to put brackets correctly!)
select * from INHABITANT where state='friendly'
and (job='dealer' or job='merchant');
-- 11. I'd like to get the ring and the teapot. The rest is nothing but scrap. Please give me the two items. My personid is 15.
UPDATE item SET owner = 15 WHERE item = 'ring' or item='teapot';
-- 12. Since baking is one of my hobbies, why not find a baker who I can work for? (Hint: List all bakers and use 'ORDER BY gold' to sort the results. 'ORDER BY gold DESC' is even better because then the richest baker is on top.)
select * from INHABITANT where job='baker' order by gold desc;
-- 13. Is there a pilot on this island by any chance? He could fly me home.
select * from INHABITANT where job='pilot';
-- #INNER JOIN
-- 14. Thanks for the hint! I can use the join to find out the chief's name of the village Onionville. (Hint: In the column 'chief' in the village table, the personid of the chief is stored)
select INHABITANT.name from INHABITANT inner join VILLAGE on INHABITANT.personid = VILLAGE.chief where village.name='Onionville';
-- 15.Hello %%%PLAYER_NAME%%%, the pilot is held captive by Dirty Dieter in his sister's house. Shall I tell you how many women there are in Onionville? Nah, you can figure it out by yourself! (Hint: Women show up as gender = 'f')
select count(*) from INHABITANT inner join VILLAGE on INHABITANT.villageid = VILLAGE.villageid where village.name='Onionville' and INHABITANT.gender='f';
-- 16. Oh, only one woman. What's her name?
select INHABITANT.name from INHABITANT inner join VILLAGE on INHABITANT.villageid = VILLAGE.villageid where village.name='Onionville' and INHABITANT.gender='f';
-- 17. Oh no, baking bread alone can't solve my problems. 
-- If I continue working and selling items though, I could earn more gold than the worth of gold inventories of all bakers, 
-- dealers and merchants together. How much gold is that?
SELECT SUM(inhabitant.gold) 
FROM inhabitant 
WHERE job = "baker" 
OR job = "dealer" 
OR job = "merchant";
-- 18. Very interesting: For some reason, butchers own the most gold. How much gold do different inhabitants have on average, depending on their state (friendly, ...)?
SELECT state, AVG(inhabitant.gold) 
FROM inhabitant 
GROUP BY state 
ORDER BY AVG(inhabitant.gold);

-- 19. Diane
DELETE FROM inhabitant 
WHERE name = "Dirty Diane";

-- 20. Yeah! Now I release the pilot!
UPDATE inhabitant 
SET state = "friendly"
WHERE state = "kidnapped";



