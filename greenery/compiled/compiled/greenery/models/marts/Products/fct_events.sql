

SELECT 
    ev.event_id,
    ev.session_id,
    ev.user_id,
    ev.created_at_utc,
    ev.order_id,
    COALESCE(ev.product_id, oi.product_id) AS product_id,
    pr.name AS product_name,
    pr.price,
    pr.inventory
    



,
SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart
,
SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout
,
SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view
,
SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shipped



FROM "dbt"."dbt_meaghan_p"."stg_events" ev
LEFT JOIN "dbt"."dbt_meaghan_p"."stg_order_items" oi
    ON ev.order_id = oi.order_id
LEFT JOIN "dbt"."dbt_meaghan_p"."stg_products" pr
    ON COALESCE(ev.product_id, oi.product_id) = pr.product_id
group by 1,2,3,4,5,6,7,8,9