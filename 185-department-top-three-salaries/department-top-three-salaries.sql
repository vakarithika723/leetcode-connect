# Write your MySQL query statement below
WITH top_earners AS (
SELECT d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary,
    DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS salary_rank
FROM Employee AS e
JOIN Department AS d
    ON e.departmentId = d.id
)

SELECT Department,
    Employee,
    Salary
FROM top_earners 
WHERE salary_rank <= 3