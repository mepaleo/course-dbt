Part 1:
Created below snapshot. I made an error in my original snapshot so the original ./delivery-update.sh no longer worked. However, I updated the data directly in the pgui query and updated other fields, including shipping service to make sure that I understood how this worked. 

~~~ SQL 
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
~~~

Part 2:

Within my metrics mart, I created both the mtc_product_funnel and mtc_product_funnel_conversion models which resulted in:
view_to_cart_conversion = 80.80%
cart_to_checkout_conversion = 77.30%
view_to_checkout_conversion = 62.46%

For all sessions, about 81% of users add an item to their cart in that session. However, once there is/are item(s) in their cart, they are only 77% likely to checkout in that session. In other words, about 23% of users add an item to the cart but do not check out. 

Exposure: 
Created exposures.yml and saw the dependent Product Funnel Dashboard in my DAG.

Part 3:

3A: I am thinking about moving into analytics engineering and I think what has made me most confident in pursuing next steps are the hard skills - including SQL, dbt, github, etc. Beyond the hard skills is just all of the lingo around it - model, mart, dag, etc. which will make me feel more comfortable in potential room full of people who are much more familiar with analytics engineering.

3B: This is totally outside my wheelhouse so I am not super familiar with what orchestration tools are available - so I will speak in high-level. I think real-time transactional data would be the most valuable for our e-commerce banners. Having data on every single user event - particulary length viewing a particular item/tracking return to viewing that same item - things like this might allow the that user to be targeted with certain deals on that specific product that might make them return to that specific page. Again, not sure if this is realistic, but in an ideal state.