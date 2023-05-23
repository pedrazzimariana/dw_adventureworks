with 
    fonte_estado_pais as (
        select *
        from {{ source('source_adventure','person_countryregion') }}
    )

    , rev_estado_pais as (
        select
            cast(countryregioncode as string) as cod_estado_pais				
            , cast(name as string) as nome_estado_pais																										    
    from fonte_estado_pais
)

select *
from rev_estado_pais