CREATE TABLE under5_mortality (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(100),
    location VARCHAR(100),
    under5_mortality_rate REAL,
    abb CHAR(3)
);
CREATE TABLE gdp_growth_temp (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(100),
    country_id CHAR(3),
    indicator VARCHAR(100),
    year VARCHAR(10),   -- temporarily as VARCHAR
    value VARCHAR(50),  -- temporarily as VARCHAR
    abb CHAR(3)
);


COPY under5_mortality(country_name, location, under5_mortality_rate, abb)
FROM 'F:/project/Healthy Sustainable Development Analysis/mortarlity.csv'
DELIMITER ','
CSV HEADER;
COPY gdp_growth(country_name, country_id, indicator, year, value, abb)
FROM 'F:/project/Healthy Sustainable Development Analysis/gdp.csv'
DELIMITER ','
CSV HEADER;
-- See first 10 rows of mortality
SELECT * FROM under5_mortality LIMIT 10;

-- See first 10 rows of GDP
SELECT * FROM gdp_growth LIMIT 10;

-- Join tables on country abbreviation
SELECT m.country_name, m.under5_mortality_rate, g.value AS gdp_growth
FROM under5_mortality m
JOIN gdp_growth g ON m.abb = g.abb
LIMIT 20;
