-- #1 --
-- List the films where the yr is 1962 [Show id, title]
SELECT id, title 
FROM movie
WHERE yr = 1962;
-- #2 --
-- Give year of 'Citizen Kane'
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';
-- #3 --
/*
-- List all of Star Trek movies, include the id, title and yr 
-- (all of these movies include the words Star Trek in the title). Order result by year.
*/
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;
-- #4 --
-- What id number does the actor 'Glenn Close have ?'
SELECT id
FROM actor
WHERE name = 'Glenn Close';
-- #5 --
-- What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';
-- #6 --
/*
-- Obtain the cast list for 'Casablanca'
-- Use movieid = 11768 or whatever value you got from the pervious question )
*/
SELECT name
FROM actor , casting 
WHERE id = actorid
AND movieid = (SELECT id FROM movie WHERE title = 'Casablanca');
-- #7 --
-- Obtain the cast list for the film 'Alien'
SELECT name
FROM actor
JOIN casting 
ON (id = actorid AND movieid = (SELECT id FROM movie WHERE title = 'Alien'));
-- #8 --
-- List the films in which 'Harrison Ford' has appeared
SELECT title 
FROM movie 
JOIN casting ON (id = matchid AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford'));
-- #9 --
/*
-- List the films where 'Harrison Ford has appeared' but no in the starring role.
-- the ord field of casting gives the positon of the actor. if ord =1 then this actor is in the starring role.
*/
SELECT title
FROM movie
JOIN casting ON (id = movieid AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord != 1);
-- #10 --
-- List the films together with the leading star for all 1962 films
SELECT title, name
FROM movie JOIN casting ON (id = movieid)
JOIN actor on (actor.id = actorid)
WHERE ord = 1 AND yr = 1962;
-- #11 --
/*
Which were the busiest years for 'Rock Hudson' show the year and the number of movies
he made each year in which he made more than 2 movies
*/
SELECT yr,COUNT (title)
FROM movie JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE name = 'Rock Hudson' 
GROUP BY yr 
HAVING COUNT (title) > 1;
-- #12 -- 
/*
List the film title and the leading actor for all of the films 'Julie Andrews' played in
*/
SELECT title, name 
    FROM movie
        JOIN casting x ON movie.id = movieid
        JOIN actor ON actor.id = actor.id
    WHERE ord = 1 AND movieid IN 
    (SELECT movieid FROM casting y 
        JOIN actor ON actor.id = actor.id 
        WHERE name = 'Julie Andrews');
-- #13 --
/*
Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
*/
SELECT name
FROM actor
  JOIN casting ON (id = actorid AND 
     (SELECT COUNT(ord) FROM casting WHERE actorid = actor.id AND ord = 1 )>= 15)
GROUP BY name;
-- #14 --
/*
List the films released in the year 1978 ordered by the number of actors in the cast, then by title
*/
SELECT title, COUNT(actorid) AS cast
FROM movie 
JOIN casting on id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast DESC, title ASC;
-- #15 --
/*
List all the people who have worked with 'Art Garfunkel'
*/
SELECT DISTINCT name
FROM actor JOIN casting ON id=actorid
WHERE movieid IN (SELECT movieid FROM casting JOIN actor ON (actorid=id AND name='Art Garfunkel')) AND name != 'Art Garfunkel'
GROUP BY name