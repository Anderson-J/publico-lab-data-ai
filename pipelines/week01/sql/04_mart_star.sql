CREATE SCHEMA IF NOT EXISTS mart;

CREATE TABLE IF NOT EXISTS mart.dim_users (
  user_id TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS mart.dim_event_types (
  event_type TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS mart.dim_sources (
  source TEXT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS mart.fact_events (
  event_id TEXT PRIMARY KEY,
  event_ts TIMESTAMPTZ NOT NULL,
  user_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  source TEXT NOT NULL,
  payload_json JSONB NOT NULL
);

INSERT INTO mart.dim_users (user_id)
SELECT DISTINCT user_id
FROM stg.stg_events
ON CONFLICT (user_id) DO NOTHING;

INSERT INTO mart.dim_event_types (event_type)
SELECT DISTINCT event_type
FROM stg.stg_events
ON CONFLICT (event_type) DO NOTHING;

INSERT INTO mart.dim_sources (source)
SELECT DISTINCT source
FROM stg.stg_events
ON CONFLICT (source) DO NOTHING;

INSERT INTO mart.fact_events (event_id, event_ts, user_id, event_type, source, payload_json)
SELECT event_id, event_ts, user_id, event_type, source, payload_json
FROM stg.stg_events
ON CONFLICT (event_id) DO NOTHING;

CREATE INDEX IF NOT EXISTS idx_fact_events_ts ON mart.fact_events (event_ts);
CREATE INDEX IF NOT EXISTS idx_fact_events_user ON mart.fact_events (user_id);
CREATE INDEX IF NOT EXISTS idx_fact_events_type ON mart.fact_events (event_type);
