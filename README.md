# Retail AI

Learning project: a product recommender (two-tower, TensorFlow) trained and served on Google Cloud, plus a Python agent that uses it as a tool and automates returns with human approval.

**Status:** day 1 of 24 · progress in [DEVLOG.md](DEVLOG.md)

**Data:** `bigquery-public-data.thelook_ecommerce`, a synthetic e-commerce dataset.

**Planned architecture:** BigQuery data and features → training on Agent Platform → batch recommendations and an API on Cloud Run → Python agent (hand-written loop, then ADK).