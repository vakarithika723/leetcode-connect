# Write your MySQL query statement below
# Look at all prices before or on '2019-08-16'
# rank prices from most recent -> old based on change_date and partition by product_id
# if the product is not listed before or on '2019-08-16', then the default price should be 10

WITH get_products AS (
    SELECT product_id
    FROM Products
    GROUP BY product_id
),
get_price_ranking AS (
    SELECT product_id,
        new_price,
        RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS price_rank
    FROM Products
    WHERE change_date <= '2019-08-16'
)


SELECT gp.product_id,
    (CASE WHEN gr.product_id IS NULL THEN 10 ELSE gr.new_price END) AS price
FROM get_products AS gp
LEFT JOIN get_price_ranking AS gr
    ON gp.product_id = gr.product_id AND gr.price_rank = 1