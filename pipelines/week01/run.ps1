$ErrorActionPreference = "Stop"

Write-Host "Running Week01 SQL pipeline..."

docker-compose --profile tools run --rm tools bash -lc 'export PGPASSWORD="$POSTGRES_PASSWORD"; psql -X -v ON_ERROR_STOP=1 -h postgres -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f pipelines/week01/sql/01_staging.sql'
docker-compose --profile tools run --rm tools bash -lc 'export PGPASSWORD="$POSTGRES_PASSWORD"; psql -X -v ON_ERROR_STOP=1 -h postgres -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f pipelines/week01/sql/02_generate_data.sql'
docker-compose --profile tools run --rm tools bash -lc 'export PGPASSWORD="$POSTGRES_PASSWORD"; psql -X -v ON_ERROR_STOP=1 -h postgres -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f pipelines/week01/sql/04_mart_star.sql'
docker-compose --profile tools run --rm tools bash -lc 'export PGPASSWORD="$POSTGRES_PASSWORD"; psql -X -v ON_ERROR_STOP=1 -h postgres -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f pipelines/week01/sql/05_fix_event_type.sql'

Write-Host "Done."
