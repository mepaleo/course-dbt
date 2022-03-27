

  create  table "dbt"."dbt_meaghan_p"."users_order_facts__dbt_tmp"
  as (
    

SELECT 
  u.full_name,
  u.user_id,
  u.repeat_customer,
  u.address,
  u.zipcode,
  u.state,
  u.email,
  o.order_total,
  o.shipping_service,
  max(o.delivery_timeliness) as max_delivery_delay,
  round(avg(o.quantity_prods_in_order),0) as average_product_quantity,
  sum(promo_usage) as count_promos_used
FROM "dbt"."dbt_meaghan_p"."dim_users" u  
LEFT JOIN "dbt"."dbt_meaghan_p"."fct_orders" o
ON u.user_id=o.user_id
GROUP BY
  u.user_id,
  u.full_name,
  u.user_registered_date,
  u.repeat_customer,
  u.address,
  u.zipcode,
  u.state,
  u.email,
  o.order_id,
  o.order_total,
  o.shipping_service,
  u.user_registered_date
  );