-- Snapshot: everything after as_of is ignored (the source is regenerated daily).
DECLARE as_of TIMESTAMP DEFAULT TIMESTAMP('2026-10-01');

CREATE OR REPLACE TABLE retail_ai.interactions AS
WITH views AS (           -- product view: weak signal
  SELECT
    user_id,
    SAFE_CAST(REGEXP_EXTRACT(uri, r'/product/(\d+)') AS INT64) AS product_id,
    'view' AS event_type,
    1.0 AS weight,
    created_at AS ts
  FROM `bigquery-public-data.thelook_ecommerce.events`
  WHERE event_type = 'product' AND user_id IS NOT NULL
),
purchases AS (            -- purchase: strong signal
  SELECT
    user_id,
    product_id,
    'purchase' AS event_type,
    4.0 AS weight,
    created_at AS ts
  FROM `bigquery-public-data.thelook_ecommerce.order_items`
  WHERE status != 'Cancelled' OR status != 'Returned'
)
SELECT * FROM views WHERE product_id IS NOT NULL AND ts < as_of
UNION ALL
SELECT * FROM purchases WHERE ts < as_of;