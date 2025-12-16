# Security Policy

Este é um repositório público. A regra é simples: nada sensível pode ir para o Git, nem por acidente.

## Regras básicas

- Nunca commitar segredos: tokens, chaves, senhas, arquivos .env, certificados, dumps.
- Nunca commitar dados reais de clientes, dados internos, ou PII.
- Usar variáveis de ambiente e GitHub Secrets para qualquer informação sensível.
- Evitar padrões inseguros: usuários e senhas default devem ser substituídos no .env local.

## Arquivos e padrões proibidos

- `.env` e variações (`.env.*`)
- chaves privadas e certificados (`*.pem`, `*.key`, `id_rsa*`)
- dumps de banco e exports com dados (`*.sql` com dados reais, `*.dump`, `*.csv` sensível)

## Exposição de portas e rede

- Sempre que possível, serviços devem rodar sem expor portas no host.
- Quando uma porta for necessária (ex: pgAdmin, MinIO console), ela deve ficar presa no loopback:
  - `127.0.0.1` e, quando aplicável, `::1`
Isso reduz risco de exposição na rede local.

## Dados de laboratório

- Apenas dados sintéticos.
- Se algum dataset externo for usado, deve ser público e não sensível.
- Se houver risco de conter PII, não entra no repositório.

## Reportar um problema de segurança

- Não abra issue pública contendo credenciais, tokens, dumps, ou detalhes exploráveis.
- Preferir GitHub Security Advisory (se habilitado).
- Se não estiver, descreva o problema de forma genérica, sem dados sensíveis.

## Boas práticas esperadas

- Rotacionar credenciais locais se suspeitar de vazamento.
- Preferir secrets no CI quando houver automação.
- Revisar diffs antes de qualquer push, especialmente arquivos de configuração.
