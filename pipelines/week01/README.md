# Week 01: Events Staging + Mart (Star Schema) + Idempotência

## Objetivo

Implementar um fluxo mínimo, porém realista, de engenharia de dados em ambiente 100% dockerizado:

- staging de eventos (modelo orientado a eventos)
- carga idempotente
- construção de um mart analítico (star schema)
- correção de contrato de evento simulando cenário do dia a dia

## O que foi implementado

### Staging

- Schema `stg`
- Tabela `stg.stg_events` com:
  - `event_id` como chave primária (base para idempotência)
  - `payload_json` como `JSONB` para flexibilidade

### Geração de dados sintéticos

- Inserção de eventos sintéticos com `ON CONFLICT DO NOTHING`
- Uso de `jsonb_build_object` para construir JSON válido

### Mart analítico

- Schema `mart`
- Dimensões:
  - `mart.dim_users`
  - `mart.dim_event_types`
