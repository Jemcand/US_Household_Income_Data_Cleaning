#US Household Income Project (Data Cleaning)

SELECT *
FROM us_household_income
;
SELECT *
FROM us_statistics
;

ALTER TABLE us_statistics
RENAME COLUMN `ï»¿id` TO `id`
;

SELECT COUNT(id)
FROM us_household_income
;
SELECT COUNT(id)
FROM us_statistics
;
#there's are 234 rows difference after importing. yet still can count on 35526 in statistic
#and 32292 in income

SELECT id, 
COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

SELECT *
FROM
	(SELECT row_id,
	id,
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as Row_Num
	FROM us_household_income) as Duplicates
WHERE Row_Num > 1
;

DELETE FROM us_household_income
WHERE row_id IN 
	(SELECT row_id
	FROM
		(SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as Row_Num
		FROM us_household_income) as Duplicates
	WHERE Row_Num > 1);
    
SELECT id, 
COUNT(id)
FROM us_statistics
GROUP BY id
HAVING COUNT(id) > 1
;
#no duplicates in this table
    
SELECT DISTINCT State_Name
FROM us_household_income
;

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;
UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

SELECT *
FROM us_household_income
WHERE Place = ''
;
SELECT *
FROM us_household_income
WHERE County = 'Autauga County'
;
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

SELECT Type, 
COUNT(Type)
FROM us_household_income
GROUP BY Type
;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

SELECT *
FROM us_household_income
;

SELECT ALand,
AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;







