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

select * from trashbag;

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

DELETE FROM trashbag
WHERE Gallon_Size = '#N/A';

ALTER TABLE trashbag
ALTER COLUMN Gallon_Size TYPE NUMERIC USING Gallon_Size::NUMERIC;

-- 1. size カラムを追加
ALTER TABLE trashbag
ADD COLUMN size TEXT;

-- 2. Gallon_Size に基づいて size カラムを更新
UPDATE trashbag
SET size = CASE
    WHEN Gallon_Size <= 4 THEN 'Small'
    WHEN Gallon_Size <= 8 THEN 'Medium'
    WHEN Gallon_Size <= 13 THEN 'Kitchen Tall'
    WHEN Gallon_Size <= 39 THEN 'Large'
    ELSE 'Extra Large'
END;

DELETE FROM trashbag
WHERE Gallon_Size = 0;
