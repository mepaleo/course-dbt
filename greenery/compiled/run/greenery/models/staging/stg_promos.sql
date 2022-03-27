
  create view "dbt"."dbt_meaghan_p"."stg_promos__dbt_tmp" as (
    
    select 
        promo_id,
        discount,
        status  
FROM dbt.public.promos
  );