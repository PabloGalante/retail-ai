ASSERT (SELECT COUNT(*) FROM retail_ai.interactions
        WHERE user_id IS NULL OR product_id IS NULL) = 0
  AS 'There are interactions without user_id or product_id';

ASSERT (SELECT COUNT(*) FROM retail_ai.interactions i
        LEFT JOIN `bigquery-public-data.thelook_ecommerce.products` p ON i.product_id = p.id
        WHERE p.id IS NULL) = 0
  AS 'There are products that do not exist in the catalog';

ASSERT (SELECT MAX(ts) FROM retail_ai.interactions) < TIMESTAMP('2026-10-01')
  AS 'There are interactions after the snapshot';

ASSERT (SELECT MIN(ts) FROM retail_ai.interactions_split WHERE split = 'test')
     > (SELECT MAX(ts) FROM retail_ai.interactions_split WHERE split = 'train')
  AS 'The test is not posterior to the train: there is temporal leakage';

ASSERT (SELECT COUNTIF(split = 'test') / COUNT(*) FROM retail_ai.interactions_split) > 0.03
  AS 'The test has less than 3% of the interactions';