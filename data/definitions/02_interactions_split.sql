DECLARE val_start TIMESTAMP DEFAULT TIMESTAMP('2026-08-01');
DECLARE test_start TIMESTAMP DEFAULT TIMESTAMP('2026-09-01');

CREATE OR REPLACE TABLE retail_ai.interactions_split AS
SELECT
  *,
  CASE
    WHEN ts < val_start THEN 'train'
    WHEN ts < test_start THEN 'val'
    ELSE 'test'
  END AS split
FROM retail_ai.interactions;