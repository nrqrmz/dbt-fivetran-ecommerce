-- Fact table: Order items enriched with customer and product details
-- This is the main table for most revenue calculations

select
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    o.user_id,
    
    -- Customer details
    u.customer_name,
    u.email,
    u.country,
    
    -- Product details
    p.product_name,
    p.category,
    
    -- Transaction details
    oi.quantity,
    oi.unit_price_cents,
    oi.unit_price_dollars,
    (oi.unit_price_cents * oi.quantity) as line_total_cents,
    round((oi.unit_price_cents * oi.quantity) / 100.0, 2) as line_total_dollars,
    
    -- Timestamps
    o.completed_at as order_completed_at,
    date(o.completed_at) as order_date

from {{ ref('stg_order_items') }} oi
inner join {{ ref('stg_orders') }} o on oi.order_id = o.order_id
inner join {{ ref('stg_users') }} u on o.user_id = u.user_id
inner join {{ ref('stg_products') }} p on oi.product_id = p.product_id
