{{
  config(
    materialized='view'
  )
}}
    select 
        user_id,
        address_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at as created_at_utc,
        updated_at as updated_at_utc   
FROM {{ source('source', 'users') }}