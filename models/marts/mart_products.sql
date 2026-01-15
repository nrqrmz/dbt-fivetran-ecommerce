-- Product Performance Mart
-- Metrics per product for top sellers analysis and category breakdown

select
    product_id,
    product_name,
    category,
    unit_price_dollars,
    
    -- Sales metrics
    count(distinct order_id) as times_purchased,
    sum(quantity) as units_sold,
    count(distinct user_id) as unique_buyers,
    
    -- Revenue
    sum(line_total_cents) as revenue_cents,
    round(sum(line_total_cents) / 100.0, 2) as revenue_dollars,
    
    -- Average quantity per order
    round(sum(quantity) * 1.0 / count(distinct order_id), 2) as avg_quantity_per_order

from {{ ref('fct_order_items') }}
group by 1, 2, 3, 4
order by revenue_cents desc
