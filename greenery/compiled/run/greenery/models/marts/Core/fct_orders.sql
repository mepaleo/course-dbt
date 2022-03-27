

  create  table "dbt"."dbt_meaghan_p"."fct_orders__dbt_tmp"
  as (
    

with order_item_products as
(SELECT
  order_id,
  sum(quantity) as quantity_prods_in_order
FROM "dbt"."dbt_meaghan_p"."dim_order_items"
GROUP BY order_id)

SELECT
  o.order_id,
  o.user_id,
  o.order_total,
  o.shipping_service,
  o.est_deliver_date,
  o.delivered_date,
  (o.delivered_date-o.est_deliver_date) as delivery_timeliness,
  o.order_creation_date,
  oi.quantity_prods_in_order,
  p.discount,
  case 
  when o.promo_id is null then 0
  else 1 end as promo_usage
FROM "dbt"."dbt_meaghan_p"."stg_orders" o
LEFT JOIN order_item_products oi
ON o.order_id=oi.order_id
LEFT JOIN "dbt"."dbt_meaghan_p"."stg_promos" p
ON o.promo_id=p.promo_id
GROUP BY
  o.user_id,
  o.order_id,
  o.order_creation_date,
  o.user_id,
  o.order_total,
  o.shipping_service,
  o.est_deliver_date,
  o.delivered_date,
  oi.quantity_prods_in_order,
  o.promo_id,
  p.discount
  );