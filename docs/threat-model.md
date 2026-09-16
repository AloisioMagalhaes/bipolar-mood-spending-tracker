# Threat model e Zero Trust — etapa 4

Status: especificação preventiva; os controles abaixo não significam que o
protótipo atual esteja pronto para dados clínicos.

## Ativos e fronteiras

Ativos principais: autorrelatos de saúde, registros financeiros, consentimentos,
tokens/sessões e trilhas de auditoria. As fronteiras são dispositivo do usuário,
cliente Flutter, backend futuro, identidade do profissional e serviços de
build/release. O protótipo mantém dados localmente e não possui backend.

## STRIDE resumido

| Ameaça | Exemplo | Controle requerido | Verificação |
|---|---|---|---|
| Spoofing | conta se passando por profissional | MFA, identidade verificada, sessão curta | testes de autenticação |
| Tampering | alterar registro ou consentimento | integridade, versionamento e auditoria append-only | teste de autorização |
| Repudiation | negar compartilhamento | evento de consentimento com data/versão/escopo | auditoria automatizada |
| Information disclosure | vazamento de saúde/gastos | criptografia, minimização, RLS e logs sem dados | DAST/revisão de logs |
| Denial of service | bloquear acompanhamento | limites, retry seguro e recuperação | teste de resiliência |
| Elevation of privilege | paciente acessar outro paciente | autorização por recurso e menor privilégio | matriz de acesso |

## Princípios Zero Trust

Toda requisição futura deve ser autenticada, autorizada por recurso e escopo,
validada quanto ao contexto e registrada sem conteúdo sensível desnecessário.
Não confiar na rede, no dispositivo ou em um vínculo antigo. Aplicar menor
privilégio, negar por padrão, separar papéis paciente/profissional e revogar
sessões e consentimentos imediatamente. Essas decisões seguem NIST SP 800-207
[1] e OWASP ASVS [2].

## Critérios de segurança

- Nenhum endpoint sem autenticação e autorização explícitas.
- Consentimento revogado impede novas leituras/compartilhamentos.
- Logs não contêm humor, gastos, motivos ou tokens em texto claro.
- Segredos não entram no repositório; CI bloqueia vazamentos.
- Threat model é revisado a cada mudança de fronteira, modelo ou dependência.

## Gate obrigatório antes de sincronização

A sincronização remota permanece desabilitada no protótipo. A implementação
futura só poderá avançar após evidência versionada de: (1) threat model
aprovado e revisado; (2) definição formal de controlador, operador, finalidade,
retenção e base legal pela governança responsável; (3) consentimento granular,
explícito, revogável e auditável; (4) revisão ética aplicável; (5) testes
positivos e negativos de isolamento por recurso; e (6) revisão de segurança do
backend e das políticas RLS. Requisitos documentados não equivalem a aprovação
formal. Até que todos os artefatos existam, o cliente deve operar somente com
dados locais e sem alegação de proteção remota.

### Matriz de prontidão

| Gate | Evidência mínima | Estado |
|---|---|---|
| Threat model | modelo atualizado, cenários e mitigação revisados | especificado, não aprovado |
| LGPD | papéis, finalidade, retenção e base legal formalizados | pendente |
| Consentimento | escopo, revogação e auditoria testados | local; remoto pendente |
| Ética | protocolo e revisão ética aplicável | pendente |
| Backend | autenticação, autorização por recurso, RLS e auditoria | não implementado |
| Sincronização | testes de integração e segurança aprovados | bloqueada |

## Referências (ABNT)

[1] NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY. *Zero Trust Architecture*.
NIST SP 800-207. Gaithersburg: NIST, 2020. Disponível em:
<https://doi.org/10.6028/NIST.SP.800-207>. Acesso em: 15 set. 2026.

[2] OWASP FOUNDATION. *Application Security Verification Standard 4.0.3*.
[S. l.], 2021. Disponível em: <https://owasp.org/www-project-application-security-verification-standard/>.
Acesso em: 15 set. 2026.
