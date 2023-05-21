with 
    fonte_motivo_venda as (
        select *
        from {{ source('source_adventure','sales_salesreason') }}
    )

    , rev_motivo_venda as (
        select
            cast(salesreasonid as int) as id_motivo_venda									
            , cast(name as string) as motivo_venda		
            , cast(reasontype as string) as categoria_motivo																	    
    from fonte_motivo_venda
)

select *
from rev_motivo_venda