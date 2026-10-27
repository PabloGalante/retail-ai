PROJECT ?= retail-ai-pgalante
BQ = bq query --use_legacy_sql=false --project_id=$(PROJECT)

.PHONY: data

data:
	$(BQ) < data/definitions/01_interactions.sql
	$(BQ) < data/definitions/02_interactions_split.sql
	$(BQ) < data/definitions/03_assertions.sql