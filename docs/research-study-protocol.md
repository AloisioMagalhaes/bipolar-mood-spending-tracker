# Protocolo operacional de validação — issue #14

Status: preparação; não autoriza recrutamento, coleta ou uso clínico.

## Objetivo e hipótese

Avaliar viabilidade, usabilidade e aceitabilidade do MoodLedger. Não testar
eficácia terapêutica, diagnóstico ou previsão de episódios. A hipótese é que o
registro diário seja utilizável e tenha completude mensurável; isso não implica
benefício clínico.

## Desenho e governança

Estudo observacional, prospectivo e de baixo risco somente após aprovação do
comitê de ética competente, revisão jurídica LGPD, plano de segurança e
consentimento específico. A equipe habilitada deverá definir população,
critérios de inclusão/exclusão, tamanho amostral, compensação, canais de
suporte e critérios de interrupção.

## Métricas pré-especificadas

| Dimensão | Medida | Relato |
|---|---|---|
| Usabilidade | SUS e/ou MAUQ | média, mediana, dispersão e respostas ausentes |
| Adesão | dias com registro / dias esperados | definição e janela explícitas |
| Retenção | participantes ativos no fim / início | perdas e motivo conhecido |
| Completude | campos preenchidos / campos esperados | sem imputar estado mental |
| Carga | tempo de preenchimento e abandono | distribuição e eventos adversos |
| Segurança | incidentes, revogações e solicitações de exclusão | contagem e severidade |

Dados ausentes serão descritos e analisados; nunca serão convertidos em humor,
energia ou fase bipolar. Resultados exploratórios serão comparados a medidas
clínicas somente por profissionais e sem decisão automatizada.

## Critérios de parada

Suspender o estudo diante de incidente de privacidade, risco inesperado,
sofrimento relevante, falha de consentimento ou orientação do comitê de ética.
Participantes podem desistir sem prejuízo. A issue #14 só poderá ser fechada
após aprovação documentada, execução e relatório revisado.

## Plano operacional e critérios de rastreabilidade

Antes de qualquer recrutamento, a equipe deve congelar e versionar: protocolo,
instrumentos, consentimento, modelo de dados, plano analítico, versão do app e
matriz de riscos. Cada participante deve receber um identificador aleatório;
não serão usados nome, contato ou identificador clínico no conjunto analítico.
O vínculo entre identificador e pessoa, se indispensável, deve permanecer sob
controle do responsável formal e fora do repositório.

O diário de estudo deve registrar apenas evento, instante, versão do aplicativo,
dispositivo em categoria ampla e resultado da tarefa. O conteúdo de humor,
gasto ou motivo não deve aparecer em logs, métricas de infraestrutura ou
relatórios públicos. Exportações de teste devem ser sintéticas e marcadas como
tal. Essas escolhas operacionalizam minimização, controle do usuário e
preocupações de privacidade observadas nas revisões de apps e de experiência
[2][4].

### Critérios mínimos de análise

- Usabilidade: reportar SUS/MAUQ por participante, distribuição e respostas
  ausentes; não converter escore em eficácia clínica.
- Adesão: publicar numerador, denominador, janela e regra de elegibilidade;
  apresentar também abandono e dados ausentes, sem imputar estado mental.
- Retenção: informar participantes elegíveis no início, no fim, perdas e motivo
  conhecido, quando autorizado.
- Segurança: enumerar incidentes, revogações, exclusões e interrupções; qualquer
  incidente de privacidade aciona os critérios de parada.
- Comparações exploratórias com medidas clínicas só podem ocorrer em protocolo
  aprovado, por profissional habilitado e sem classificação automática.

Não serão definidos limiares de “sucesso” depois da coleta. Se limiares forem
necessários, devem ser registrados em uma versão do protocolo anterior ao
recrutamento e justificados pelo desenho do estudo, não por resultados
observados. A heterogeneidade de definições de adesão e os tamanhos amostrais
limitados da literatura justificam publicar estimativas e limitações, em vez de
um número universal de eficácia [1][2][3].

### Definition of Done da issue #14

1. protocolo e plano analítico revisados por equipe habilitada;
2. aprovação ética e governança LGPD arquivadas;
3. consentimento específico, revogável e auditável testado;
4. versão do app e instrumentos congelados antes do recrutamento;
5. execução sem dados reais no protótipo enquanto os itens 1–3 estiverem
   pendentes;
6. relatório com amostra, perdas, dados ausentes, incidentes, limitações e
   links para a versão exata do software.

Até a conclusão dos itens 1–3, esta issue permanece aberta e o MoodLedger não
deve ser apresentado como validado clinicamente.

## Referências (ABNT)

[1] FERNANDEZ, A. et al. Patients' adherence to smartphone apps in the
management of bipolar disorder: a systematic review. *BMC Psychiatry*, v. 21,
2021. Disponível em: <https://pmc.ncbi.nlm.nih.gov/articles/PMC8175501/>.
Acesso em: 15 set. 2026.

[2] CHAN, S. et al. Mobile App–Based Self-Report Questionnaires for the
Assessment and Monitoring of Bipolar Disorder: Systematic Review. *JMIR
Mhealth Uhealth*, v. 9, n. 2, 2021. Disponível em:
<https://pmc.ncbi.nlm.nih.gov/articles/PMC7822726/>. Acesso em: 15 set. 2026.

[3] BRASIL. Lei nº 13.709, de 14 de agosto de 2018. *Lei Geral de Proteção de
Dados Pessoais*. Disponível em: <https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm>.
Acesso em: 15 set. 2026.

[4] ASTILL WRIGHT, L. et al. The User Experience of Ambulatory Assessment and
Mood Monitoring in Bipolar Disorder: Systematic Review and Meta-Synthesis of
Qualitative Studies. 2025. Disponível em:
<https://pmc.ncbi.nlm.nih.gov/articles/PMC12533931/>. Acesso em: 16 set. 2026.
