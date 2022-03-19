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
        created_at as user_registered_date,
        updated_at as user_updated_date
FROM {{ source('source', 'users') }}