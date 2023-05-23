with 
    detalhes_pedido_venda as (
        select *		
        from {{ ref('int_total_negociado__detalhe_ordem') }}
    )
    
    , produtos as (
        select *		
        from {{ ref('dim_produtos') }}
    )

    , clientes as (
        select *
        from {{ ref('dim_clientes') }}
    )

    , regiao as (
        select *
        from {{ ref('dim_regiao') }}
    )

    , motivo_venda as (
        select *
        from {{ ref('dim_motivo_venda') }}
    )

    , cartao_credito as (
        select *
        from {{ ref('dim_cartao_credito') }}
    )

    , joining_fatos as (
        select
            detalhes_pedido_venda.id_pedido_venda
            , detalhes_pedido_venda.id_detalhe_pedido
            , cartao_credito.sk_cartao_credito as fk_cartao_credito
            , produtos.sk_produto as fk_produto
            , clientes.sk_cliente as fk_cliente
            , motivo_venda.sk_motivo_venda as fk_motivo_venda
            , regiao.sk_endereco as fk_endereco
            , detalhes_pedido_venda.qtde_pedido 					
            , detalhes_pedido_venda.valor_unitario
            , detalhes_pedido_venda.desconto_valorunit	
            , detalhes_pedido_venda.data_pedido		
            , detalhes_pedido_venda.data_vencimento_pedido
            , detalhes_pedido_venda.data_envio_pedido	
            , detalhes_pedido_venda.status				
            , detalhes_pedido_venda.id_vendedor							
            , detalhes_pedido_venda.id_metodo_envio			
            , detalhes_pedido_venda.subtotal				
            , detalhes_pedido_venda.imposto				
            , detalhes_pedido_venda.frete				
            , detalhes_pedido_venda.total_devido
            , cartao_credito.tipo_cartao
            , clientes.primeiro_nome
            , clientes.nome_meio
            , clientes.ultimo_nome
            , motivo_venda.motivo_venda
            , produtos.prod_nome 
            , produtos.prod_custo_venda	
            , regiao.cidade
            , regiao.cod_estado
            , regiao.nome_estado
            , regiao.cod_estado_pais
            , regiao.nome_estado_pais

        from detalhes_pedido_venda
        left join produtos on detalhes_pedido_venda.id_produto = produtos.id_produto
        left join clientes on detalhes_pedido_venda.id_cliente = clientes.id_cliente
        left join regiao on detalhes_pedido_venda.id_endereco_envio = regiao.id_endereco
        left join motivo_venda on detalhes_pedido_venda.id_motivo_venda = motivo_venda.id_motivo_venda
        left join cartao_credito on detalhes_pedido_venda.id_cartao_credito = cartao_credito.id_cartao_credito
    )
    
    , transformacoes as (
        select
            *
            , valor_unitario * qtde_pedido as valor_bruto
            , (1 - desconto_valorunit) * valor_unitario*qtde_pedido as valor_liquido
            , case 
                when desconto_valorunit > 0 then true
                when desconto_valorunit = 0 then false
                else false
                end as tem_desconto
            
        from joining_fatos
     
    )

select *
from transformacoes
