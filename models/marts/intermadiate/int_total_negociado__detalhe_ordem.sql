with
     detalhe_pedido_venda as (
        select *		
        from {{ ref('stg_erp__detalhe_pedido_venda') }}
    )

    , pedido_venda as (
        select *		
        from {{ ref('stg_erp__pedido_venda') }}
    )

    , ordem_motivo_venda as (
        select *		
        from {{ ref('stg_erp__ordem_motivo_venda') }}
    )

    , joining_detalhe_pedido as (
        select
            pedido_venda.id_detalhe_pedido
            , pedido_venda.id_pedido_venda
            , pedido_venda.id_produto					
            , pedido_venda.qtde_pedido 					
            , pedido_venda.valor_unitario
            , pedido_venda.desconto_valorunit	
            , detalhe_pedido_venda.data_pedido		
            , detalhe_pedido_venda.data_vencimento_pedido
            , detalhe_pedido_venda.data_envio_pedido	
            , detalhe_pedido_venda.status_pedido			
            , detalhe_pedido_venda.id_cliente				
            , detalhe_pedido_venda.id_vendedor			
            , detalhe_pedido_venda.id_territorio			
            , detalhe_pedido_venda.id_endereco_envio	
            , detalhe_pedido_venda.id_metodo_envio		
            , detalhe_pedido_venda.id_cartao_credito	
            , detalhe_pedido_venda.subtotal				
            , detalhe_pedido_venda.imposto				
            , detalhe_pedido_venda.frete				
            , detalhe_pedido_venda.total_devido
            , ordem_motivo_venda.id_motivo_venda			
        from pedido_venda 
        left join detalhe_pedido_venda on pedido_venda.id_pedido_venda = detalhe_pedido_venda.id_pedido_venda
        left join ordem_motivo_venda on detalhe_pedido_venda.id_pedido_venda = ordem_motivo_venda.id_pedido_venda
    )

    , transformacoes as (
        select
            *                
            , case
                when status_pedido = 1 then "Processando"
                when status_pedido = 2 then "Aprovado"
                when status_pedido = 3 then "Pendente"
                when status_pedido = 4 then "Recusado"
                when status_pedido = 5 then "Cancelado"
                else "sem_status"
                end as status
        from joining_detalhe_pedido
    )
    
select *
from transformacoes

