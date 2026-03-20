-- ============================================================
-- Projeto: Mercado Órbita
-- Objetivo: Calcular percentual de atraso por categoria de produto
-- Hipótese: ❌ Produtos frágeis/grandes/refrigerados tendem a ter transporte
--           mais complexo — NÃO CONFIRMADA
-- Autor: Emanuelly Monteiro
-- ============================================================

WITH pedidos_com_atraso AS (
    SELECT
        order_id,
        CASE
            WHEN order_delivered_customer_date >
            order_estimated_delivery_date THEN 1
            ELSE 0
        END AS pedido_atrasado
    FROM main.olist_orders_dataset
    WHERE
        order_delivered_customer_date IS NOT NULL
        AND order_estimated_delivery_date IS NOT NULL
),
categoria_por_pedido AS (
    SELECT
        ooid.order_id,
        opd.product_category_name AS categoria
    FROM main.olist_order_items_dataset ooid
    JOIN main.olist_products_dataset opd ON ooid.product_id = opd.product_id
    GROUP BY ooid.order_id, opd.product_category_name
)
SELECT
    cpp.categoria,
    COUNT(DISTINCT pca.order_id) AS total_pedidos,
    SUM(pca.pedido_atrasado) AS pedidos_com_atraso,
    ROUND((SUM(pca.pedido_atrasado) * 100.0) / COUNT(DISTINCT pca.order_id), 2) AS percentual_atrasados
FROM pedidos_com_atraso pca
JOIN categoria_por_pedido cpp ON pca.order_id = cpp.order_id
GROUP BY cpp.categoria
ORDER BY percentual_atrasados DESC;
