with 
    fonte_detalhe_pedido_venda as (
        select *
        from {{ source('source_adventure','sales_salesorderheader') }}
    )

    , rev_detalhe_pedido_venda as (
        select
            cast(salesorderid as numeric) as id_pedido_venda										
            , cast(orderdate as timestamp) as data_pedido					
            , cast(duedate as timestamp) as data_vencimento_pedido						
            , cast(shipdate as timestamp) as data_envio_pedido				
            , cast(status as int) as status_pedido												
            , cast(customerid as int) as fk_cliente					
            , cast(salespersonid as int) as fk_vendedor					
            , cast(territoryid as int) as fk_territorio						
            , cast(shiptoaddressid as int) as id_endereco_envio				
            , cast(shipmethodid	as int) as fk_metodo_envio				
            , cast(creditcardid	as int)	as fk_cartao_credito													
            , cast(subtotal	as numeric)	as subtotal				
            , cast(taxamt as numeric) as imposto						
            , cast(freight as numeric) as frete				
            , cast(totaldue	as numeric)	as total_devido								    
    from fonte_detalhe_pedido_venda
)

select *
from rev_detalhe_pedido_venda
