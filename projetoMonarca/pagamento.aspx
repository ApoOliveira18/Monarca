<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="pagamento.aspx.cs" Inherits="pagamento" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
h1{
    font-size: 3rem;
    line-height: 4.35rem;
    font-weight: 600;
    letter-spacing: .1em;
    text-transform: uppercase;
    margin: 0 auto;
    padding-top: 10px;
    color: #000;
    font-family: "Century Gothic";
    width:80%;
    }
    
      @media screen  and (max-width: 1023px)
    {
        .conteudo-produtos{
        float: left;
        margin-left: 5%;
        background-color: #fff;
        -webkit-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        -moz-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        margin-right: 10px;
        min-height: 400px;
        width: 90%;
        padding: 2%;
        }
        .resumo{
        width: 90%;
        height: 250px;
        float: right;
        margin-right: 5%;
        margin-top: 20px;
        background-color: #fff;
        -webkit-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        -moz-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        padding: 2%;
        }
                .cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
    height: 1000px;
}


</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
<br />
<h1>Pagamento</h1>
<br />
<br />
<div class="conteudo-produtos">
<h2>Forma de Pagamento:</h2>
        <br />
        <div class="linha-100"></div>
            <asp:RadioButtonList ID="rbFormasPag" runat="server" 
                onselectedindexchanged="rbFormasPag_SelectedIndexChanged" 
        AutoPostBack="True" DataSourceID="sqlFormaPagto" 
        DataTextField="tipo_pagto" DataValueField="id_pagto" >
                <asp:ListItem>Boleto</asp:ListItem>
                <asp:ListItem>Cartão de Crédito</asp:ListItem>
                
            </asp:RadioButtonList>

            <br />

        <div id="cartaoCredito" runat="server">
            <asp:DropDownList ID="ddlParcela" runat="server" AutoPostBack="True" 
                onselectedindexchanged="ddlParcela_SelectedIndexChanged" CssClass="ddls">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sqlFormaPagto" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT * FROM pagamento"></asp:SqlDataSource>
            <br />
        </div>

</div>

<div class="resumo">
        <h2>Resumo</h2>
        <br />
        <h4>Subtotal  <asp:Label ID="lblValorCompra" runat="server"></asp:Label></h4>
        <br />
        <h4>Frete   <asp:Label ID="lblValorFrete" runat="server"></asp:Label></h4>
        <br />
        <div class="linha-100"></div>
        <br />
        <h3>Total   R$   <asp:Label ID="lblValorTotal" runat="server"></asp:Label></h3>
        <p>&nbsp;</p>
             <asp:Label ID="lblParcela" class ="parcela" runat="server" 
            Font-Bold="True" Font-Size="Medium"></asp:Label>
        <br />
        <asp:Button ID="btnComprar" runat="server"  Text="Finalizar Compra" 
            CssClass="btnApp" onclick="btnComprar_Click" />

                    <asp:SqlDataSource ID="sqlItensComprados" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                        
                        SelectCommand="SELECT itens.id_itens, itens.qtd_item, produto.img_prod, produto.nome_prod, ml.desc_ml, genero.tipo_genero, itens.total_prod, itens.status FROM itens INNER JOIN produto ON itens.id_prod = produto.id_prod INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN genero ON produto.id_genero = genero.id_genero INNER JOIN venda ON itens.id_venda = venda.id_venda WHERE (itens.status = '0') AND (venda.id_cli = @codCli)" 
                        DeleteCommand="DELETE FROM itens WHERE (id_itens = @cod)" 
                        UpdateCommand="UPDATE itens SET status = '1' WHERE (id_prod = @cod)">
                        <DeleteParameters>
                            <asp:Parameter Name="cod" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:SessionParameter Name="id" SessionField="ProdutoEscolhido" />
                            <asp:SessionParameter Name="codCli" SessionField="idCliente" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:SessionParameter Name="cod" SessionField="ProdutoEscolhido" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sqlFinalizarVenda" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            DeleteCommand="DELETE FROM venda WHERE (total_venda = '0') AND (id_cli = @cod)" 
            InsertCommand="INSERT INTO venda(total_venda, id_pagto, id_cli) VALUES (@preco, @pagto, @cod)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [venda]">
                        <DeleteParameters>
                            <asp:SessionParameter Name="cod" SessionField="idCliente" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="preco" />
                            <asp:ControlParameter ControlID="rbFormasPag" Name="pagto" 
                                PropertyName="SelectedValue" />
                            <asp:SessionParameter Name="cod" SessionField="idCliente" />
                        </InsertParameters>
        </asp:SqlDataSource>
</div>


</asp:Content>

