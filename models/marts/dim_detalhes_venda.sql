with 
    detalhe_pedido_venda as (
        select *		
        from {{ ref('stg_erp__detalhe_pedido_venda') }}
    )

    , motivo_venda as (
        select *
        from {{ ref('stg_erp__motivo_venda') }}
    )

    , cartao_credito as (
        select *
        from {{ ref('stg_erp__cartao_credito') }}
    )

    , ordem_pedido_venda as (
        select *
        from {{ ref('stg_erp__ordem_pedido_venda') }}
    )

    , joining_detalhe_pedido as (
        select
            row_number() over (order by detalhe_pedido_venda.id_pedido_venda) as sk_pedido_venda -- auto-incremental surrogate key
            , detalhe_pedido_venda.id_pedido_venda	
            , detalhe_pedido_venda.data_pedido		
            , detalhe_pedido_venda.data_vencimento_pedido
            , detalhe_pedido_venda.data_envio_pedido	
            , detalhe_pedido_venda.status_pedido				
            , detalhe_pedido_venda.fk_cliente				
            , detalhe_pedido_venda.fk_vendedor			
            , detalhe_pedido_venda.fk_territorio			
            , detalhe_pedido_venda.id_endereco_envio	
            , detalhe_pedido_venda.fk_metodo_envio		
            , detalhe_pedido_venda.fk_cartao_credito
            , detalhe_pedido_venda.subtotal				
            , detalhe_pedido_venda.imposto				
            , detalhe_pedido_venda.frete				
            , detalhe_pedido_venda.total_devido
            , motivo_venda.id_motivo_venda	
            , motivo_venda.motivo_venda		
            , motivo_venda.categoria_motivo	
            , cartao_credito.id_cartao_credito
            , cartao_credito.tipo_cartao
            , ordem_pedido_venda.idmotivo_pedido_venda	
            , ordem_pedido_venda.fk_motivo_venda				
        from detalhe_pedido_venda
        left join ordem_pedido_venda on ordem_pedido_venda.idmotivo_pedido_venda = detalhe_pedido_venda.id_pedido_venda
        left join motivo_venda on motivo_venda.id_motivo_venda = ordem_pedido_venda.fk_motivo_venda
        left join cartao_credito on cartao_credito.id_cartao_credito = detalhe_pedido_venda.fk_cartao_credito
    )

select *
from joining_detalhe_pedido