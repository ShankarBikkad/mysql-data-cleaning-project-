# MySQL Data Cleaning Project – Global Layoffs

A beginner-friendly data cleaning project in **MySQL**. I took a raw layoffs dataset and cleaned it step by step so it is ready for analysis.

## Dataset
- **File:** `layoffs.csv` (about 2,360 rows)
- **Columns:** company, location, industry, total laid off, percentage laid off, date, stage, country, funds raised (millions)

## What I Did
1. **Made a staging table** – copied the raw data into a new table so the original data stays safe.
2. **Removed duplicates** – used `ROW_NUMBER()` with a CTE to find repeated rows and deleted them.
3. **Standardized the data**
   - Removed extra spaces from company names (`TRIM`)
   - Merged similar industry names (for example, all "Crypto..." names became "Crypto")
   - Fixed country names with a trailing dot (for example, "United States.")
   - Changed the `date` column from text to a proper `DATE` type
4. **Handled blank and NULL values** – set blanks to `NULL`, then filled missing industries using other rows of the same company (self `JOIN`).
5. **Removed unnecessary data** – deleted rows with no layoff information and dropped the helper column.

## Skills Used
`SELECT` • `UPDATE` • `DELETE` • `ALTER TABLE` • CTE • Window function (`ROW_NUMBER`) • `JOIN` • `TRIM` • `STR_TO_DATE`

## Files
| File | Description |
|---|---|
| `layoffs.csv` | Raw dataset |
| `mysql_data_cleaning.sql` | All cleaning queries |

## Result
A clean and consistent dataset with no duplicates, standard names, correct date format and fewer missing values, ready for analysis.

## Credit
Guided project followed from this tutorial: https://youtu.be/4UltKCnnnTA
