# Write your MySQL query statement below
WITH friend_by_accept AS (
SELECT requester_id AS id,
    COUNT(accepter_id) AS num
FROM RequestAccepted
GROUP BY requester_id
),
friend_by_req AS (
SELECT accepter_id AS id,
    COUNT(*) AS num
FROM RequestAccepted
GROUP BY accepter_id
)

SELECT id,
    SUM(num) AS num
FROM (
    SELECT * FROM friend_by_accept
    UNION ALL
    SELECT * FROM friend_by_req
) friends
GROUP BY id
ORDER BY SUM(num) DESC
LIMIT 1