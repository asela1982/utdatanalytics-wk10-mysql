
-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
-- As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. 
-- Use subqueries to display the titles of movies starting with the letters `K` and `Q` 
-- whose language is English. 

SELECT TITLE 
FROM FILM 
WHERE (TITLE LIKE 'K%' OR TITLE LIKE 'Q%') AND LANGUAGE_ID  
IN(SELECT LANGUAGE_ID FROM LANGUAGE
WHERE NAME='ENGLISH');

-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
   
SELECT ACTOR.ACTOR_ID, ACTOR.FIRST_NAME, ACTOR.LAST_NAME
FROM ACTOR
INNER JOIN           
    (SELECT ACTOR_ID 
     FROM FILM_ACTOR
     WHERE FILM_ID IN 
        (SELECT FILM_ID 
         FROM FILM
         WHERE TITLE = 'ALONE TRIP')) AS TEMP
ON TEMP.ACTOR_ID = ACTOR.ACTOR_ID


-- 7c. You want to run an email marketing campaign in Canada, 
-- for which you will need the names and email addresses of all Canadian customers. 
-- Use joins to retrieve this information.

SELECT FIRST_NAME, LAST_NAME, EMAIL 
FROM CUSTOMER 
WHERE ADDRESS_ID IN (
    SELECT ADDRESS_ID 
    FROM ADDRESS
    WHERE CITY_ID IN 
        (
        SELECT CITY_ID 
        FROM CITY
        WHERE COUNTRY_ID IN 
            (
            SELECT COUNTRY_ID 
            FROM COUNTRY
            WHERE COUNTRY ='CANADA')));

-- 7d. Sales have been lagging among young families, and you wish to 
-- target all family movies for a promotion. Identify all movies categorized as famiy films.

SELECT TITLE 
FROM FILM
WHERE FILM_ID IN (
    SELECT FILM_ID 
    FROM FILM_CATEGORY
    WHERE CATEGORY_ID IN 
        (
         SELECT CATEGORY_ID 
         FROM  CATEGORY
         WHERE NAME = 'FAMILY'))

-- 7e. Display the most frequently rented movies in descending order.
 
SELECT TITLE, SUM(TOTAL_RENTALS) AS TOTAL_RENTALS
FROM 
(SELECT Q.TITLE, TABLE2.FILM_ID, TABLE2.TOTAL_RENTALS AS TOTAL_RENTALS
    FROM FILM Q
    INNER JOIN
        (SELECT I. FILM_ID, TABLE1.INVENTORY_ID AS INVENTORY_ID,TABLE1.TOTAL_RENTALS AS TOTAL_RENTALS
        FROM INVENTORY I
        INNER JOIN
            (SELECT INVENTORY_ID, COUNT(RENTAL_ID) AS TOTAL_RENTALS
            FROM RENTAL 
            GROUP BY INVENTORY_ID) AS TABLE1
        ON I. INVENTORY_ID = TABLE1.INVENTORY_ID) AS TABLE2
    ON Q.FILM_ID = TABLE2.FILM_ID) AS TABLE3
GROUP BY TITLE
ORDER BY TOTAL_RENTALS DESC


-- 7f. Write a query to display how much business, in dollars, each store brought in.


SELECT A.ADDRESS AS STORE_ADDRESS, TABLE2.TOTAL AS TOTAL_AMOUNT
FROM ADDRESS A
INNER JOIN
    (SELECT STORE.ADDRESS_ID, TABLE1.TOTAL AS TOTAL
     FROM STORE
     INNER JOIN
        (SELECT STAFF_ID, SUM(AMOUNT) AS TOTAL
         FROM PAYMENT
         GROUP BY STAFF_ID) TABLE1
    ON STORE.MANAGER_STAFF_ID=TABLE1.STAFF_ID) TABLE2
ON A.ADDRESS_ID = TABLE2.ADDRESS_ID;


-- 7g. Write a query to display for each store its store ID, city, and country.

SELECT TABLE3.STORE_ID, TABLE3.CITY,  CO.COUNTRY
FROM COUNTRY CO
INNER JOIN
    (SELECT TABLE2.STORE_ID, TABLE2.CITY_ID, C.CITY, C.COUNTRY_ID
    FROM CITY C
    INNER JOIN
        (SELECT  TABLE1.STORE_ID, A.CITY_ID
        FROM    ADDRESS A
        INNER JOIN
            (SELECT STORE_ID, ADDRESS_ID 
            FROM STORE) TABLE1
        ON TABLE1.ADDRESS_ID = A.ADDRESS_ID) TABLE2
    ON TABLE2.CITY_ID = C.CITY_ID)TABLE3
ON CO.COUNTRY_ID = TABLE3.COUNTRY_ID;


-- 7h. List the top five genres in gross revenue in descending order. 
-- (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT C.NAME,SUM(TABLE4.TOTAL) AS TOTAL
FROM CATEGORY C
INNER JOIN
    (SELECT F.CATEGORY_ID, TABLE3.FILM_ID, TABLE3.INVENTORY_ID, TABLE3.RENTAL_ID, TABLE3.TOTAL
    FROM  FILM_CATEGORY F
    INNER JOIN
        (SELECT I.FILM_ID, TABLE2.INVENTORY_ID, TABLE2.RENTAL_ID, TABLE2.TOTAL
        FROM INVENTORY I
        INNER JOIN
            (SELECT R.INVENTORY_ID, TABLE1.RENTAL_ID, TABLE1.TOTAL
            FROM  RENTAL R
            INNER JOIN
                (SELECT RENTAL_ID,SUM(AMOUNT) AS TOTAL
                FROM PAYMENT
                GROUP BY RENTAL_ID) TABLE1
            ON TABLE1.RENTAL_ID = R.RENTAL_ID) TABLE2
        ON TABLE2.INVENTORY_ID = I.INVENTORY_ID) TABLE3
    ON TABLE3.FILM_ID = F.FILM_ID) TABLE4
ON TABLE4.CATEGORY_ID = C.CATEGORY_ID
GROUP BY C.NAME
ORDER BY TOTAL DESC
LIMIT 5;


