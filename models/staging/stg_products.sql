-- Staging model for products
-- Cleans and standardizes raw product data, converts cents to dollars

select
    id as product_id,
    name as product_name,
    category,
    price_cents,
    round(price_cents / 100.0, 2) as price_dollars,
    created_at
from {{ source('rails_app', 'products') }}
