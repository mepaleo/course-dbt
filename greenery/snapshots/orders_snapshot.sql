{% snapshot orders_snapshot %}
    {{
        config(
        target_schema='snapshots',
        unique_key='order_id',
        strategy='check',
         check_cols=['status','shipping_service'],
)
}}
SELECT * FROM {{ source('source', 'orders') }}
{% endsnapshot %}