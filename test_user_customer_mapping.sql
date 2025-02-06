SELECT user_id 
FROM user_customer_mapping 
WHERE user_id IS NULL OR customer_id IS NULL
