-- create table
CREATE TABLE trashbag (
    Location TEXT,
    SKU TEXT,
    Brand TEXT,
    Title TEXT,
    Gallon_Size TEXT,
    Category TEXT,
    WeekId INTEGER,
    Retail_Sales NUMERIC,
    Units_Sold INTEGER,
    Average_Selling_Price NUMERIC
);



-- chenge data type
ALTER TABLE trashbag
ADD COLUMN year INTEGER;

UPDATE trashbag
SET year = CAST(SUBSTRING(weekid::TEXT FROM 1 FOR 4) AS INTEGER);

ALTER TABLE trashbag
ADD COLUMN month INTEGER;

UPDATE trashbag
SET month = CAST(SUBSTRING(weekid::TEXT FROM 5 FOR 6) AS INTEGER);

ALTER TABLE trashbag
ADD COLUMN size TEXT;



-- delete unnecessary cell
DELETE FROM trashbag
WHERE Gallon_Size = '#N/A';

ALTER TABLE trashbag
ALTER COLUMN Gallon_Size TYPE NUMERIC USING Gallon_Size::NUMERIC;

ALTER TABLE trashbag
ADD COLUMN size TEXT;



-- Add size column for easy categorizing sizes
UPDATE trashbag
SET size = CASE
    WHEN Gallon_Size <= 4 THEN 'Small'
    WHEN Gallon_Size <= 8 THEN 'Medium'
    WHEN Gallon_Size <= 13 THEN 'Kitchen Tall'
    WHEN Gallon_Size <= 39 THEN 'Large'
    ELSE 'Extra Large'
END;



-- delete unnecessary cell
DELETE FROM trashbag
WHERE Gallon_Size = 0;
