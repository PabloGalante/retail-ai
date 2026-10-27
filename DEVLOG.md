# DEVLOG

## Day 1 · Thu Oct 22
- Done: Github Repo, Recommender Discovery
- Learned: Example (row), Features, Labels, Training, Models, Inference/Prediction, Supervised/Not-Supervised, user x product matrix, sparsity, content-based & collaborative filtering, explicit vs implicit feedback, negative sampling
- Broke (what failed, why, how I fixed it): couldn't install uv package through homebrew, had to use curl. Couldn't install TensorFlow on my Mac (because the Intel architecture), decided to use Google Colab instead to avoid using an outdated version of TF
- Decision: (what I chose and what I discarded)
- Data: purchase sparsity = 0.9999220389333566; event types = 844338
- Cost so far: USD 0

## Day 2 · Sat Oct 24
- Done: Added data queries, makefile and created dataset
- Learned: 
- Broke (what failed, why, how I fixed it): Changed "CASE WHEN RAND() < 0.8 THEN 'train' WHEN RAND() < 0.5 THEN 'val' ELSE 'test' END" in 02_interactions_split.sql and the query returned temporal leakage error - this was made on purpose to verify assertions and their response
- Decision (what I chose and what I discarded): Chose to discard Cancelled and Returned status, and used event_type product for products
- Data: as_of = 2026-10-01, test_start = 2026-09-01, val_start = 2026-08-01
- Cost so far: USD 0