{{
  config(
    materialized='table'
  )
}}

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
    {{event_types(ref('stg_events'),'event_type')}}
FROM {{ ref('stg_events') }} ev
LEFT JOIN {{ ref('stg_order_items') }} oi
    ON ev.order_id = oi.order_id
LEFT JOIN {{ ref('stg_products') }} pr
    ON COALESCE(ev.product_id, oi.product_id) = pr.product_id
{{dbt_utils.group_by(n=9)}}