# SQL_Carbon_emission_project2
# Carbon Emission Analysis SQL Project

## Project Overview

**Project Title**: Carbon Emission Analysis  
**Level**: Beginner  
**Database**: `sql_priject_p2`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a carbon emission database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL. This project is done with MySQL Workbench

## Objectives

1. **Set up a carbon emission database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure
**CREATE DATABASE sql_project_p2;**
```sql
	CREATE DATABASE sql_project_p2;
```
**Create a table with all the coloumns present in the data**
```sql
CREATE TABLE carbon_emission 
	( 
		id VARCHAR(1000),	
        year INT,	
        company VARCHAR(1000),	
        country VARCHAR(1000),	
        industry_group VARCHAR(1000),	
        weight_kg FLOAT,	
        carbon_footprint_pcf FLOAT,	
        upstream_percent_total_pcf VARCHAR(1000),	
        operations_percent_total_pcf VARCHAR(1000),	
        downstream_percent_total_pcf VARCHAR(1000)
	)
```
**DATA exploration**
Checking wheather all the data is correctly imported or not
```sql
SELECT *
FROM carbon_emission
LIMIT 5;
```
Cheking number of entries in our data 
```sql
SELECT COUNT(*)
FROM carbon_emission
```
Checking IDs containing insufficient data i.e. NULL values
```sql
SELECT *
FROM carbon_emission
WHERE (
		upstream_percent_total_pcf IS NULL OR
        operations_percent_total_pcf IS NULL OR
        downstream_percent_total_pcf IS NULL
	  );
```
Deleting data with NULL values
```sql
SET SQL_SAFE_UPDATES = 0;
DELETE
FROM carbon_emission
WHERE (
		upstream_percent_total_pcf IS NULL OR
        operations_percent_total_pcf IS NULL OR
        downstream_percent_total_pcf IS NULL
	  );
SET SQL_SAFE_UPDATES = 1;
```
DATA count after removing NULL values
```sql
SELECT COUNT(*)
FROM carbon_emission
 ```
DATA Analysis

1. **What are the top 5 companies with the highest carbon footprint?**  
```sql
SELECT 
		company,
        ROUND(SUM(carbon_footprint_pcf), 2) AS carbon_footprint_pcf,
        count(*)
FROM carbon_emission
GROUP BY company, carbon_footprint_pcf
ORDER BY carbon_footprint_pcf DESC
LIMIT 5;
```
2. **How have carbon emissions changed over time for different companies and industries?**
```sql
SELECT 	
        company,
        `year`,
        industry_group,
		ROUND(SUM(weight_kg), 2) AS weight_kg,
        ROUND(SUM(carbon_footprint_pcf), 2) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY `year`, company, industry_group
ORDER BY company, industry_group
```
3. **Which countries have the highest total carbon footprint based on company-level data?** 
```sql
SELECT 
		country,
        ROUND(SUM(carbon_footprint_pcf)) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY country
ORDER BY carbon_footprint_pcf DESC
```
4. **What percentage of total emissions comes from upstream, operations, and downstream activities for each company?**
```sql
SELECT 
		company,
		ROUND(AVG(upstream_percent_total_pcf), 2) AS upstream_percent_total_pcf,
        ROUND(AVG(operations_percent_total_pcf), 2) AS operation_percent_total_pcf,
        ROUND(AVG(downstream_percent_total_pcf), 2) AS downstream_percent_total_pcf
FROM carbon_emission
GROUP BY company
ORDER BY company
```
5. **Which companies have the highest upstream emissions as a percentage of their total footprint?**
```sql
SELECT 
		company,
        ROUND(AVG(upstream_percent_total_pcf), 2) AS upstream_percent_total_pcf
FROM carbon_emission
GROUP BY company
ORDER BY upstream_percent_total_pcf DESC
```
6. **What is the average carbon footprint per industry group?**
```sql
SELECT 
	industry_group,
    ROUND(AVG(carbon_footprint_pcf), 2) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY industry_group
ORDER BY carbon_footprint_pcf DESC
```
7. **How do emissions from different industries compare over the years?**
```sql
SELECT 
	`year`,
    industry_group,
    ROUND(SUM(carbon_footprint_pcf), 2) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY industry_group, `year`
ORDER BY industry_group, `year`
```
8. **What is the total weight(kg) associated with the highest carbon-emitting companies?**
```sql
SELECT 
	company,
    SUM(weight_kg) AS weight_kg
FROM carbon_emission
GROUP BY company
ORDER BY weight_kg DESC
```
9. **Which countries have the highest emissions per company?**
```sql
SELECT 
	country,
    company,
    SUM(carbon_footprint_pcf) AS carbon_footprint_pcf 
FROM carbon_emission
GROUP BY country, company, carbon_footprint_pcf 
ORDER BY country 
```
## Findings

- **Company Demographics**: The dataset includes companies with different carbon footprints with country-wise data.
- **High-level Carbon Emission**: Several countries had a total carbon footprint greater than 100,000, indicating high carbon emissions.
- **Carbon Emission Trends**: It has been observed that carbon emission keeps increasing as the years passes.
- **Major Contributors**: The analysis identifies that the 'Automobile & components' and 'Pharmaceuticals, Biotechnology & Life Science' are the major contributors of carbon_footprint_pcf in the world.

## Reports

- **Carbon emission Summary**: A detailed report summarizing total carbon emission, company-wise analysis, and category performance.
- **Trend Analysis**: Insights into increasing carbon footprint year on year.
- **Emission Report**: Carbon emission Reports on each company's upstream, operations, and downstream activities.

## Conclusion

This project is a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding carbon emission patterns and the company's operations.

## Author - Nikhil Dagale

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, or feedback, or would like to collaborate, feel free to get in touch!

