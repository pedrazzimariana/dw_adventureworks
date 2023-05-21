with 
    fonte_ordem_motivo_venda as (
        select *
        from {{ source('source_adventure','sales_salesorderheadersalesreason') }}
    )

    , rev_ordem_motivo_venda as (
        select
            cast(salesorderid as numeric) as idmotivo_pedido_venda									
            , cast(salesreasonid as int) as fk_motivo_venda																	    
    from fonte_ordem_motivo_venda
)

select *
from rev_ordem_motivo_venda