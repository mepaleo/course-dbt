{{
  config(
    materialized='view'
  )
}}
    select 
        promo_id,
        discount,
        status  
FROM {{ source('source', 'promos') }}