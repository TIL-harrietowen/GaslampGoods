with

source as (

    select * from {{ source('gaslamp_goods', 'raw_products') }}
),

renamed as (

    select

        ----------  ids
        sku as product_id,

        ---------- properties
        name as product_name,
        type as product_type,
        description as product_description,
        price as product_price,

        ---------- derived
        case
            when type != 'Food & Drink' then 1
            else 0
        end as is_lifestyle_and_goods,

        case
            when type = 'Food & Drink' then 1
            else 0
        end as is_food_and_drink

    from source

)

select * from renamed
