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
        {{ column_two_group_categorization('type','Food & Drink','Lifestyle & Goods') }}

    from source

)

select * from renamed
