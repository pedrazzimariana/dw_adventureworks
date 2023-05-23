with 
    fonte_estado as (
        select *
        from {{ source('source_adventure','person_stateprovince') }}
    )

    , rev_estado as (
        select
            cast(stateprovinceid as int) as id_estado				
            , cast(stateprovincecode as string) as cod_estado		
            , cast(countryregioncode as string) as cod_estado_pais					
            , cast(name as string) as nome_estado		
            , cast(territoryid as int) as id_territorio																						    
    from fonte_estado
)

select *
from rev_estado