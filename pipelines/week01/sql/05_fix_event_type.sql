BEGIN;

-- Corrige a fato
UPDATE mart.fact_events
SET event_type = 'cta_click'
WHERE event_type = 'click';

-- Garante dimensão atualizada
INSERT INTO mart.dim_event_types (event_type)
VALUES ('cta_click')
ON CONFLICT (event_type) DO NOTHING;

-- Remove o tipo antigo da dimensão se não houver mais uso
DELETE FROM mart.dim_event_types det
WHERE det.event_type = 'click'
  AND NOT EXISTS (
    SELECT 1 FROM mart.fact_events fe WHERE fe.event_type = det.event_type
  );

COMMIT;
