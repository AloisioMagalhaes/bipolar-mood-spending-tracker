# MoodLedger — Documento Técnico de Requisitos de Software

**Versão:** 0.1.0 · **Status:** baseline do MVP · **Data:** 2026-09-15

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

## 7. Referências iniciais

- **R1:** Faurholt-Jepsen et al. *Portable technologies for digital phenotyping of bipolar disorder: A systematic review*. Journal of Affective Disorders, 2021. DOI: 10.1016/j.jad.2021.08.052.
- **R2:** *Recommendations for Research and Clinical Implementation of Ambulatory Assessment...*. PubMed, 2026. https://pubmed.ncbi.nlm.nih.gov/42228842/.
- **R3:** World Health Organization. *Bipolar disorder*. https://www.who.int/news-room/fact-sheets/detail/bipolar-disorder.
- **R4:** Flutter. *Build and release a web app*. https://docs.flutter.dev/deployment/web.
- **R5:** GitHub. *Deploying your website automatically*. https://docs.github.com/en/get-started/start-your-journey/deploying-your-website-automatically.

