
with

source as (

    select * from {{ source('gaslamp_goods', 'raw_supplies') }}

),

renamed as (

    select

        ----------  ids
        {{ dbt_utils.generate_surrogate_key(['supply_id', 'product_id']) }} as supply_uuid,
        supply_id,
        product_id,

        ---------- properties
        supply_cost

    from source

)

select * from renamed