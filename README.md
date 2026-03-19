# Projeto Órbita
Case prático de negócio simulando um cenário real de dores operacionais críticas em um e-commerce. O objetivo foi transformar dados em insights acionáveis para apoiar decisões estratégicas da empresa.

## 🏢 Contexto do Negócio
**Empresa:** Mercado Órbita  
**Segmento:** E-commerce / Marketplace  
**Operação:** Vendas online com múltiplos lojistas e entregadores  
**Modelo de receita:** Comissão sobre vendas + serviço logístico próprio  

Nos últimos trimestres, a empresa identificou dores operacionais comprometendo seu crescimento e reputação. Este projeto foi desenvolvido para diagnosticar as causas raiz e propor soluções baseadas em dados.

## 🔴 O Problema 
O case trazia três indicadores com metas definidas pela diretoria. O primeiro passo da análise foi validar essas métricas diretamente na base de dados, e foi aí que surgiu o primeiro insight relevante: os números do case não batiam com a realidade dos dados.

| Indicador | Métrica do Case | Métrica Real (validada via SQL) |
|----------|----------------|----------------------------------|
| ⏱ **Atraso médio na entrega** | 2,3 dias | **10,62 dias** |
| ⭐ **Nota média de avaliação** | 4,1 | 4,1 ✓ |
| 🔁 **Taxa de clientes recorrentes** | 12% | **3,1%** |

O atraso médio estava 4x maior do que o apresentado, e a taxa de recorrência era de apenas 3,1%, não 12%. Isso impactou diretamente a definição das metas: seguir os alvos originais seria trabalhar com base em premissas falsas.
Essas três métricas estavam diretamente interligadas: atrasos geram avaliações ruins, que por sua vez reduzem a confiança e a recorrência dos clientes.

## 🎯 Metas Revisadas com Base nos Dados  
Com os indicadores reais em mãos, as metas originais foram reavaliadas. Seguir alvos calculados sobre números incorretos tornaria qualquer planejamento inviável. As novas metas foram definidas com base na evolução histórica dos dados:

O atraso médio caiu 44% entre 2016 e 2017. Esse ritmo embasou a projeção de redução para 6 dias.
A recorrência chegou a crescer quase 2 p.p. em um único ano, o que mostra que 4% é ambicioso, mas factível.

| Indicador | Situação Real | Meta Original | Meta Revisada |
|----------|---------------|--------------|---------------|
| ⏱ **Atraso médio na entrega** | 10,62 dias | ≤ 1,5 dia | **≤ 6 dias** |
| 🔁 **Clientes recorrentes** | 3,1% | ≥ 17% | **≥ 4%** |
| ⭐ **Nota média de avaliação** | 4,1 | ≥ 4,4 | **≥ 4,4** |

## 🔬 Abordagem Analítica  
O projeto seguiu três fases principais:  
1. Planejamento     → Canvas com objetivo, métricas, hipóteses e roadmap
2. Execução Técnica → SQL no DBeaver + Dashboards no Power BI
3. Storytelling     → Apresentação executiva com insights e recomendações  

**Perguntas norteadoras investigadas:**

1. Quais fatores influenciam diretamente o atraso de entregas?  
2. Quais padrões existem nas avaliações baixas? Produtos, regiões, logística?
3. Que perfis de clientes têm mais chance de realizar uma nova compra?
4. Qual seria o impacto financeiro de melhorar os prazos de entrega?
5. Quais ações priorizar para alcançar as metas da empresa?

## ✅ Hipóteses e Validações  

**1️⃣ Atrasos nas Entregas**

| Hipótese | Resultado |
|---------|-----------|
| Regiões mais afastadas do eixo têm maior % de atraso | ✅ Confirmada |
| Pedidos com mais tempo de separação tendem a atrasar | ✅ Confirmada |
| Produtos frágeis/grandes têm transporte mais complexo e mais atraso | ❌ Refutada |
| Maior número de itens no pedido gera mais atraso | ❌ Refutada |

**2️⃣ Avaliações Baixas**

| Hipótese | Resultado |
|---------|-----------|
| HipóteseResultadoAtrasos influenciam negativamente as avaliações | ✅ Confirmada |
| Pedidos com mais itens têm mais chance de erros e avaliações negativas | ✅ Confirmada |
| Regiões mais afastadas têm maior % de notas 1 e 2 | ✅ Confirmada |
| Vendedores com mais vendas têm mais avaliações negativas | ❌ Refutada |
