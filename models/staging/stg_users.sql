-- Staging model for users (customers)
-- Cleans and standardizes raw user data from Rails app

select
    id as user_id,
    email,
    name as customer_name,
    country,
    created_at,
    updated_at
from {{ source('rails_app', 'users') }}
