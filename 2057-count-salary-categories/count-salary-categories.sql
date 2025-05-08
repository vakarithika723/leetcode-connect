# Write your MySQL query statement below
WITH acc_cat AS (
SELECT *,
    (CASE WHEN income < 20000 THEN 'Low Salary'
    WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
    ELSE 'High Salary' END) AS category
FROM Accounts
),
category_list AS (
    SELECT 'Low Salary' AS category

    UNION ALL
    SELECT 'Average Salary' AS category

    UNION ALL
    SELECT 'High Salary' AS category
)

-- SELECT * FROM acc_cat
SELECT cl.category,
    IFNULL(COUNT(ac.category),0) AS accounts_count
FROM category_list AS cl
LEFT JOIN acc_cat AS ac
    ON cl.category = ac.category
GROUP BY cl.category