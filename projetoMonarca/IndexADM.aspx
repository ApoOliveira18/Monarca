<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="IndexADM.aspx.cs" Inherits="IndexADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>

        .superior-conteudo {
            height: 525px;
        }

        .top-vendas {
        
            width: 37.5%;
            margin-left:2.5%;
            float:left;
            height:500px;
            background: #fff;
            border: 1px solid #000;

        }

          .top-clientes {
        
            width: 55%;
            margin-left:2.5%;
            float:left;
            height:500px;
            background: #fff;
            border: 1px solid #000;

        }
           .financeiro {
        
            width: 95%;
            margin: 0 auto;
            height:500px;
            background: #fff;
            border: 1px solid #000;

        }
        .cad {
            height: 30px ;
            width: 90%;
            margin: 0 auto;
            float: left;
            margin-left: 10px;
            color: #fff;
            font-size: 2.5em;
            font-family: "Century Gothic";
            padding: 2%;
            border: 1px solid #333;
            transition: ease-in 0.3s;
            border-radius: 3em;
            margin-bottom: 20px;
        }
        .img-adm {
        background: url(../images/logo-email.png);
        float: left;
        height: 128px;
        width: 128px;
        }
        .linha-adm {
        height: 128px;
        width: 1px;
        float: left;
        margin-left: 10px;
        margin-right: 10px;
        background-color: #ccc;
        }
        .texto-adm {
        font-size: 2em;
        margin-top: 45px;
        }



    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Home</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
      <br />
      <br />
     <br />

<div class="img-adm"></div>
<div class="linha-adm"></div>
<div class="texto-adm">Setor Administrativo</div>

     </div>
     </div>
     </div>

    <asp:SqlDataSource ID="sqlDataFunc" runat="server" ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" SelectCommand="SELECT id_func, email_func, data_conta FROM funcionario"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sqlPesquisaRegistrosADM" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM registrosadm" 
        DeleteCommand="DELETE FROM registrosadm WHERE (id_registros = @cod)">
        <DeleteParameters>
            <asp:SessionParameter Name="cod" SessionField="idRegistro" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPesquisaRegistrosLogin" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        DeleteCommand="DELETE FROM registrologin WHERE (id_registrosLogin = @cod)" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM registrologin">
        <DeleteParameters>
            <asp:SessionParameter Name="cod" SessionField="idRegistroLOGIN" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPesquisaRegistroFunc" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        DeleteCommand="DELETE FROM registrosfunc WHERE (id_registrosFunc = @cod)" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM registrosfunc">
        <DeleteParameters>
            <asp:SessionParameter Name="cod" SessionField="idRegistroFUNC" />
        </DeleteParameters>
    </asp:SqlDataSource>

     <asp:SqlDataSource ID="sqlBuscaTopClientes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        SelectCommand="SELECT venda.total_venda, cliente.nome_cli, venda.id_venda FROM venda INNER JOIN cliente ON venda.id_cli = cliente.id_cli GROUP BY venda.id_cli ORDER BY venda.total_venda DESC"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, promocao.titulo_promo, promocao.desconto, ml.adicional FROM produto INNER JOIN promocao ON produto.id_promo = promocao.id_promo INNER JOIN ml ON produto.id_ml = ml.id_ml WHERE (produto.id_prod = 1)">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDaLinha" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        SelectCommand="SELECT linha.id_promo, linha.tipo_linha, promocao.desconto, promocao.titulo_promo FROM linha INNER JOIN promocao ON linha.id_promo = promocao.id_promo WHERE (linha.id_linha = @cod)">
        <SelectParameters>
            <asp:SessionParameter Name="cod" SessionField="codLinhaRelacionada" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoGenero" runat="server" ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" SelectCommand="SELECT genero.id_genero, genero.id_promo, genero.tipo_genero, promocao.titulo_promo, promocao.desconto FROM genero INNER JOIN promocao ON genero.id_promo = promocao.id_promo WHERE (genero.id_genero = @cod)">
        <SelectParameters>
            <asp:SessionParameter Name="cod" SessionField="codGeneroRelacionado" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

