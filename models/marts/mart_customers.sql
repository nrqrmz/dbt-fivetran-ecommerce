-- Customer Leaderboard Mart
-- Customer lifetime value and purchase history for leaderboard

select
    user_id,
    customer_name,
    email,
    country,
    
    -- Purchase metrics
    count(distinct order_id) as total_orders,
    sum(quantity) as total_items_purchased,
    
    -- Lifetime value
    sum(line_total_cents) as lifetime_value_cents,
    round(sum(line_total_cents) / 100.0, 2) as lifetime_value_dollars,
    
    -- Average order value for this customer
    round(sum(line_total_cents) / count(distinct order_id) / 100.0, 2) as customer_aov_dollars,
    
    -- Timeline
    min(order_completed_at) as first_order_at,
    max(order_completed_at) as last_order_at

from {{ ref('fct_order_items') }}
group by 1, 2, 3, 4
order by lifetime_value_cents desc
