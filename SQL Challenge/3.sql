-- 3A. ADD A `MIDDLE_NAME` COLUMN TO THE TABLE `ACTOR`. 
-- POSITION IT BETWEEN `FIRST_NAME` AND `LAST_NAME`. 
-- HINT: YOU WILL NEED TO SPECIFY THE DATA TYPE.
  	
USE SAKILA;

ALTER TABLE ACTOR 
ADD COLUMN MIDDLE_NAME VARCHAR(45) AFTER FIRST_NAME;


-- 3B. YOU REALIZE THAT SOME OF THESE ACTORS HAVE TREMENDOUSLY LONG LAST NAMES. 
-- CHANGE THE DATA TYPE OF THE `MIDDLE_NAME` COLUMN TO `BLOBS`.

ALTER TABLE ACTOR MODIFY MIDDLE_NAME BLOB;


-- 3C. NOW DELETE THE `MIDDLE_NAME` COLUMN.

ALTER TABLE ACTOR DROP COLUMN MIDDLE_NAME;