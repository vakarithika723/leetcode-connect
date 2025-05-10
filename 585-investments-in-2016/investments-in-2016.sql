# Write your MySQL query statement below
# pids that have same tiv_2015 value is included
# pids should not have matching lat & lon
WITH matching_2015 AS (
    SELECT DISTINCT i1.pid,
        i1.tiv_2016,
        i1.lat,
        i1.lon
    FROM Insurance i1
    INNER JOIN Insurance i2
        ON i1.tiv_2015 = i2.tiv_2015
            AND i1.pid != i2.pid
),
unique_location AS (
    SELECT DISTINCT i1.pid,
        i1.tiv_2016,
        i1.lat,
        i1.lon
    FROM Insurance i1
    INNER JOIN Insurance i2
        ON CONCAT(i1.lat, i1.lon) = CONCAT(i2.lat,i2.lon)
            AND i1.pid != i2.pid    
)
SELECT ROUND(SUM(tiv_2016),2) AS tiv_2016
FROM (
SELECT * FROM matching_2015
EXCEPT
SELECT * FROM unique_location
) final_rows