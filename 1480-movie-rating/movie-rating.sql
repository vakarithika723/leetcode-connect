# Write your MySQL query statement below
WITH user_rating_count AS (
    SELECT mr.user_id,
        u.name,
        COUNT(mr.movie_id) AS num_ratings
    FROM MovieRating AS mr
    INNER JOIN Users AS u
        ON mr.user_id = u.user_id
    GROUP BY mr.user_id
    ORDER BY COUNT(mr.movie_id) DESC, u.name
    LIMIT 1
),
avg_rating AS (
    SELECT mr.movie_id,
        m.title,
        AVG(mr.rating) AS avg_rating
    FROM MovieRating AS mr
    INNER JOIN Movies AS m
        ON mr.movie_id = m.movie_id
    WHERE MONTH(mr.created_at) = 2 AND YEAR(mr.created_at) = 2020
    GROUP BY mr.movie_id
    ORDER BY AVG(mr.rating) DESC, m.title
    LIMIT 1
)

SELECT name AS results
FROM user_rating_count

UNION ALL
SELECT title AS results
FROM avg_rating