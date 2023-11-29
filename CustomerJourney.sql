A. Customer Journey 
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.
Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!

SELECT * 
FROM foodie_fi.subscriptions s
LEFT JOIN foodie_fi.plans p
ON p.plan_id = s.plan_id
WHERE customer_id IN(1,2,11,13,15,16,18,19)
ORDER BY customer_id, start_date;

| customer_id | plan_id | start_date               | plan_id | plan_name     | price  |
| ----------- | ------- | ------------------------ | ------- | ------------- | ------ |
| 1           | 0       | 2020-08-01T00:00:00.000Z | 0       | trial         | 0.00   |
| 1           | 1       | 2020-08-08T00:00:00.000Z | 1       | basic monthly | 9.90   |
| 2           | 0       | 2020-09-20T00:00:00.000Z | 0       | trial         | 0.00   |
| 2           | 3       | 2020-09-27T00:00:00.000Z | 3       | pro annual    | 199.00 |
| 11          | 0       | 2020-11-19T00:00:00.000Z | 0       | trial         | 0.00   |
| 11          | 4       | 2020-11-26T00:00:00.000Z | 4       | churn         |        |
| 13          | 0       | 2020-12-15T00:00:00.000Z | 0       | trial         | 0.00   |
| 13          | 1       | 2020-12-22T00:00:00.000Z | 1       | basic monthly | 9.90   |
| 13          | 2       | 2021-03-29T00:00:00.000Z | 2       | pro monthly   | 19.90  |
| 15          | 0       | 2020-03-17T00:00:00.000Z | 0       | trial         | 0.00   |
| 15          | 2       | 2020-03-24T00:00:00.000Z | 2       | pro monthly   | 19.90  |
| 15          | 4       | 2020-04-29T00:00:00.000Z | 4       | churn         |        |
| 16          | 0       | 2020-05-31T00:00:00.000Z | 0       | trial         | 0.00   |
| 16          | 1       | 2020-06-07T00:00:00.000Z | 1       | basic monthly | 9.90   |
| 16          | 3       | 2020-10-21T00:00:00.000Z | 3       | pro annual    | 199.00 |
| 18          | 0       | 2020-07-06T00:00:00.000Z | 0       | trial         | 0.00   |
| 18          | 2       | 2020-07-13T00:00:00.000Z | 2       | pro monthly   | 19.90  |
| 19          | 0       | 2020-06-22T00:00:00.000Z | 0       | trial         | 0.00   |
| 19          | 2       | 2020-06-29T00:00:00.000Z | 2       | pro monthly   | 19.90  |
| 19          | 3       | 2020-08-29T00:00:00.000Z | 3       | pro annual    | 199.00 |
