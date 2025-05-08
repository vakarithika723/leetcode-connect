# Write your MySQL query statement below
WITH max_student_id AS (
    SELECT MAX(id) AS max_seat
    FROM Seat
),
student_switch AS (
    SELECT (CASE WHEN id % 2 != 0 AND id = ms.max_seat THEN id
        WHEN id % 2 != 0 AND id != ms.max_seat THEN id + 1
        ELSE id - 1 END) AS id,
        student
    FROM Seat
    CROSS JOIN max_student_id AS ms
)

SELECT *
FROM student_switch
ORDER BY id


-- SELECT *
-- FROM (
-- SELECT * FROM odd_students

-- UNION ALL
-- SELECT * FROM even_students
-- ) students_switch
-- ORDER BY id