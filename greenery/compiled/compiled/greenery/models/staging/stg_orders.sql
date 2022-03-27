
    select 
        order_id,
        user_id,
        promo_id,
        address_id,
        created_at as order_creation_date,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        date_trunc('day',estimated_delivery_at) as est_deliver_date,
        date_trunc('day',delivered_at) as delivered_date,
        status
FROM dbt.public.orders