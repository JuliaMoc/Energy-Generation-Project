-- Create a table 
CREATE TABLE renewable_energy (
	ObjectId int PRIMARY KEY,
	Country VARCHAR (255),
	ISO2 VARCHAR (50),
	ISO3 VARCHAR (100),
	Indicator VARCHAR (100),	
	Technology VARCHAR (100),
	Energy_Type	VARCHAR (100),
	Unit VARCHAR (100),
	Source VARCHAR (500),
	CTS_Name VARCHAR (100),	
	CTS_Code VARCHAR (100),	
	CTS_Full_Descriptor VARCHAR (100),
	F2000 float,
	F2001 float,
	F2002 float,	
	F2003 float,	
	F2004 float,	
	F2005 float,
	F2006 float,
	F2007 float,
	F2008 float,
	F2009 float,
	F2010 float,
	F2011 float,
	F2012 float,
	F2013 float,	
	F2014 float,	
	F2015 float,
	F2016 float,
	F2017 float,
	F2018 float,
	F2019 float,
	F2020 float,
	F2021 float,
	F2022 float,
	F2023 float
)

-- Check table
select*
from renewable_energy;

-- Delete columns that are not neccessary for the analysis
ALTER TABLE renewable_energy
DROP COLUMN source,
DROP COLUMN cts_name,
DROP COLUMN cts_code,
DROP COLUMN cts_full_descriptor;

-- Check for null values
SELECT *
FROM renewable_energy
WHERE iso2 is null;

-- Change null values to 0
UPDATE renewable_energy
SET F2000 = '0'
WHERE F2000 is null;

UPDATE renewable_energy
SET F2001 = '0'
WHERE F2001 is null;

UPDATE renewable_energy
SET F2002 = '0'
WHERE F2002 is null;

UPDATE renewable_energy
SET F2003 = '0'
WHERE F2003 is null;

UPDATE renewable_energy
SET F2004 = '0'
WHERE F2004 is null;

UPDATE renewable_energy
SET F2005 = '0'
WHERE F2005 is null;

UPDATE renewable_energy
SET F2006 = '0'
WHERE F2006 is null;

UPDATE renewable_energy
SET F2007 = '0'
WHERE F2007 is null;

UPDATE renewable_energy
SET F2008 = '0'
WHERE F2008 is null;

UPDATE renewable_energy
SET F2009 = '0'
WHERE F2009 is null;

UPDATE renewable_energy
SET F2010 = '0'
WHERE F2010 is null;

UPDATE renewable_energy
SET F2011 = '0'
WHERE F2011 is null;

UPDATE renewable_energy
SET F2012 = '0'
WHERE F2012 is null;

UPDATE renewable_energy
SET F2013 = '0'
WHERE F2013 is null;

UPDATE renewable_energy
SET F2014 = '0'
WHERE F2014 is null;

UPDATE renewable_energy
SET F2015 = '0'
WHERE F2015 is null;

UPDATE renewable_energy
SET F2016 = '0'
WHERE F2016 is null;

UPDATE renewable_energy
SET F2017 = '0'
WHERE F2017 is null;

UPDATE renewable_energy
SET F2018 = '0'
WHERE F2018 is null;

UPDATE renewable_energy
SET F2019 = '0'
WHERE F2019 is null;

UPDATE renewable_energy
SET F2020 = '0'
WHERE F2020 is null;

UPDATE renewable_energy
SET F2021 = '0'
WHERE F2021 is null;

UPDATE renewable_energy
SET F2022 = '0'
WHERE F2022 is null;

UPDATE renewable_energy
SET F2023 = '0'
WHERE F2023 is null;

UPDATE renewable_energy
SET iso2 = ''
WHERE iso2 is null;

-- Merge all years to have the total consumption per year and country
SELECT *,
	(f2000 + f2001 + f2003 + f2004 + f2005 + f2006 + f2007 + f2008 + f2009 + f2010 + f2011 + f2012 + f2013 + f2014 + f2015 + f2016 + f2017 + f2018 + f2019 + f2020 + f2021 + f2022 + f2023) AS total_years
FROM renewable_energy;

