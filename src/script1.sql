-- Drop the table if it already exists to allow for rerunning the script
DROP TABLE IF EXISTS random_people;

-- Create a new table and populate it with random data
CREATE TABLE random_people AS
WITH first_names(name) AS (
    VALUES ('Daniele'), ('Debora'), ('Mattia'), ('Jake'), ('Amy'), ('Henry'), ('Neil'), ('Tim'), ('John'), ('George')
),
last_names(name) AS (
    VALUES ('Rossi'), ('Verdi'), ('Gialli'), ('Caponi'), ('Gallini'), ('Gatti'), ('Ford'), ('Daniel'), ('Harrison'), ('Macdonald')
),
random_data AS (
    SELECT
        -- Generate random first and last names
        (SELECT name FROM first_names ORDER BY RANDOM() LIMIT 1) AS first_name,
        (SELECT name FROM last_names ORDER BY RANDOM() LIMIT 1) AS last_name,
        -- Generate random temperature (20-35) and humidity (40-80) values
        (20 + (random() * 15))::NUMERIC(5,2) AS temperature,
        (40 + (random() * 40))::NUMERIC(5,2) AS humidity,
        -- Generate a random date within the last 10 years
        '2015-01-01'::date + trunc(random() * 365 * 10)::int AS random_date
    FROM generate_series(1, 20) -- Generate 20 rows of data
)
