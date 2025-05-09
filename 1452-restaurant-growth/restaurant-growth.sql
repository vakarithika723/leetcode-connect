# Write your MySQL query statement below
WITH moving_avg_calc AS (
SELECT visited_on,
    SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
    ROUND(SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)/7,2) AS average_amount
FROM (
    SELECT visited_on,
        SUM(AMOUNT) AS amount
    FROM Customer
    GROUP BY visited_on
) c1
ORDER BY visited_on
)
SELECT *
FROM moving_avg_calc
WHERE visited_on >= DATE_ADD((SELECT MIN(visited_on) FROM Customer), INTERVAL 6 DAY)
