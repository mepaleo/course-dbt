
  create view "dbt"."dbt_meaghan_p"."stg_addresses__dbt_tmp" as (
    

SELECT 
        address_id,
        address,
        zipcode,
        state,
        country
FROM dbt.public.addresses
  );