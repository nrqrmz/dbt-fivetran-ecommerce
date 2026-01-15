-- Staging model for orders
-- Filters to only completed orders (excludes active carts)

select
    id as order_id,
    user_id,
    status,
    created_at,
    updated_at as completed_at  -- updated_at is the purchase timestamp for completed orders
from {{ source('rails_app', 'orders') }}
where status = 'completed'  -- Only include checked out orders, not active carts
