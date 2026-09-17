# Governança de privacidade e LGPD — etapa 2

Status: requisitos de governança e consentimento granular implementados no protótipo; não autoriza uso clínico.

## Classificação e minimização

O MoodLedger trata autorrelatos de humor, energia, sono e impulsividade como
dados pessoais sensíveis relacionados à saúde. Gastos e motivos podem revelar
hábitos e contexto pessoal. O produto deve coletar somente o necessário para
o objetivo declarado de apoiar a revisão longitudinal, sem inferir diagnóstico
ou fase bipolar. A minimização reduz exposição e superfície de ataque [1][2].

| Dado | Finalidade | Armazenamento atual | Regra |
|---|---|---|---|
| Autorrelato de humor/energia/sono | revisão pelo próprio usuário | local Android | obrigatório consentimento explícito; sem inferência |
| Gasto e motivo | reflexão sobre padrão financeiro | local Android | registrar apenas campos necessários |
| Código de vínculo | demonstração de compartilhamento | memória/local | revogável; não é identidade clínica |
| Exportação JSON | portabilidade no protótipo | clipboard do dispositivo | ação explícita; usuário controla destino |

## Requisitos de privacidade

- RF-PRIV-01: explicar finalidade, dados, riscos e limitações antes da coleta.
- RF-PRIV-02: consentimento deve ser granular, livre, informado, inequívoco,
  revogável e registrado com data, versão do texto e escopo.
- RF-PRIV-03: revogação deve interromper o compartilhamento futuro e oferecer
  exclusão local dos dados mantidos pelo protótipo.
- RF-PRIV-04: disponibilizar exportação legível e confirmação antes de copiar
  dados para outro aplicativo.
- RF-PRIV-05: não coletar identificadores, localização, contatos ou sensores
  passivos sem finalidade aprovada e requisito específico.
- RF-PRIV-06: separar dados de demonstração de dados clínicos reais e bloquear
  mensagens que apresentem tendência como diagnóstico.
- RF-PRIV-07: documentar retenção; até existir política aprovada, manter dados
  somente no dispositivo e permitir eliminação pelo usuário.

- RF-PRIV-08: oferecer exclusão local explícita de registros, consentimentos e
  vínculo, com confirmação e feedback após a operação.

## Papéis e limites

Antes de backend, estudo ou compartilhamento real, deve haver definição formal
de controlador, operador, encarregado, base legal, contrato, segurança,
incidentes, direitos do titular e avaliação ética. Este repositório não afirma
conformidade jurídica; registra requisitos técnicos para revisão especializada.

## Verificação

Os testes de widget atuais comprovam: consentimento de exportação e vínculo não
é presumido; exclusão remove registros e preserva estado navegável; e a
interface usa “autorrelato”, “tendência” e “padrão para revisão”. Testes remotos
de autorização e RLS continuam pendentes da implementação do backend e de suas
aprovações formais.

## Referências (ABNT)

[1] BRASIL. Lei nº 13.709, de 14 de agosto de 2018. Lei Geral de Proteção de
Dados Pessoais. Brasília, DF: Presidência da República, 2018. Disponível em:
<https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm>.
Acesso em: 15 set. 2026.

[2] NATIONAL INSTITUTE OF STANDARDS AND TECHNOLOGY. *NIST Privacy Framework:
A Tool for Improving Privacy through Enterprise Risk Management*. Version 1.0.
Gaithersburg: NIST, 2020. Disponível em:
<https://www.nist.gov/privacy-framework>. Acesso em: 15 set. 2026.
