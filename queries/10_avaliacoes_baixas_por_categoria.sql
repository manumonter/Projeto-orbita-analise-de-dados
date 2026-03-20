-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Identificar categorias com maior percentual de avaliações negativas
-- Hipótese: ✅ Regiões/categorias específicas concentram mais avaliações baixas
-- Autor: Emanuelly Monteiro
-- ============================================================

WITH categoria_por_pedido AS (
    SELECT DISTINCT ON (oi.order_id)
        oi.order_id,
        op.product_category_name,
        r.review_score
    FROM main.olist_order_items_dataset oi
    JOIN main.olist_products_dataset op ON oi.product_id = op.product_id
    JOIN main.order_reviews r ON oi.order_id = r.order_id
    ORDER BY oi.order_id, oi.order_item_id
)
SELECT
    product_category_name,
    COUNT(*) AS total_avaliacoes,
    SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END) AS notas_baixas,
    ROUND(100.0 * SUM(CASE WHEN review_score <= 2 THEN 1 ELSE 0 END) /
    COUNT(*), 2) AS percentual_baixas
FROM
    categoria_por_pedido
GROUP BY product_category_name
HAVING COUNT(*) > 30
ORDER BY percentual_baixas DESC;
