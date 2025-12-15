WITH generate_series AS (
  SELECT generate_series(1, 100) AS event_id
)
INSERT INTO stg.stg_events (event_id, event_ts, user_id, event_type, source, payload_json)
SELECT
  'event_' || event_id,
  NOW() - INTERVAL '1 day' * (random() * 10) -- aleatória para o último intervalo de 10 dias
  , 'user_' || (random() * 10)::int
  , CASE WHEN random() > 0.5 THEN 'click' ELSE 'view' END
  , 'website'
  , jsonb_build_object('data', 'value_' || event_id)
FROM generate_series
ON CONFLICT (event_id) DO NOTHING;
