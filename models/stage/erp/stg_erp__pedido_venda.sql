with 
    fonte_pedido_venda as (
        select *
        from {{ source('source_adventure','sales_salesorderdetail') }}
    )

    , rev_pedido_venda as (
        select					
            cast(salesorderdetailid as int) as id_detalhe_pedido
            , cast(salesorderid as int) as id_pedido_venda
            , cast(productid as int) as id_produto											
            , cast(orderqty as int) as qtde_pedido 										
            , cast(unitprice as numeric) as valor_unitario
            , cast(unitpricediscount as numeric) as desconto_valorunit														    
        from fonte_pedido_venda
    )

select *
from rev_pedido_venda
