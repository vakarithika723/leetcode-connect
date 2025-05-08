# Write your MySQL query statement below
WITH RECURSIVE queue_weight_tracker AS (
    SELECT turn,
        person_id,
        person_name,
        weight,
        weight AS total_weight
    FROM Queue
    WHERE turn = 1

    UNION ALL
    SELECT q.turn,
        q.person_id,
        q.person_name,
        q.weight,
        q.weight + qw.total_weight AS total_weight
    FROM queue_weight_tracker AS qw
    JOIN Queue AS q
        ON q.turn = qw.turn + 1
            AND q.weight + qw.total_weight <= 1000

)

SELECT person_name
FROM queue_weight_tracker
ORDER BY turn DESC
LIMIT 1