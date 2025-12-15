CREATE SCHEMA IF NOT EXISTS stg;

CREATE TABLE IF NOT EXISTS stg.stg_events (
  event_id TEXT PRIMARY KEY,
  event_ts TIMESTAMPTZ NOT NULL,
  user_id TEXT NOT NULL,
  event_type TEXT NOT NULL,
  source TEXT NOT NULL,
  payload_json JSONB NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_stg_events_ts ON stg.stg_events (event_ts);
CREATE INDEX IF NOT EXISTS idx_stg_events_user ON stg.stg_events (user_id);
CREATE INDEX IF NOT EXISTS idx_stg_events_type ON stg.stg_events (event_type);
