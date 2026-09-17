# Gates de governança para backend e sincronização

Status: gate técnico implementado; aprovações formais ainda pendentes.

O protótipo atual permanece local. O script `scripts/check_governance_gate.sh`
é executado pelo CI somente quando uma alteração introduz backend ou
sincronização. Nesse caso, a promoção falha sem três evidências versionadas:

1. `docs/approvals/lgpd.md`: papéis, finalidade, retenção, base legal e
   responsável formal pelo tratamento;
2. `docs/approvals/ethics.md`: protocolo e decisão da instância ética aplicável;
3. `docs/approvals/threat-model.md`: revisão e aceite do threat model por
   responsável de segurança.

Arquivos de requisitos, rascunhos ou textos contendo `pending`, `not approved`,
`template` ou `placeholder` não satisfazem o gate. O Codex pode verificar a
presença e consistência técnica, mas não pode emitir aprovação jurídica, ética
ou clínica. A separação segue a matriz de prontidão em
[`docs/threat-model.md`](threat-model.md) e os requisitos LGPD em
[`docs/privacy-lgpd.md`](privacy-lgpd.md).

## Verificação local

```bash
bash scripts/check_governance_gate.sh HEAD^
```

O resultado esperado no protótipo é `no backend/synchronization change
detected`. Esta barreira reduz o risco de uma futura implementação ativar
sincronização sem autorização documentada; não substitui revisão especializada
nem revisão ética.

O workflow de auto-merge também aguarda explicitamente `verify`,
`dependency-audit` e CodeQL em `SUCCESS`; uma execução em andamento não é
tratada como aprovação. O incidente que motivou essa proteção está registrado
na [issue #84](https://github.com/AloisioMagalhaes/bipolar-mood-spending-tracker/issues/84).

Após a proteção de `develop`, a validação operacional deve ocorrer em um PR
subsequente com todos os checks obrigatórios concluídos antes do merge.

