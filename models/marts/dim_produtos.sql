with 
    produtos as (
        select *		
        from {{ ref('stg_erp__produto') }}
    )

    , ordem_pedido_venda as (
        select *
        from {{ ref('stg_erp__pedido_venda') }}
    )

    , joining_produto as (
        select
            row_number() over (order by produtos.id_produto) as sk_produto -- auto-incremental surrogate key
            , produtos.id_produto
            , produtos.prod_id_subcategoria
            , produtos.prod_nome 		
            , produtos.prod_codigo								
            , produtos.prod_cor	
            , produtos.prod_estoque						
            , produtos.prod_custo_producao
            , produtos.prod_custo_venda								
            , produtos.prod_linha	
            , produtos.prod_classe			
            , produtos.vendaprod_data_inicio		
            , produtos.vendaprod_data_fim		
            , ordem_pedido_venda.id_pedido					
            , ordem_pedido_venda.id_detalhe_pedido										
            , ordem_pedido_venda.qtde_pedido 				
            , ordem_pedido_venda.pedido_id_produto										
            , ordem_pedido_venda.valor_unitario	
            , ordem_pedido_venda.desconto_valorunit	
        from ordem_pedido_venda
        left join produtos on produtos.id_produto = ordem_pedido_venda.pedido_id_produto
    )

select *
from joining_produto