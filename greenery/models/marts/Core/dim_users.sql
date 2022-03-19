{{
  config(
    materialized='table'
  )
}}

with user_order_details as
(SELECT
  user_id,
  count(distinct(order_id)) as order_count,
  min(order_creation_date) as first_order_date
FROM dbt."dbt_meaghan_p".stg_orders
GROUP BY user_id)

SELECT
  u.user_id,
  concat(u.first_name,' ',u.last_name) as full_name,
  u.user_registered_date,
  u.user_updated_date,
  u.email,
  case 
  when uod.order_count >=2 then 'Repeat'
  when uod.order_count =1 then 'One-time'
  else 'Never'
  end as repeat_customer,
  a.address,
  a.zipcode,
  a.state,
  uod.first_order_date,
  (uod.first_order_date-u.user_registered_date) as length_as_customer_at_first_order
FROM {{ ref('stg_users') }} u
LEFT JOIN user_order_details uod
ON u.user_id = uod.user_id
LEFT JOIN {{ ref('stg_addresses') }} a
ON u.address_id=a.address_id