-- Add the new column
ALTER TABLE renewable_energy
ADD COLUMN total_years float;

UPDATE renewable_energy
SET total_years = f2000 + f2001 + f2003 + f2004 + f2005 + f2006 + f2007 + f2008 + f2009 + f2010 + f2011 + f2012 + f2013 + f2014 + f2015 + f2016 + f2017 + f2018 + f2019 + f2020 + f2021 + f2022 + f2023;

-- Delete Megawatt (MW) from column unit
DELETE FROM renewable_energy
WHERE unit = 'Megawatt (MW)';

-- Find out the consumption of energy_type and technology by country 
SELECT 
	country, 
	total_years,
	energy_type,
	technology,
	RANK () OVER (PARTITION BY technology ORDER BY total_years DESC) AS consumption_by_counrty
FROM renewable_energy;

-- Find out the MAX consumption by country
SELECT *
FROM (
	SELECT 
		country,
		energy_type,
		total_years,
		technology,
		MAX (total_years) OVER (PARTITION BY technology ORDER BY total_years DESC) AS highest_consumption
	FROM renewable_energy
)t WHERE total_years = highest_consumption;

-- Avg. consumption
SELECT AVG(total_years) AS avg_consumption
FROM renewable_energy;

-- Avg. consumption by technology
SELECT 
	technology, AVG(total_years) AS avg_by_technology
FROM renewable_energy
GROUP BY technology;

-- -- Create 3 categories: high, medium, low consumption
SELECT *,
CASE WHEN category = 1 THEN 'High Consumption'
	 WHEN category = 2 THEN 'Medium Consumption'
	 WHEN category = 3 THEN 'Low Consumption'
END AS consumption_categories
FROM (
	SELECT
		country,
		total_years,
		NTILE(3) OVER (ORDER BY total_years DESC) AS category
	FROM renewable_energy
)t;

-- Highest 10% of consumption per country
SELECT *,
CONCAT (top_10 * 100, '%') AS top_10_percentage
FROM (
	SELECT
		country,
		total_years,
		CUME_DIST() OVER (ORDER BY total_years DESC) AS top_10
	FROM renewable_energy
)t WHERE top_10 <= 0.1;

-- UNION all f2000 until f2023 columns for more calculations and a deeper insight
SELECT *,
	'2000':: INTEGER AS year,
	f2000 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2001':: INTEGER AS year,
	f2001 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2002':: INTEGER AS year,
	f2002 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2003':: INTEGER AS year,
	f2003 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2004':: INTEGER AS year,
	f2004 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2005':: INTEGER AS year,
	f2005 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2006':: INTEGER AS year,
	f2006 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2007':: INTEGER AS year,
	f2007 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2008':: INTEGER AS year,
	f2008 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2009':: INTEGER AS year,
	f2009 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2010':: INTEGER AS year,
	f2010 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2011':: INTEGER AS year,
	f2011 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2012':: INTEGER AS year,
	f2012 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2013':: INTEGER AS year,
	f2013 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2014':: INTEGER AS year,
	f2014 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2015':: INTEGER AS year,
	f2015 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2016':: INTEGER AS year,
	f2016 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2017':: INTEGER AS year,
	f2017 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2018':: INTEGER AS year,
	f2018 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2019':: INTEGER AS year,
	f2019 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2020':: INTEGER AS year,
	f2020 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2021':: INTEGER AS year,
	f2021 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2022':: INTEGER AS year,
	f2022 AS value
FROM renewable_energy
UNION ALL
SELECT *,
	'2023':: INTEGER AS year,
	f2023 AS value
FROM renewable_energy;

