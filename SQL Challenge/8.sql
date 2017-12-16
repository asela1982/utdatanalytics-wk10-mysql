-- 8a. In your new role as an executive, you would like to have an easy way of 
-- viewing the Top five genres by gross revenue. Use the solution from the problem 
-- above to create a view. If you haven't solved 7h, you can substitute another query to create a view.

CREATE VIEW top_five_genres AS
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


-- 8b. How would you display the view that you created in 8a?
SELECT * FROM top_five_genres;

-- 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
DROP VIEW top_five_genres;