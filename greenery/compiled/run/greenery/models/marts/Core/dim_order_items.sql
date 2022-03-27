

  create  table "dbt"."dbt_meaghan_p"."dim_order_items__dbt_tmp"
  as (
    
    select 
        order_id,
        product_id,
        quantity
FROM "dbt"."dbt_meaghan_p"."stg_order_items"
  );