-- Normalize data
	CREATE TABLE normalized_energy_data AS
	WITH unpivoted_data AS (
		SELECT *,
			'2000':: INTEGER AS year,
			f2000 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2001':: INTEGER AS year,
			f2001 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2002':: INTEGER AS year,
			f2002 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2003':: INTEGER AS year,
			f2003 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2004':: INTEGER AS year,
			f2004 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2005':: INTEGER AS year,
			f2005 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2006':: INTEGER AS year,
			f2006 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2007':: INTEGER AS year,
			f2007 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2008':: INTEGER AS year,
			f2008 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2009':: INTEGER AS year,
			f2009 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2010':: INTEGER AS year,
			f2010 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'20011':: INTEGER AS year,
			f2011 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2012':: INTEGER AS year,
			f2012 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2013':: INTEGER AS year,
			f2013 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2014':: INTEGER AS year,
			f2014 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2015':: INTEGER AS year,
			f2015 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2016':: INTEGER AS year,
			f2016 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2017':: INTEGER AS year,
			f2017 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2018':: INTEGER AS year,
			f2018 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2019':: INTEGER AS year,
			f2019 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2020':: INTEGER AS year,
			f2020 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2021':: INTEGER AS year,
			f2021 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2022':: INTEGER AS year,
			f2022 AS value
		FROM renewable_energy
		UNION ALL
		SELECT *,
			'2023':: INTEGER AS year,
			f2023 AS value
		FROM renewable_energy
	)
	SELECT * 
	FROM unpivoted_data;

-- Correct spelling error
UPDATE normalized_energy_data
SET year = 2011
WHERE year = 20011;

-- Yearly consumption per country
SELECT
	country,
	year,
	SUM(value) AS total_consumption
FROM normalized_energy_data
WHERE country = 'Germany'
GROUP BY country, year
ORDER BY year;

-- Change over time in percentage
SELECT 
	country,
	energy_type,
	year,
	value,
	LAG(value) OVER (PARTITION BY country, energy_type ORDER BY year) AS previous_year_value,
	((value - LAG(value)OVER(PARTITION BY country, energy_type ORDER BY year))::NUMERIC / NULLIF(LAG(value) OVER (PARTITION BY country, energy_type ORDER BY year), 0)) * 100 AS yearly_change
FROM normalized_energy_data;

-- Highest consumption Top 5 countrys
SELECT
	country,
	SUM(value) AS total_consumption
FROM normalized_energy_data
GROUP BY country
ORDER BY total_consumption DESC
LIMIT 5;

-- Percentage share of total consumption per year
SELECT 
	country,
	year,
	technology,
	energy_type,
	value,
	SUM(value) OVER (PARTITION BY year) AS total_yearly,
	CASE
		WHEN SUM(value) OVER (PARTITION BY year) = 0 THEN NULL
		ELSE (value::NUMERIC / SUM(value) OVER (PARTITION BY year)) * 100
	END AS percentage
FROM normalized_energy_data
WHERE year BETWEEN 2000 AND 2023;

-- CAGR (Compound Annual Growth Rate) yearly avg. growth between 2000 and 2022 in correlation between country, technology and energy_type
WITH cagr_calc AS(
	SELECT
		country,
		technology,
		energy_type,
		MIN(year) AS start_year,
		MAX(year) AS end_year,
		SUM(CASE WHEN year = 2000 THEN value END) AS value_2000,
		SUM(CASE WHEN year = 2022 THEN value END) AS value_2022
	FROM normalized_energy_data
	GROUP BY country, technology, energy_type
)
SELECT 
	country,
	technology,
	energy_type,
	value_2000,
	value_2022,
	POWER((value_2022::NUMERIC / NULLIF(value_2000, 0)), 1.0 / (end_year - start_year)) - 1 AS cagr
FROM cagr_calc;

-- Ranking consumption per country
SELECT
	country,
	SUM(value) AS total_consumption,
	RANK() OVER (ORDER BY SUM(value) DESC) AS rank
FROM normalized_energy_data
GROUP BY country
ORDER BY rank;

-- Time series analysis with moving average
SELECT
	country,
	technology,
	year,
	value,
	AVG(value) OVER (PARTITION BY country, technology ORDER BY year ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS moving_avg_5_years
FROM normalized_energy_data;

-- Forecasting with linear regression
WITH trend AS (
	SELECT
		country,
		technology,
		year,
		value,
		REGR_SLOPE(value, year) OVER (PARTITION BY country, technology) AS slope,
		REGR_INTERCEPT(value, year) OVER (PARTITION BY country, technology) AS intercept
	FROM normalized_energy_data
)
SELECT
		country,
		technology,
		year,
		value,
		(slope * year + intercept) AS forecast
FROM trend;
