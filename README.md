# Portfolio Data + AI Platform Lab

Repositório público com ambiente dockerizado e versionado para estudos de Engenharia de Dados, IA e práticas de plataforma (DevOps/SRE).

## Pré requisitos

- Docker e Docker Compose
- Git

## Como rodar

1. Copie o arquivo de ambiente:
   - cp .env.example .env
2. Suba o ambiente:
   - docker compose -f infra/docker/compose.yml up -d

## Segurança

- Nunca commitar arquivos .env ou credenciais.
- Todo segredo deve ficar em GitHub Secrets ou variáveis de ambiente.
