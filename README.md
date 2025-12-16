# Portfolio Data + AI Platform Lab

Repositório público com ambiente 100% dockerizado e portátil, pensado para estudos e prática de Engenharia de Dados, IA aplicada e plataforma (DevOps e SRE). O objetivo é conseguir clonar em qualquer máquina (PC do trabalho ou pessoal) e subir o stack com o mínimo de atrito, mantendo boas práticas de segurança desde o dia 0.

## O que este repositório entrega

- Ambiente reproduzível via Docker (sem dependências instaladas no host além do Docker).
- Serviços base para labs de dados: Postgres e MinIO.
- UI para inspeção rápida: pgAdmin.
- Um container de ferramentas (tools) para executar comandos de forma padronizada e reproduzível.
- Tudo versionado para virar portfólio com evidência de arquitetura, decisões e execução.

## Stack atual

- Postgres (banco relacional para staging e marts)
- MinIO (simulação de S3 local para lakehouse e, depois, pipelines e RAG)
- pgAdmin (GUI web para Postgres)
- tools (container com Python e psql para execução padronizada)

## Pré requisitos

- Docker e Docker Compose
- Git

## Como rodar

1) Criar arquivo de ambiente local

    - Copie o exemplo e ajuste senhas localmente:
    - `cp .env.example .env`

2) Subir o stack

    - `docker-compose up -d`

3) Ver status

    - `docker-compose ps`

4) Ver logs

    - `docker-compose logs -f postgres`
    - `docker-compose logs -f minio`

## Acesso às interfaces

- pgAdmin: `http://localhost:5050` (se falhar, use `http://127.0.0.1:5050`)
- MinIO Console: `http://localhost:9001` (se falhar, use `http://127.0.0.1:9001`)

## Conectar no Postgres pelo pgAdmin

Ao registrar o servidor no pgAdmin, use o nome do serviço Docker:

- Host name/address: `postgres`
- Port: `5432`
- Maintenance database: `lab`
- Username: `lab`
- Password: valor do seu `.env`

Observação: o Postgres não precisa expor porta no host para o pgAdmin funcionar. O pgAdmin acessa via rede do Docker.

## Executar comandos de forma reproduzível com o tools

O serviço `tools` existe para executar scripts e comandos sem instalar nada no host.

Exemplo: testar conexão no Postgres

- `docker-compose --profile tools run --rm tools bash -lc 'export PGPASSWORD="$POSTGRES_PASSWORD"; psql -X -h postgres -p "$POSTGRES_PORT" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c "SELECT 1;"'`

## Estrutura de pastas

- `infra/docker/` : composição do ambiente (compose principal)
- `infra/tools/` : Dockerfile do container tools
- `pipelines/` : labs e pipelines por semana ou módulo
- `docs/` : documentação e decisões arquiteturais

## Roadmap dos labs

A ideia é evoluir de:

- ingestão e modelagem (batch)
- orquestração e qualidade
- streaming
- MLOps e arquiteturas de LLM/RAG

Cada fase inclui laboratório e desafio prático baseado em cenário real de trabalho.
