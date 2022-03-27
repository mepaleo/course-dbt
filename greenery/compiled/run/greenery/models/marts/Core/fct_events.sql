

  create  table "dbt"."dbt_meaghan_p"."fct_events__dbt_tmp"
  as (
    

with ordered_products as(
select
oi.product_id as ordered_product_id,
ev.order_id
FROM "dbt"."dbt_meaghan_p"."stg_order_items" oi
LEFT JOIN "dbt"."dbt_meaghan_p"."stg_events" ev
ON ev.order_id=oi.order_id
)
  select 
    ev.event_id,
    ev.session_id,
    ev.user_id,
    ev.page_url,
    ev.created_at_utc,
    ev.event_type,
    ev.order_id,
    (case when ev.product_id is null then op.ordered_product_id else ev.product_id end) as session_product_id,
    max(created_at_utc) AS last_session_event_time,
    min(created_at_utc) AS first_session_event_time
FROM "dbt"."dbt_meaghan_p"."stg_events" ev
LEFT JOIN ordered_products op
ON ev.order_id=op.order_id
group by 
    ev.event_id,
    ev.session_id,
    ev.user_id,
    ev.page_url,
    ev.created_at_utc,
    ev.event_type,
    ev.order_id,
    ev.product_id,
    op.ordered_product_id
  );