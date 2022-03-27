
  create view "dbt"."dbt_meaghan_p"."stg_products__dbt_tmp" as (
    
    select 
        product_id,
        name,
        price,
        inventory
FROM dbt.public.products
  );