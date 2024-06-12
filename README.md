# Remove Duplicates and Clean Data

This project is designed to help you remove duplicates from your data, standardize the data, handle `NULL` and blank values, and remove unnecessary columns.
This README file provides instructions on how to set up and run the scripts to perform these tasks on your data stored in a Microsoft SQL Server database.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Scripts](#scripts)
  - [Remove Duplicates](#remove-duplicates)
  - [Standardize Data](#standardize-data)
  - [Handle NULL and Blank Values](#handle-null-and-blank-values)
  - [Remove Unnecessary Columns](#remove-unnecessary-columns)
- [Export Data to Excel](#export-data-to-excel)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project includes SQL scripts to clean and standardize data in a SQL Server database. The scripts can:
- Remove duplicate rows.
- Standardize data formats.
- Handle `NULL` and blank values.
- Remove unnecessary columns.
- Export cleaned data to an Excel file.

## Prerequisites

- Microsoft SQL Server
- SQL Server Management Studio (SSMS) or any other SQL client tool

## Setup

1. Clone the repository to your local machine:
   ```sh
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```

2. Open your SQL Server Management Studio (SSMS).

3. Connect to your SQL Server instance.

4. Open and run the provided SQL scripts in SSMS.

## Scripts

### Remove Duplicates

This script removes duplicate rows from the `layoffs_staging` table based on specified columns.

```sql
WITH duplicate_cte AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
            ORDER BY (SELECT NULL)
        ) AS row_num
    FROM layoffs_staging
)
DELETE FROM layoffs_staging
WHERE row_num > 1;
```

### Standardize Data

Standardize the data by ensuring consistent formats.

```sql
-- Example: Convert date column to a standard format
UPDATE layoffs_staging
SET date = CONVERT(DATE, date_column, 101);
```

### Handle NULL and Blank Values

Handle `NULL` and blank values in the `total_laid_off` and `percentage_laid_off` columns.

```sql
UPDATE layoffs_staging
SET industry = NULL
WHERE industry = 'NULL';

SELECT * 
FROM layoffs_staging
WHERE (total_laid_off IS NULL OR total_laid_off = 'NULL')
  AND (percentage_laid_off IS NULL OR percentage_laid_off = 'NULL');
```

### Remove Unnecessary Columns

Remove columns that are not needed for analysis.

```sql
ALTER TABLE layoffs_staging
DROP COLUMN unnecessary_column;
```

## Export Data to Excel

To export the cleaned data to Excel:

1. Open SQL Server Management Studio (SSMS).
2. Connect to your database instance.
3. Right-click on the database containing the `layoffs_staging` table.
4. Navigate to **Tasks > Export Data**.
5. Follow the SQL Server Import and Export Wizard to export the table to an Excel file.



## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

