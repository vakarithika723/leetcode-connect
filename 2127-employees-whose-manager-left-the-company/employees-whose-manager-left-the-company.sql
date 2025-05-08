# Write your MySQL query statement below
# find all employees with salaries < 30000
# next do an left join from employees to itself except join on manager_id to employee_id. If the employee_id is null, then the manager has left

SELECT e1.employee_id
FROM Employees AS e1
LEFT JOIN Employees AS e2
    ON e1.manager_id = e2.employee_id
WHERE e1.salary < 30000 
    AND e2.employee_id IS NULL
    AND e1.manager_id IS NOT NULL
ORDER BY e1.employee_id