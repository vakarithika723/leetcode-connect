WITH RECURSIVE log_count AS (
    # starting query will list ALL ids and their associated number they start with. For example, at ID = 4, the number is 2. The frequency of the number 2 is 1 (num_length).
    SELECT id AS start_id,
        id AS current_id,
        num,
        1 AS num_length
    FROM Logs

    UNION ALL
    # This is iterating for each line item above. For example, we start with || 1 | 1 | 1 | 1 || as my start_id, current_id, num, num_length respectively. The next row will join if the next id value is consecutive (1 + last id) AND if the next consecutive id has the same num as the last num. If this is true it will add this row and add to the num_length
    SELECT log_count.start_id,
        l.id AS current_id,
        log_count.num,
        log_count.num_length + 1 AS num_length
    FROM log_count
    INNER JOIN Logs AS l
        ON l.id = log_count.current_id + 1
            AND l.num = log_count.num
)

SELECT DISTINCT num AS ConsecutiveNums
FROM log_count
WHERE num_length >= 3