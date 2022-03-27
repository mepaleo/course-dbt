
  create view "dbt"."dbt_meaghan_p"."stg_users__dbt_tmp" as (
    
    select 
        user_id,
        address_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at as user_registered_date,
        updated_at as user_updated_date
FROM dbt.public.users
  );