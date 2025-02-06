WITH user_data AS (
    SELECT 
        user_id, 
        email, 
        created_at AS user_created_date
    FROM backend_users
), 

stripe_data AS (
    SELECT 
        customer_id, 
        subscription_id, 
        email AS stripe_email, 
        amount_paid, 
        status AS subscription_status,
        created_at AS stripe_created_date
    FROM stripe_subscriptions
),

joined_data AS (
    SELECT 
        u.user_id, 
        s.customer_id, 
        s.subscription_id, 
        COALESCE(s.stripe_email, u.email) AS email, 
        s.amount_paid, 
        s.subscription_status,
        u.user_created_date, 
        s.stripe_created_date
    FROM user_data u
    	LEFT JOIN stripe_data s 
ON u.email = s.stripe_email
)

SELECT * FROM joined_data
