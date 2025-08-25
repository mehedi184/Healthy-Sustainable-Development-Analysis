CREATE TABLE IF NOT EXISTS mortarlity_clean AS
SELECT 
    "Location" AS country_name,
    "2020 rate"::NUMERIC AS mortarlity_rate,
    abb
FROM staging_mortarlity
WHERE abb IS NOT NULL;

-- Create cleaned GDP table
CREATE TABLE IF NOT EXISTS gdp_clean AS
SELECT 
    country AS country_name,
    value::NUMERIC AS gdp_growth,
    abb
FROM staging_gdp
WHERE abb IS NOT NULL;
CREATE TABLE IF NOT EXISTS iso_country_ref AS
SELECT DISTINCT abb, country_name
FROM (
    SELECT abb, "Location" AS country_name FROM staging_mortarlity
    UNION
    SELECT abb, country AS country_name FROM staging_gdp
) AS combined;
CREATE TABLE IF NOT EXISTS mortarlity_final AS
SELECT m.country_name, m.mortarlity_rate, g.gdp_growth, m.abb
FROM mortarlity_clean m
LEFT JOIN gdp_clean g
ON m.abb = g.abb;
