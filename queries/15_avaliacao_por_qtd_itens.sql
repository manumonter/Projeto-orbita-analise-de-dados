-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Verificar se pedidos com mais itens têm avaliações piores
-- Hipótese: ✅ Maior número de itens no pedido têm mais chance de erro
--           e consequente avaliação negativa — CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

WITH itens_por_pedido AS (
    SELECT
        order_id,
        COUNT(*) AS qtd_itens
    FROM
        main.olist_order_items_dataset
    GROUP BY order_id
),
notas_por_pedido AS (
    SELECT
        order_id,
        review_score
    FROM
        main.order_reviews
),
juncao AS (
    SELECT
        i.order_id,
        i.qtd_itens,
        n.review_score AS nota
    FROM itens_por_pedido i
    JOIN notas_por_pedido n ON i.order_id = n.order_id
),
faixas AS (
    SELECT
        *,
        CASE
            WHEN qtd_itens = 1 THEN '1 item'
            WHEN qtd_itens BETWEEN 2 AND 3 THEN '2-3 itens'
            WHEN qtd_itens BETWEEN 4 AND 5 THEN '4-5 itens'
            ELSE '6+ itens'
        END AS faixa_qtd_itens
    FROM juncao
)
SELECT
    faixa_qtd_itens,
    COUNT(*) AS total_pedidos,
    ROUND(AVG(nota), 2) AS media_avaliacao
FROM
    faixas
GROUP BY faixa_qtd_itens
ORDER BY faixa_qtd_itens;
