Week 2 Assignment:

- Part 1, Models:

>> What is our user repeat rate?: 79.84%
~~~SQL
--- Identify the number of purchases (orders) made by each user:
with user_order_count as
(SELECT
  user_id,
  count(distinct(order_id)) as order_count
FROM dbt."dbt_meaghan_p".stg_orders
GROUP BY user_id),

--- Count number of repeat, one time and total customers
repeat_user_count as 
(SELECT
sum(case when order_count>=2 then 1 end) as repeat_user,
sum(case when order_count<2 then 1 end) as one_time_user,
sum(case when order_count>0 then 1 end) as all_users
FROM user_order_count)

---Calculate the repeat rate

select 
cast(repeat_user as decimal)/cast(all_users as decimal)*100 as repeat_rate
from repeat_user_count
~~~

>> What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Good indicators of a user who will likely purchase again might be:
- If they receive a promotion code/discount
- There may be certain products that people tend to buy on a more scheduled basis (e.g. may buy plant one time but may buy plant food every couple of months). 
- Perhaps there are environmental factors where the plants we sell may sell better in certain climates so zipcode/state may indicate likelihood of repurchase

Indicators of a user who would not purchase again might be:
- If their first order was delayed (for example time for order date to deliver date is relatively longer or order was delivered after estimated delivery).
- Similar to the above if there is a certain climate where our plants do not thrive, certain state/zipcodes may indicate users are likely not to purchase again.

If I had more data, I would like to know:
- More demographic details like customer birthday/age
- Navigation path (if customers come directly to our site, vs. searching for a product on google then navigating to our site - would think that those who come direclty are more likley to repeat. And would target those who are coming through searches so they would come direclty to our site in the future)

>>Explain the marts models you added. Why did you organize the models in the way you did?

Core:
  -dim_products - contains product information and also created a field for count of times the product was in an order.
  -dim_users - Contains user details with slight transformation including Full Name field. Here, I created a field to flag whether or not the user was a repeat purchaser (based on orders table) and created a field to identify the date of the users first order and how long they were users before their first purhcase. I also joined users with address table to have address information for each user.
  -fcts_events - no additional transformation from the staging table.
  -fct_orders - Created fields including the number of products in each order, calculation of delivery timeliness (negative days would be that the shipment was delivered earlier than expected, positive would indicate it was delivered later than expected), as well as a field to flag whether or not a promo was used.

Marketing:
- user_order_facts - this is a join of the user and orders, As marketing is typically targeted at the user level this table includes the demogrpahic user information at the user level and includes the order stats for each user.  

Products:
- fct_page_views - details from events table where the event was a page view.
- int_sessions_timing - created to capture the start/end of each user session.
- fct_user_session - event-level details which captures the first/last event in each session.
(Note: I think i could work on this to be at the session level instead of event level.)

Tests:

What assumptions are you making about each model? (i.e. why are you adding each test?)
- ID fields should not be blank
- Primary key fields should be unique
- For fields that I created with known values, you can test specifically that the field only has those defined values.

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
- I ran a negative test to ensure my "accepted values" test was working so I forced that in order to see a failure. However, I did not identify any bad data. I struggled with some of the custom tests that I tried but I imagine with more custom tests, bad data may be identified.

Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

In order to ensure data is kept up to date, I would include "source freshness" steps as part of the daily data load which I imagine could be automated in some manner. This would also mean ensuring that each of the source tables has a last update field in order for freshness to be tested. To ensure tests are passed regularly, I would research an failed tests to determine the root of the failure- is it failing based on the source data, or somewhere else in the model - and resolve the issue as far upstream as possible to prevent future failures. 