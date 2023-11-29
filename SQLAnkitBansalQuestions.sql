<h3> A. Customer Journey </h3>
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.
Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!

SELECT * 
FROM foodie_fi.subscriptions s
LEFT JOIN foodie_fi.plans p
ON p.plan_id = s.plan_id
WHERE customer_id IN(1,2,11,13,15,16,18,19)
ORDER BY customer_id, start_date;
