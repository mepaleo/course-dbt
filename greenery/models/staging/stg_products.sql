{{
  config(
    materialized='view'
  )
}}
    select 
        product_id,
        name,
        price,
        inventory
FROM {{ source('source', 'products') }}