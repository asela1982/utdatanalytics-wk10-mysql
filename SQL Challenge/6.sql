
-- 6A. USE `JOIN` TO DISPLAY THE FIRST AND LAST NAMES, AS WELL AS THE ADDRESS, OF EACH STAFF MEMBER. 
-- USE THE TABLES `STAFF` AND `ADDRESS`:
USE SAKILA;

SELECT S.FIRST_NAME, S.LAST_NAME, A.ADDRESS
FROM STAFF S
INNER JOIN ADDRESS  A
ON S.ADDRESS_ID = A.ADDRESS_ID;

-- 6B. USE `JOIN` TO DISPLAY THE TOTAL AMOUNT RUNG UP BY EACH STAFF MEMBER IN AUGUST OF 2005. 
-- USE TABLES `STAFF` AND `PAYMENT`. 
  	
SELECT STABLE.FIRST_NAME,STABLE.LAST_NAME,SUMMARY.TOTAL_PAYMENTS
FROM STAFF as STABLE
INNER JOIN 
    (SELECT S.STAFF_ID, SUM(P.AMOUNT) AS TOTAL_PAYMENTS
    FROM STAFF AS S
    INNER JOIN PAYMENT P
    ON S.STAFF_ID = P.STAFF_ID
    WHERE P.PAYMENT_DATE >='2005-08-01 00:00:00'
    AND P.PAYMENT_DATE <'2005-09-01 00:00:00'
    GROUP BY S.STAFF_ID) as SUMMARY
ON STABLE.STAFF_ID = SUMMARY.STAFF_ID;

-- 6C. LIST EACH FILM AND THE NUMBER OF ACTORS WHO ARE LISTED FOR THAT FILM. 
-- USE TABLES `FILM_ACTOR` AND `FILM`. USE INNER JOIN.

SELECT F.TITLE, COUNT(FA.ACTOR_ID) AS NUMBER_OF_ACTORS
FROM FILM F
INNER JOIN FILM_ACTOR FA
ON F.FILM_ID = FA.FILM_ID
GROUP BY F.TITLE;

-- 6D. HOW MANY COPIES OF THE FILM `HUNCHBACK IMPOSSIBLE` EXIST IN THE INVENTORY SYSTEM?

SELECT COUNT(INVENTORY_ID) AS NUMBER_OF_COPIES
FROM INVENTORY 
WHERE FILM_ID IN (SELECT FILM_ID FROM FILM 
WHERE TITLE = 'HUNCHBACK IMPOSSIBLE');

-- 6E. USING THE TABLES `PAYMENT` AND `CUSTOMER` AND THE `JOIN` COMMAND, 
-- LIST THE TOTAL PAID BY EACH CUSTOMER. LIST THE CUSTOMERS ALPHABETICALLY BY LAST NAME:

SELECT CUS.FIRST_NAME, CUS.LAST_NAME,SUMMARY.TOTAL AS TOTAL_AMOUNT_PAID
FROM CUSTOMER CUS
INNER JOIN
    (SELECT C.CUSTOMER_ID, SUM(P.AMOUNT) TOTAL
    FROM PAYMENT P
    INNER JOIN CUSTOMER C
    ON P.CUSTOMER_ID = C.CUSTOMER_ID
    GROUP BY C.CUSTOMER_ID) SUMMARY
ON SUMMARY.CUSTOMER_ID = CUS.CUSTOMER_ID
ORDER BY TOTAL_AMOUNT_PAID DESC

  ```
  	![TOTAL AMOUNT PAID](IMAGES/TOTAL_PAYMENT.PNG)
  ```
