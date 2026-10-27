-- How many interactions and users are in each split?
SELECT split, event_type, COUNT(*) AS n, COUNT(DISTINCT user_id) AS usuarios
FROM retail_ai.interactions_split
GROUP BY 1, 2 ORDER BY 1, 2;

-- How many interactions has a tipical user?
SELECT APPROX_QUANTILES(n, 10) AS deciles
FROM (
    SELECT user_id, COUNT(*) AS n
    FROM retail_ai.interactions_split
    WHERE split = 'train'
    GROUP BY user_id
);

-- How concentrated purchases are?
WITH p AS (
    SELECT product_id, COUNT(*) AS n
    FROM retail_ai.interactions_split
    WHERE split = 'train' AND event_type = 'purchase'
    GROUP BY product_id
), r AS (
    SELECT n, PERCENT_RANK() OVER (ORDER BY n DESC) AS pr FROM p
)
SELECT SUM(IF(pr <= 0.1, n, 0)) / SUM(n) AS share_top_10pct
FROM r;

-- How many test users does not have history? (cold start of users)
WITH tr AS (SELECT DISTINCT user_id FROM retail_ai.interactions_split WHERE split = 'train'),
     te AS (SELECT DISTINCT user_id FROM retail_ai.interactions_split WHERE split = 'test')
SELECT
    COUNT(*) AS usuarios_test,
    COUNTIF(tr.user_id IS NULL) AS sin_historia,
    COUNTIF(tr.user_ID IS NULL) / COUNT(*) AS share_cold
FROM te LEFT JOIN tr USING (user_id);

-- How many test products never showed on train? (cold start of products)
WITH tr AS (SELECT DISTINCT product_id FROM retail_ai.interactions_split WHERE split = 'train'),
     te AS (SELECT DISTINCT product_id FROM retail_ai.interactions_split WHERE split = 'test')
SELECT
    COUNT(*) AS productos_test,
    COUNTIF(tr.product_id IS NULL) AS sin_historia,
    COUNTIF(tr.product_ID IS NULL) / COUNT(*) AS share_cold
FROM te LEFT JOIN tr USING (product_id);