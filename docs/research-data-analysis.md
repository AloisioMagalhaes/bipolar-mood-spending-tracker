# Dicionário de dados e plano analítico — issue #46

Status: planejamento; nenhuma coleta está autorizada.

## Dicionário mínimo

| Grupo | Variável | Tipo | Regra |
|---|---|---|---|
| Produto | `event_id`, `created_at`, `schema_version` | identificador/data/texto | pseudônimo; sem nome ou contato |
| Autorrelato | humor, energia, sono | ordinal/número | resposta declarada; não é diagnóstico |
| Gasto | valor, categoria, motivo, impulsividade | número/texto/categórico | finalidade explícita e minimização |
| Uso | sessão, preenchimento, abandono | evento agregado | não coletar conteúdo clínico em logs |
| Privacidade | escopo, versão, timestamp, revogação | evento | auditar consentimento sem registrar o dado em si |

## Dados ausentes e qualidade

Ausência, atraso ou exclusão serão marcados como missing e reportados por
variável e janela. Não haverá imputação de humor, energia, sono ou fase
bipolar. Duplicatas, valores fora do domínio e timestamps inválidos serão
quantificados e tratados conforme protocolo pré-aprovado.

## Plano analítico

- Descrever adesão como dias com registro/dias esperados.
- Descrever retenção como participantes ativos no início e no fim.
- Descrever completude por campo e janela, com intervalo de confiança quando o
  desenho amostral permitir.
- Resumir SUS/MAUQ por distribuição e taxa de resposta.
- Relatar tempo de preenchimento, abandono, incidentes e revogações.
- Separar análise de usabilidade/viabilidade de qualquer análise exploratória
  de validade concorrente.
- Não executar classificação automática, previsão de episódios ou conclusão de
  eficácia terapêutica.

O plano final, população, tamanho amostral, testes e critérios de exclusão
devem ser aprovados por equipe habilitada e comitê de ética antes da coleta.

## Referências (ABNT)

[1] CHAN, S. et al. Mobile App–Based Self-Report Questionnaires for the
Assessment and Monitoring of Bipolar Disorder: Systematic Review. *JMIR
Mhealth Uhealth*, v. 9, n. 2, 2021. Disponível em:
<https://pmc.ncbi.nlm.nih.gov/articles/PMC7822726/>. Acesso em: 15 set. 2026.

[2] FERNANDEZ, A. et al. Patients' adherence to smartphone apps in the
management of bipolar disorder: a systematic review. *BMC Psychiatry*, v. 21,
2021. Disponível em: <https://pmc.ncbi.nlm.nih.gov/articles/PMC8175501/>.
Acesso em: 15 set. 2026.
