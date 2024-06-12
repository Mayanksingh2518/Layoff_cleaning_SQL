select * from layoffs;

-- remove duplicates
-- standardize the data
-- Null values and blank values
-- remove any columns


SELECT TOP 0 *
INTO layoffs_staging

FROM layoffs;

insert layoffs_staging 
select * from layoffs;



SELECT *,
    ROW_NUMBER() OVER (PARTITION BY company, industry, total_laid_off, percentage_laid_off, date ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_staging;

with duplicate_cte as
(
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_staging

) 
select *
from duplicate_cte 
where row_num >1;

SELECT company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions, count(*) as cnt
FROM layoffs_staging
GROUP BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
HAVING COUNT(*) > 1;

use prince;

with duplicate_cte as
(
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_staging

) 
select *
from duplicate_cte 
where row_num >1;

select * from layoffs_staging
where company = 'casper';


with duplicate_cte as
(
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_staging

) 

delete from duplicate_cte 
where row_num>1;


with duplicate_cte as
(
SELECT *,
    ROW_NUMBER() OVER (PARTITION BY company,location, industry, total_laid_off, percentage_laid_off, date,stage, country, funds_raised_millions ORDER BY (SELECT NULL)) AS row_num
FROM layoffs_staging

) 
select * from duplicate_cte
where row_num>1;



--standardization

select distinct company 
from layoffs_staging;

update layoffs_staging
set company = TRIM(company);

select company, trim(company)
from layoffs_staging
order by 1;

select distinct industry
from layoffs_staging
order by 1;

select * from layoffs_staging
where industry like 'Crypto%';

update layoffs_staging 
set industry = 'Crypto'
where industry like 'Crypto%';


select distinct industry 
from layoffs_staging order by industry asc;

select distinct location 
from layoffs_staging order by 1 desc;

select distinct country from layoffs_staging
order by 1; 

select * from layoffs_staging 
where country like 'United States%';

use prince;
select * from layoffs_staging;

update layoffs_staging
set country = 'United States ' 
where country like 'United States%' ;

select distinct country 
from layoffs_staging order by 1;

update layoffs_staging
set country = trim (country);

use prince;

select company,date from layoffs_staging;

alter table layoffs_staging 
add Date1 date;

update layoffs_staging
set Date1 = cast(date as date);

alter table layoffs_staging
drop column date;

select * from layoffs_staging;





-- NULL AND BLANK VALUES


select * from layoffs_staging;
select distinct country from layoffs_staging
order by 1;

select distinct industry from layoffs_staging
order by 1;

UPDATE layoffs_staging
SET industry = 'NULL'
WHERE industry IS NULL;


UPDATE layoffs_staging
SET industry = NULL
WHERE industry = 'NULL';

select * from layoffs_staging
where industry is NULL;

select * from layoffs_staging
where company = 'Airbnb';

select t1.industry, t2.industry 
from layoffs_staging t1
join layoffs_staging t2
	on t1.company = t2.company
	AND t1.location = t2.location
where t1.industry is NULL OR t1.industry = ''
AND t2.industry is not NULL;

select * from layoffs_staging
where industry = '';




UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_staging t1
JOIN layoffs_staging t2
  ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
  AND t2.industry IS NOT NULL;
  
select * from layoffs_staging 
order by industry;

select * from layoffs_staging
where company like 'Bally%';

select * from layoffs_staging
where total_laid_off is NULL; 


SELECT * 
FROM layoffs_staging
WHERE total_laid_off IS NULL
  AND (percentage_laid_off IS NULL OR percentage_laid_off = 'NULL');


delete 
FROM layoffs_staging
WHERE total_laid_off IS NULL
  AND (percentage_laid_off IS NULL OR percentage_laid_off = 'NULL');


select * from layoffs_staging;

 



 use prince;