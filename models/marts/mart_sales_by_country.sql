-- Sales by Country Mart
-- Geographic breakdown for map visualization in Looker

select
    country,
    
    -- Customer metrics
    count(distinct user_id) as unique_customers,
    
    -- Order metrics
    count(distinct order_id) as total_orders,
    sum(quantity) as units_sold,
    
    -- Revenue
    sum(line_total_cents) as revenue_cents,
    round(sum(line_total_cents) / 100.0, 2) as revenue_dollars,
    
    -- Averages
    round(sum(line_total_cents) / count(distinct order_id) / 100.0, 2) as aov_dollars,
    round(sum(line_total_cents) / count(distinct user_id) / 100.0, 2) as revenue_per_customer_dollars

from {{ ref('fct_order_items') }}
group by 1
order by revenue_cents desc
