# MoodLedger — Documento Técnico de Requisitos de Software

**Versão:** 0.2.0 · **Status:** requisitos revisados por evidência · **Data:** 2026-09-15

## 1. Objetivo

O MoodLedger registra, com consentimento, compras e autorrelatos de humor para ajudar paciente e profissional a revisar padrões longitudinais associados ao transtorno bipolar. Não diagnostica, prevê episódios nem recomenda tratamento.

## 2. Feature prioritária

Linha do tempo correlacionando compra (valor, categoria, motivo e impulsividade) com humor, energia, sono e adesão autorreferida à medicação. A evidência apoia maior granularidade do acompanhamento digital, mas não sua substituição da avaliação clínica [R1–R3].

## 3. Atores

- **Paciente:** registra eventos, controla consentimento e exporta/exclui dados.
- **Profissional:** acessa pacientes autorizados, revisa tendências e anota contexto clínico.
- **Administrador:** somente configura tenancy, auditoria e suporte; não lê conteúdo clínico por padrão.

## 4. Requisitos funcionais

| ID | Requisito | Aceitação |
|---|---|---|
| RF-01 | Registrar humor, energia, irritabilidade, impulsividade, sono e medicação autorreferida | Registro validado, editável e auditado |
| RF-02 | Registrar compra com valor, data, categoria, motivo e planejada/impulsiva | Valor positivo, moeda e data obrigatórios |
| RF-03 | Exibir linha do tempo e filtros | Período, categoria e tipo de compra funcionam |
| RF-04 | Exibir padrões sobrepostos | Gráficos deixam claro que correlação não é diagnóstico |
| RF-05 | Compartilhar dados com profissional por consentimento revogável | Revogação bloqueia novos acessos |
| RF-06 | Exportar e excluir dados | Exportação legível e exclusão confirmada |
| RF-07 | Emitir sinal para revisão configurável | Nunca usar linguagem de diagnóstico ou urgência automática |

## 5. Requisitos não funcionais mensuráveis

- RNF-01: testes automatizados cobrindo pelo menos 80% do domínio no MVP.
- RNF-02: análise estática sem erros no CI.
- RNF-03: nenhuma credencial no repositório; segredos somente em Actions/Supabase.
- RNF-04: ações sensíveis auditadas com ator, data e operação.
- RNF-05: interface utilizável com leitor de tela e contraste WCAG 2.2 AA, quando aplicável.
- RNF-06: o sistema deve funcionar offline para registros locais e sinalizar estado de sincronização.

## 6. Riscos e limites

Falsos alertas, estigma, exposição financeira, coerção por terceiros, baixa adesão e interpretação clínica indevida. Mitigações: consentimento granular, minimização, criptografia, RLS, linguagem neutra, revisão humana e estudo de usabilidade antes de uso clínico.

## 7. Requisitos derivados da evidência

- RF-08: fluxo comum concluível em até 60 segundos.
- RF-09: dados ausentes conservam motivo, sem imputação silenciosa.
- RF-10: escalas exibem número e descrição textual; cor/emoji são complementares.
- RF-11: vínculo exige convite temporário, aceite bilateral, escopo visível, revogação e auditoria.
- RF-12: exportação produz dados legíveis pelo paciente e profissional.
- RF-13: padrões são rotulados como autorrelato/tendência para revisão, nunca como fase bipolar.
- RF-14: vínculo demonstrativo exige código e confirmação explícita; produção exige backend, expiração e auditoria server-side.

## 8. Métricas e pesquisa

Medir conclusão, atividade, retenção 7/30/90 dias, tempo de registro, ausência, revogação, erros de sincronização, SUS/MAUQ e carga percebida. Não usar acurácia preditiva no MVP. Revisões recomendam definições replicáveis, seguimento longo, validação externa e modelagem explícita de ausência [R6–R8].

## 9. Priorização

P0: qualquer falha de CI/segurança. P1: RF-08–RF-13 e persistência. P2: visualizações avançadas e sensores opt-in. P3: modelos preditivos somente após ética e validação externa.

## 10. Baseline arquitetural visual

Os 14 diagramas UML 2.x derivados do código-fonte estão em [`docs/diagrams/uml`](diagrams/uml/index.md); os níveis C4 estão em [`docs/diagrams/c4`](diagrams/c4). A atualização deve ocorrer no mesmo PR de qualquer mudança estrutural.

## 7. Referências iniciais

- **R1:** Faurholt-Jepsen et al. *Portable technologies for digital phenotyping of bipolar disorder: A systematic review*. Journal of Affective Disorders, 2021. DOI: 10.1016/j.jad.2021.08.052.
- **R2:** *Recommendations for Research and Clinical Implementation of Ambulatory Assessment...*. PubMed, 2026. https://pubmed.ncbi.nlm.nih.gov/42228842/.
- **R3:** World Health Organization. *Bipolar disorder*. https://www.who.int/news-room/fact-sheets/detail/bipolar-disorder.
- **R4:** Flutter. *Build and release a web app*. https://docs.flutter.dev/deployment/web.
- **R5:** GitHub. *Deploying your website automatically*. https://docs.github.com/en/get-started/start-your-journey/deploying-your-website-automatically.
- **R6:** Nicholas et al. *Mobile App–Based Self-Report Questionnaires for Bipolar Disorder: Systematic Review*. JMIR, 2021. https://pmc.ncbi.nlm.nih.gov/articles/PMC7822726/.
- **R7:** Duffy et al. *Patients’ adherence to smartphone apps in bipolar disorder: systematic review*. https://pmc.ncbi.nlm.nih.gov/articles/PMC8175501/.
- **R8:** *Digital Markers for Passive Remote Monitoring of Bipolar Disorder: Systematic Review*. 2026. https://pmc.ncbi.nlm.nih.gov/articles/PMC13472530/.
