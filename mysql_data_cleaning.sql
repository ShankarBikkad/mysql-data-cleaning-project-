-- Data Cleaning

USE world_layoffs;
SELECT * FROM layoffs;

-- 1.reomove duplicates 
-- 2.standardise the data 
-- 3.null values or blank values
-- 4.Remove any columns or rows 

CREATE TABLE  layoffs_staging
LIKE layoffs; 

SELECT * FROM  layoffs_staging

INSERT INTO layoffs_staging
SELECT * 
FROM  layoffs;

WITH duplicate_cte AS 
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off ,`date`, stage, country, funds_raised_millions ) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1 ;

SELECT * 
FROM layoffs_staging 
WHERE company = 'Casper' ; 

WITH duplicate_cte AS 
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off , `date`   -- used backtrick identifier (` `)
, stage, country, funds_raised_millions ) AS row_num
FROM layoffs_staging
)
DELETE 
FROM duplicate_cte
WHERE row_num > 1 ;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL , 
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- from layoffs_staging table , create stmt  option from copy to clipboard


SELECT * 
FROM layoffs_staging2 ; 

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry,total_laid_off,percentage_laid_off , `date`   -- used backtick identifier (` `)
, stage, country, funds_raised_millions ) AS row_num
FROM layoffs_staging ;

DELETE 
FROM layoffs_staging2 
WHERE  row_num > 1;

SELECT * 
FROM layoffs_staging2 ;


-- Standardizing data

SELECT company, TRIM(company)
FROM layoffs_staging2 

UPDATE layoffs_staging2 
SET company = TRIM(company) ;

SELECT company
FROM layoffs_staging2 ;

SELECT DISTINCT industry 
FROM layoffs_staging2 
ORDER BY 1;

SELECT *
FROM layoffs_staging2 
WHERE industry LIKE 'Crypto%' ;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%' ;

SELECT * 
FROM layoffs_staging2 ;

SELECT DISTINCT country
FROM layoffs_staging2 
ORDER BY 1 ;

SELECT DISTINCT country , TRIM(TRAILING '.' FROM country ) 
FROM layoffs_staging2 
ORDER BY 1 ;

UPDATE layoffs_staging2 
SET country =  TRIM(TRAILING '.' FROM country ) 
WHERE country LIKE 'United States%' ;

SELECT *
FROM layoffs_staging2 ;

SELECT `date` ,
STR_TO_DATE(`date` , '%m/ %d/ %Y' )
FROM layoffs_staging2 ;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date` , '%m/ %d/ %Y' )

SELECT *
FROM layoffs_staging2 ;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE ;

-- NULL values or blank values (also doned the population 

SELECT *
FROM layoffs_staging2 
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2 
SET industry = NULL 
WHERE industry = ''; 

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL 
OR industry = '';

SELECT * 
FROM layoffs_staging2
WHERE company = 'Airbnb' ;

 SELECT  t1.industry,t2.industry
 FROM layoffs_staging2 t1 
 JOIN layoffs_staging2 t2
	ON t1.company = t2.company 
    AND t1.location = t2.location 
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL ; 

UPDATE layoffs_staging2 t1 
JOIN layoffs_staging2 t2
	ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL ; 

SELECT * 
FROM layoffs_staging2
WHERE company LIKE  'Bally%' ;

SELECT *
FROM layoffs_staging2 
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2 
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

SELECT * 
FROM layoffs_staging2 ; 

-- Remove any columns 

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;























































































