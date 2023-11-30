B. Data Analysis Questions
How many customers has Foodie-Fi ever had?
SELECT COUNT(DISTINCT(customer_id)) AS CustomerCount
FROM foodie_fi.subscriptions s;

| customercount |
| ------------- |
| 1000          |
======================================================================================================================================================================================================================

2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
  SELECT  EXTRACT(MONTH from start_date) AS MONTH, TO_CHAR(start_date, 'Month') AS MonthName,
  EXTRACT(YEAR from start_date) AS YEAR, COUNT(Customer_id) 
  FROM foodie_fi.subscriptions s
  WHERE plan_id = 0
  GROUP BY EXTRACT(MONTH from start_date), EXTRACT(YEAR from start_date), TO_CHAR(start_date, 'Month');

| month | monthname | year | count |
| ----- | --------- | ---- | ----- |
| 1     | January   | 2020 | 88    |
| 2     | February  | 2020 | 68    |
| 3     | March     | 2020 | 94    |
| 4     | April     | 2020 | 81    |
| 5     | May       | 2020 | 88    |
| 6     | June      | 2020 | 79    |
| 7     | July      | 2020 | 89    |
| 8     | August    | 2020 | 88    |
| 9     | September | 2020 | 87    |
| 10    | October   | 2020 | 79    |
| 11    | November  | 2020 | 75    |
| 12    | December  | 2020 | 84    |
======================================================================================================================================================================================================================

3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

    SELECT s.plan_id, plan_name, COUNT(Customer_id) 
    FROM foodie_fi.subscriptions s
    LEFT JOIN foodie_fi.plans p
    ON p.plan_id = s.plan_id
    WHERE EXTRACT(YEAR from start_date) > 2020
    GROUP BY plan_name, s.plan_id
    ORDER BY s.plan_id;

| plan_id | plan_name     | count |
| ------- | ------------- | ----- |
| 1       | basic monthly | 8     |
| 2       | pro monthly   | 60    |
| 3       | pro annual    | 63    |
| 4       | churn         | 71    |

======================================================================================================================================================================================================================
  
  
4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
  SELECT plan_id,  COUNT(Customer_id) AS customerChurn, 
    ROUND((1.0* COUNT(Customer_id)/(SELECT COUNT( DISTINCT (customer_id)) FROM foodie_fi.subscriptions))*100,1) AS churnpercentage
    FROM foodie_fi.subscriptions
    WHERE plan_id = 4
    GROUP BY plan_id;

| plan_id | customerchurn | churnpercentage |
| ------- | ------------- | --------------- |
| 4       | 307           | 30.7            |
  
======================================================================================================================================================================================================================
  
5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
  
    WITH CTE AS
    (
    SELECT *,
    LAG(plan_id) OVER(Partition by customer_id ORDER BY plan_id) AS prev_plan
    FROM foodie_fi.subscriptions
    )
    
    SELECT COUNT(customer_id) customerchurnaftertrial,
    ROUND((1.0* COUNT(Customer_id)/(SELECT COUNT( DISTINCT (customer_id)) FROM foodie_fi.subscriptions))*100,0) AS churnpercentage
    FROM CTE 
    WHERE prev_plan = 0 AND plan_id= 4;

| customerchurnaftertrial | churnpercentage |
| ----------------------- | --------------- |
| 92                      | 9               |
======================================================================================================================================================================================================================
  
6. What is the number and percentage of customer plans after their initial free trial?
  WITH CTE AS
 (
   SELECT *, LAG(plan_id) OVER(Partition by customer_id ORDER BY plan_id) AS prev_plan
   FROM foodie_fi.subscriptions
 )

SELECT p.plan_id, p.plan_name, COUNT(customer_id) AS Customeraftertrail,
ROUND((1.0* COUNT(Customer_id)/(SELECT COUNT( DISTINCT (customer_id)) FROM foodie_fi.subscriptions))*100,1) AS planpercentage
FROM CTE 
LEFT JOIN foodie_fi.plans p
ON p.plan_id = CTE.plan_id
WHERE prev_plan = 0 
GROUP BY p.plan_name, p.plan_id
ORDER BY p.plan_id

-- using RANK() Function
WITH rnk as
(
SELECT *, RANK() OVER(PARTITION BY customer_id ORDER BY start_date) as rnk
FROM foodie_fi.subscriptions s
)

SELECT s.plan_id, plan_name, COUNT(DISTINCT(customer_id)) AS "Customer_Count", 
ROUND((1.0*COUNT(DISTINCT(customer_id))/(SELECT COUNT(DISTINCT(customer_id)) FROM foodie_fi.subscriptions))*100,1) AS "Percentage"
FROM rnk r
LEFT JOIN foodie_fi.plans s
ON r.plan_id = s.plan_id
WHERE rnk = 2
GROUP BY s.plan_id, plan_name;


  | plan_id | plan_name     | customeraftertrail | planpercentage |
| ------- | ------------- | ------------------ | -------------- |
| 1       | basic monthly | 546                | 54.6           |
| 2       | pro monthly   | 325                | 32.5           |
| 3       | pro annual    | 37                 | 3.7            |
| 4       | churn         | 92                 | 9.2            |

======================================================================================================================================================================================================================
  
7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
8. How many customers have upgraded to an annual plan in 2020?
9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

