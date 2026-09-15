# Matriz de identidade e autorização

Status: arquitetura futura; não implementada no protótipo local.

| Recurso | Paciente | Profissional vinculado | Administrador |
|---|---|---|---|
| próprios autorrelatos | ler/criar/excluir | ler somente com consentimento ativo | negar por padrão |
| próprios gastos | ler/criar/excluir | ler somente com consentimento ativo | negar por padrão |
| consentimentos | ler/conceder/revogar próprios | sem alterar | auditar metadados mínimos |
| vínculo | solicitar/revogar próprio | aceitar/revogar relação | suporte auditado |

Regras: negar por padrão; autenticar cada requisição; autorizar por identidade,
recurso, finalidade e consentimento vigente; aplicar menor privilégio; expirar e
revogar sessões; registrar eventos sem conteúdo clínico. Consentimento não
substitui autorização. A matriz deriva dos princípios de Zero Trust [1] e da
proteção de dados sensíveis da LGPD [2].

## Referências (ABNT)

[1] NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY. *Zero Trust Architecture*.
NIST SP 800-207. 2020. Disponível em: <https://doi.org/10.6028/NIST.SP.800-207>.
Acesso em: 15 set. 2026.

[2] BRASIL. Lei nº 13.709, de 14 de agosto de 2018. *Lei Geral de Proteção de
Dados Pessoais*. Disponível em: <https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm>.
Acesso em: 15 set. 2026.
