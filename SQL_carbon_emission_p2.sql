-- CREATE DATABASE sql_project_p2;

-- Create a table with all the coloumns present in the data
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
    
-- DATA exploration
-- 1. Checking wheather all the data is correctly imported or not

SELECT *
FROM carbon_emission
LIMIT 5;

-- Cheking number of entries in our data 

SELECT COUNT(*)
FROM carbon_emission

-- Checking IDs containing insufficient data i.e. NULL values

SELECT *
FROM carbon_emission
WHERE (
		upstream_percent_total_pcf IS NULL OR
        operations_percent_total_pcf IS NULL OR
        downstream_percent_total_pcf IS NULL
	  );

-- Deleting data with NULL values

SET SQL_SAFE_UPDATES = 0;
DELETE
FROM carbon_emission
WHERE (
		upstream_percent_total_pcf IS NULL OR
        operations_percent_total_pcf IS NULL OR
        downstream_percent_total_pcf IS NULL
	  );
SET SQL_SAFE_UPDATES = 1;

-- DATA count after removing NULL values

SELECT COUNT(*)
FROM carbon_emission
 
-- DATA Analysis

-- 1. **What are the top companies with the highest carbon footprint?**  
-- 2. **How have carbon emissions changed over time for different companies and industries?**  
-- 3. **Which countries have the highest total carbon footprint based on company-level data?**  
-- 4. **What is the relationship between weight (kg) and carbon footprint (pcf)?**  
-- 5. **How does the carbon footprint distribution vary across different industry groups?**  
-- 6. **What percentage of total carbon emissions come from upstream, operations, and downstream activities?**  
-- 7. **Which companies have the highest upstream, operations, and downstream emissions as a percentage of their total footprint?**  
-- 8. **Are there trends in industry groups where upstream or downstream emissions dominate?**  
-- 9. **How do emissions differ between companies in the same industry group but in different countries?**  
-- 10. **Which industries or companies have shown improvement (reduction in carbon footprint) over time?**  

-- 1. **What are the top 5 companies with the highest carbon footprint?**  

SELECT 
		company,
        ROUND(SUM(carbon_footprint_pcf), 2) AS carbon_footprint_pcf,
        count(*)
FROM carbon_emission
GROUP BY company, carbon_footprint_pcf
ORDER BY carbon_footprint_pcf DESC
LIMIT 5;

-- 2. **How have carbon emissions changed over time for different companies and industries?**

SELECT 	
        company,
        `year`,
        industry_group,
		ROUND(SUM(weight_kg), 2) AS weight_kg,
        ROUND(SUM(carbon_footprint_pcf), 2) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY `year`, company, industry_group
ORDER BY company, industry_group

-- 3. **Which countries have the highest total carbon footprint based on company-level data?** 

SELECT 
		country,
        ROUND(SUM(carbon_footprint_pcf)) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY country
ORDER BY carbon_footprint_pcf DESC

-- 4. **What percentage of total emissions comes from upstream, operations, and downstream activities for each company?**

SELECT 
		company,
		ROUND(AVG(upstream_percent_total_pcf), 2) AS upstream_percent_total_pcf,
        ROUND(AVG(operations_percent_total_pcf), 2) AS operation_percent_total_pcf,
        ROUND(AVG(downstream_percent_total_pcf), 2) AS downstream_percent_total_pcf
FROM carbon_emission
GROUP BY company
ORDER BY company

-- 5. **Which companies have the highest upstream emissions as a percentage of their total footprint?**

SELECT 
		company,
        ROUND(AVG(upstream_percent_total_pcf), 2) AS upstream_percent_total_pcf
FROM carbon_emission
GROUP BY company
ORDER BY upstream_percent_total_pcf DESC

-- 6. **What is the average carbon footprint per industry group?**

SELECT 
	industry_group,
    ROUND(AVG(carbon_footprint_pcf), 2) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY industry_group
ORDER BY carbon_footprint_pcf DESC

-- 7. **How do emissions from different industries compare over the years?**

SELECT 
	`year`,
    industry_group,
    ROUND(SUM(carbon_footprint_pcf), 2) AS carbon_footprint_pcf
FROM carbon_emission
GROUP BY industry_group, `year`
ORDER BY industry_group, `year`

-- 8. **What is the total weight(kg) associated with the highest carbon-emitting companies?**

SELECT 
	company,
    SUM(weight_kg) AS weight_kg
FROM carbon_emission
GROUP BY company
ORDER BY weight_kg DESC

-- 9. **Which countries have the highest emissions per company?**

SELECT 
	country,
    company,
    SUM(carbon_footprint_pcf) AS carbon_footprint_pcf 
FROM carbon_emission
GROUP BY country, company, carbon_footprint_pcf 
ORDER BY country 