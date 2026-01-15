-- Sales Summary Mart
-- Aggregated KPIs for Looker dashboard scorecards

select
    count(distinct order_id) as total_orders,
    count(distinct user_id) as unique_customers,
    sum(quantity) as total_units_sold,
    sum(line_total_cents) as total_revenue_cents,
    round(sum(line_total_cents) / 100.0, 2) as total_revenue_dollars,
    
    -- Average Order Value (AOV)
    round(sum(line_total_cents) / count(distinct order_id) / 100.0, 2) as aov_dollars,
    
    -- Average revenue per customer
    round(sum(line_total_cents) / count(distinct user_id) / 100.0, 2) as revenue_per_customer_dollars,
    
    -- Average items per order
    round(count(*) * 1.0 / count(distinct order_id), 2) as avg_items_per_order

from {{ ref('fct_order_items') }}
