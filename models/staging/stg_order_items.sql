-- Staging model for order items
-- Cleans and standardizes line item data, converts cents to dollars

select
    id as order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price_cents,
    round(unit_price_cents / 100.0, 2) as unit_price_dollars,
    created_at
from {{ source('rails_app', 'order_items') }}
