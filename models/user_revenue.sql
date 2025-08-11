WITH transactions AS (
    SELECT 
        customer_id, 
        SUM(amount_paid) AS total_revenue,
        COUNT(subscription_id) AS active_subscriptions,
        MAX(subscription_status) AS latest_status
    FROM user_customer_mapping
    WHERE subscription_status IN ('active', 'trial')
    GROUP BY 1
)

SELECT 
    u.user_id, 
    t.customer_id, 
    t.total_revenue, 
    t.active_subscriptions, 
    t.latest_status
FROM backend_users u
LEFT JOIN transactions t 
ON u.user_id = t.customer_id
