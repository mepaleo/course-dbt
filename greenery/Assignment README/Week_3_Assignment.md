PART 1:

1.Overall Conversion Rate: 62.46%
~~~SQL
SELECT 
  (cast(count(distinct case when order_id is not null then session_id else null end) as decimal)/
  cast(COUNT(distinct session_id) as decimal))*100 as conversion_rate
  FROM dbt."dbt_meaghan_p".fct_events
  ~~~

2. Conversion Rate by product: refer to "fct_product_conversions" model for SQL

Sorry - this is messy I was not sure how to insert a table. See the product name on the far left column & conversion rate in the far rate:

product_name,session_product_id,prod_checkout,prod_page_views,prod_added_to_cart,prod_package_shipped,prod_purchased,product_conversion
Alocasia Polly,6f3a3072-a24d-4d11-9cef-25b0b5f8a4af,21,54,27,20,21,38.89
Aloe Vera,615695d3-8ffd-4850-bcf7-944cf6d3685b,32,65,36,28,32,49.23
Angel Wings Begonia,58b575f2-2192-4a53-9d21-df9a0c14fc25,24,62,32,21,24,38.71
Arrow Head,74aeb414-e3dd-4e8a-beef-0fa45225214d,35,64,39,32,35,54.69
Bamboo,689fb64e-a4a2-45c5-b9f2-480c2155624d,36,69,42,34,36,52.17
Bird of Paradise,05df0866-1a66-41d8-9ed7-e2bbcddd6a3d,27,60,33,25,27,45.00
Birds Nest Fern,bb19d194-e1bd-4358-819e-cd1f1b401c0c,33,80,40,30,33,41.25
Boston Fern,e2e78dfc-f25c-4fec-a002-8e280d61a2f2,26,63,34,23,26,41.27
Cactus,c17e63f7-0d28-4a95-8248-b01ea354840e,30,55,32,29,30,54.55
Calathea Makoyana,b86ae24b-6f59-47e8-8adc-b17d88cbd367,27,53,32,26,27,50.94
Devil's Ivy,35550082-a52d-4301-8f06-05b30f6f3616,22,45,24,20,22,48.89
Dragon Tree,37e0062f-bd15-4c3e-b272-558a86d90598,29,62,34,29,29,46.77
Ficus,843b6553-dc6a-4fc4-bceb-02cd39af0168,29,68,35,27,29,42.65
Fiddle Leaf Fig,e706ab70-b396-4d30-a6b2-a1ccf3625b52,28,59,30,26,28,47.46
Jade Plant,a88a23ef-679c-4743-b151-dc7722040d8c,22,46,24,20,22,47.83
Majesty Palm,5ceddd13-cf00-481f-9285-8340ab95d06d,33,69,38,29,33,47.83
Money Tree,d3e228db-8ca5-42ad-bb0a-2148e876cc59,26,56,26,25,26,46.43
Monstera,be49171b-9f72-4fc9-bf7a-9a52e259836b,25,49,26,23,25,51.02
Orchid,c7050c3b-a898-424d-8d98-ab0aaad7bef4,34,75,37,33,34,45.33
Peace Lily,e5ee99b6-519f-4218-8b41-62f48f59f700,27,67,35,24,27,40.30
Philodendron,55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3,30,63,32,25,30,47.62
Pilea Peperomioides,5b50b820-1d0a-4231-9422-75e7f6b0cecf,28,60,32,25,28,46.67
Pink Anthurium,80eda933-749d-4fc6-91d5-613d29eb126f,31,74,37,29,31,41.89
Ponytail Palm,e18f33a6-b89a-4fbc-82ad-ccba5bb261cc,28,71,30,28,28,39.44
Pothos,4cda01b9-62e2-46c5-830f-b7f262a58fb1,21,64,24,20,21,32.81
Rubber Plant,579f4cd0-1f45-49d2-af55-9ab2b72c3b35,28,56,32,27,28,50.00
Snake Plant,e8b6528e-a830-4d03-a027-473b411c7f02,29,73,34,24,29,39.73
Spider Plant,64d39754-03e4-4fa0-b1ea-5f4293315f67,28,59,30,23,28,47.46
String of pearls,fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80,39,65,44,38,39,60.00
ZZ Plant,b66a7143-c18a-43bb-b5dc-06bb5d1d3160,34,65,35,31,34,52.31

PART 2:
Created the macro:{% set event_types = dbt_utils.get_query_results_as_dict("select DISTINCT event_type from" ~ ref('fct_events')%} - which is in my int_sessions_events.sql model. I was not sure how to call a model from the "Macros" folder so I added to the model sql.

PART 3:
Created role for reporting and added the post hook and on-run-end in my dbt_project.yml - I'm not sure how to validate that this worked?

PART 4:
Installed dbt utils and applied it in my macro described above in part 2.
