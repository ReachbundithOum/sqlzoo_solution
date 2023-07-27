-- Change the query shown so that it displays Nobel prizes for 1950.
--#1/
    SELECT yr, subject, winner
    FROM nobel
    WHERE yr = 1950
-- Show who won the 1962 prize for literature.
--#2/
    SELECT winner
    FROM nobel
    WHERE yr = 1962
    AND subject = 'literature';
-- Show the year and subject that won 'Albert Einstein' his prize.
--#3/
    SELECT yr,subject
    FROM nobel
    where yr = 1921 AND
    subject = 'physics';
-- Give the name of the 'peace' winners since the year 2000, including 2000.
--#4/
    SELECT winner
    FROM nobel
    WHERE subject = 'peace'
    AND yr >= 2000;
-- Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.
--#5/
    SELECT *
    FROM nobel
    WHERE subject = 'literature'
    AND yr BETWEEN 1980 AND 1989;
-- Show all details of the presidential winners:
-- Theodore Roosevelt
-- Thomas Woodrow Wilson
-- Jimmy Carter
-- Barack Obama
--#6/
    SELECT * FROM nobel
    WHERE winner IN ('Theodore Roosevelt',
                    'Woodrow Wilson',
                    'Jimmy Carter',
                    'Barack Obama');
-- Show the winners with first name John
--#7/
    SELECT winner
    FROM nobel
    WHERE winner like 'John%';
-- Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.
--#8/ 
    SELECT * 
    FROM nobel
    WHERE (subject = 'Physics' AND yr = '1980')
    OR (subject = 'Chemistry' AND yr = '1984');
-- Show the year, subject, and name of winners for 1980 excluding chemistry and medicine
--#9/
    SELECT *
    FROM nobel
    WHERE yr = 1980 AND subject NOT IN ('Chemistry','Medicine');
-- Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)
--#10/
    SELECT *
    FROM nobel
    WHERE (subject = 'Medicine' AND yr < 1910)
    OR (subject = 'Literature' AND yr >= 2004);
-- Find all details of the prize won by PETER GRÜNBERG
--#11/
    SELECT *
    FROM nobel
    WHERE winner LIKE 'peter gr%';
-- Find all details of the prize won by EUGENE O'NEILL
--#12/
    SELECT *
    FROM nobel
    WHERE winner LIKE 'eugene o%';
Knights in order

-- List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.
--#13/
    SELECT winner,yr,subject
    FROM nobel
    WHERE winner LIKE 'sir%'
    ORDER BY yr DESC, winner;
-- The expression subject IN ('chemistry','physics') can be used as a value - it will be 0 or 1.
-- Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.
    SELECT winner,subject
    from nobel
    where yr = 1984
    ORDER BY 
    case when subject IN 
    ('physics','Chemistry')
    then 1 else 0 end ,subject,winner