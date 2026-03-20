-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Verificar se vendedores com mais vendas têm piores avaliações
-- Hipótese: ❌ Vendedores com maiores vendas têm mais avaliações negativas — NÃO CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

WITH reviews_unicos AS (
    SELECT
        order_id,
        review_score
    FROM main.order_reviews
    GROUP BY order_id, review_score
),
vendas_e_avaliacoes AS (
    SELECT
        oi.seller_id,
        COUNT(DISTINCT oi.order_id) AS qtd_vendas,
        AVG(r.review_score) AS media_avaliacao
    FROM
        main.olist_order_items_dataset oi
    JOIN
        reviews_unicos r ON oi.order_id = r.order_id
    GROUP BY oi.seller_id
)
SELECT
    CASE
        WHEN media_avaliacao >= 3 THEN '>= 3'
        ELSE '< 3'
    END AS faixa_avaliacao,
    COUNT(DISTINCT seller_id) AS total_vendedores,
    SUM(qtd_vendas) AS total_vendas,
    ROUND(AVG(media_avaliacao), 2) AS media_avaliacao_faixa
FROM vendas_e_avaliacoes
GROUP BY faixa_avaliacao
ORDER BY faixa_avaliacao DESC;
