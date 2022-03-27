
  create view "dbt"."dbt_meaghan_p"."stg_order_items__dbt_tmp" as (
    
    select 
        order_id,
        product_id,
        quantity
FROM dbt.public.order_items
  );