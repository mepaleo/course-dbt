

SELECT
e.product_id as event_product_id,
e.event_type,
e.order_id,
e.session_id,
(oi.product_id) as ordered_product_id
FROM "dbt"."dbt_meaghan_p"."fct_events" e
LEFT JOIN "dbt"."dbt_meaghan_p"."dim_order_items" oi
ON e.order_id=oi.order_id