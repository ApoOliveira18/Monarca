<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="produto.aspx.cs" Inherits="produto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style>
.cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
    height: 1600px;
}
@media screen  and (max-width: 413px)
{
    .cd-main-content {

    height: 3250px;
    }
}
@media screen and  (min-width: 414px) and (max-width: 479px)  
{
    .cd-main-content {

    height: 3250px;
    }
    
}
@media screen and  (min-width: 480px) and (max-width: 567px)  
{
        .cd-main-content {

    height: 3250px;
    }
}
@media screen and  (min-width: 568px) and (max-width: 639px)
 {
   .cd-main-content {
    height: 2800px;
    }  
 }
 @media screen and (min-width: 640px) and (max-width: 735px) 
{
        .cd-main-content {
    height: 2800px;
    }  
}
@media screen and  (min-width: 736px) and (max-width: 767px)   
{
      .cd-main-content {
    height: 2800px;
    } 
}
@media screen and  (min-width: 768px)  and (max-width: 799px)  
{
    .cd-main-content {
    height: 2800px;
    } 
}
@media screen and (min-width: 800px) and (max-width: 1023px)   
{
        .cd-main-content {
    height: 2500px;
    } 
}
@media screen and  (min-width:1024px) and (max-width:1279px)  
{
    .cd-main-content {
    height: 2300px;
    } 
}
</style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="info-produto">
    <div class="fonte-nome"><asp:Label ID="lblNome2" runat="server"></asp:Label>
    </div>
    <br />
    <div class="slogan-prod">
        <asp:Label ID="lblSlogan" runat="server" ></asp:Label>
        <br />
    </div>
    <div class="fonte-desc">
        <br />
        <asp:Label ID="lblDesc" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lblDescComplemento" runat="server"></asp:Label>
        </div>
         <br />
         <br />
         <div class="barra-perf"></div>
         <br />
         <div class="info-preco">
         <div class="preco-perf ">
            <div class="fonte-desc">
                <asp:DropDownList ID="ddlML" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="ddlML_SelectedIndexChanged" CssClass="ddls">
                </asp:DropDownList>
                <asp:DropDownList ID="ddlQtd" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="ddlQtd_SelectedIndexChanged" CssClass="ddls">
                    <asp:ListItem>Qtd. 1</asp:ListItem>
                    <asp:ListItem>Qtd. 2</asp:ListItem>
                    <asp:ListItem>Qtd. 3</asp:ListItem>
                    <asp:ListItem>Qtd. 4</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnOK" runat="server" onclick="Button1_Click" Text="OK" 
                    Visible="False" />
                <asp:SqlDataSource ID="sqlML" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                    SelectCommand="SELECT * FROM ml"></asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlMLescolhido" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                    SelectCommand="SELECT id_ml, desc_ml, adicional FROM ml WHERE (id_ml = @COD)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlML" Name="COD" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

            <asp:SqlDataSource ID="sqlPesquisaPreco" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                
                    SelectCommand="SELECT id_prod, valorUnid_prod, valor_prod_final, valor_acrescimo FROM produto WHERE (id_prod = @cod)">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="cod" SessionField="imgEscolhida" />
                </SelectParameters>
            </asp:SqlDataSource>

            </div>
             <br />
             <asp:Label ID="lblPrecoAntigo" runat="server" Font-Size="20pt" 
                 Font-Strikeout="True"></asp:Label>
            <br />
            
            R$ <asp:Label ID="lblValor" class="preco" runat="server"></asp:Label>
            <br />
             <asp:Label ID="lblParcela" class ="parcela" runat="server"></asp:Label>
        </div>
     
        
         
            <asp:Button ID="btnComprar" runat="server" Text="Comprar" 
                CssClass="btnApp" onclick="btnComprar_Click1" />
             <asp:SqlDataSource ID="sqlSOMA" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM produto"></asp:SqlDataSource>
             <asp:Label ID="lblErro" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            <asp:SqlDataSource ID="SqlProduto" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 

                
                 SelectCommand="SELECT id_prod, id_genero, id_linha, id_ml, nome_prod, desc_prod, slogan_prod, valorUnid_prod, valor_acrescimo, valor_prod_final, img_prod, qtd_disponivel FROM produto WHERE (id_prod = @pesq)">
                <SelectParameters>
                    <asp:SessionParameter Name="pesq" SessionField="imgEscolhida" />
                </SelectParameters>
            </asp:SqlDataSource>
             <asp:SqlDataSource ID="sqlProdutoBusca" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM produto">
                 <SelectParameters>
                     <asp:QueryStringParameter Name="cod" QueryStringField="id" />
                 </SelectParameters>
             </asp:SqlDataSource>
             <asp:SqlDataSource ID="sqlTrocarMLdoProduto" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM [produto]" 
                 UpdateCommand="UPDATE produto SET id_ml = @ML">
                 <UpdateParameters>
                     <asp:ControlParameter ControlID="ddlML" Name="ML" 
                         PropertyName="SelectedValue" />
                 </UpdateParameters>
             </asp:SqlDataSource>
             <br />
             <asp:SqlDataSource ID="sqlInserirVenda" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO venda(id_cli, id_pagto, total_venda) VALUES (@idCli, 1, 0)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_venda, id_cli, id_pagto, total_venda FROM venda">
            <InsertParameters>
                <asp:SessionParameter Name="idCli" SessionField="idCliente" />
            </InsertParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlBuscarVendaCriada" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT MAX(id_venda) AS idVendas FROM venda">
        </asp:SqlDataSource> 
             <asp:SqlDataSource ID="sqlInserirItemVenda" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO itens(id_venda, id_prod, qtd_item, total_prod, status) VALUES (@idVenda, @idProd, @qtd, @total, '0')" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM itens">
            <InsertParameters>
                <asp:SessionParameter Name="idVenda" SessionField="idVendas" />
                <asp:SessionParameter Name="idProd" SessionField="idProd" />
                <asp:SessionParameter Name="qtd" SessionField="QtdDESEJADA" />
                <asp:SessionParameter Name="total" SessionField="totalItem" />
            </InsertParameters>
        </asp:SqlDataSource>   
             <asp:SqlDataSource ID="sqlSubtrairPerfumeComprada" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM produto" 
                 
                 UpdateCommand="UPDATE produto SET qtd_disponivel = @qtd WHERE (id_prod = @COD)">
                 <UpdateParameters>
                     <asp:SessionParameter Name="COD" SessionField="idProd" />
                     <asp:Parameter Name="qtd" />
                 </UpdateParameters>
             </asp:SqlDataSource>
             <br />
             <br />
             <asp:SqlDataSource ID="SqlRelacionados" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, linha.tipo_linha FROM produto INNER JOIN linha ON produto.id_linha = linha.id_linha WHERE (produto.id_linha = @codLinha) AND (produto.id_prod &lt;&gt; @codProd)">
                 <SelectParameters>
                     <asp:SessionParameter Name="codLinha" SessionField="linhaEscolhida" />
                     <asp:SessionParameter Name="codProd" SessionField="imgEscolhida" />
                 </SelectParameters>
             </asp:SqlDataSource>
             <asp:SqlDataSource ID="SqlComprar" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT * FROM cliente">
                <SelectParameters>
                    <asp:SessionParameter Name="pesq" SessionField="Logado" />
                </SelectParameters>
            </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
                 SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, promocao.titulo_promo, promocao.desconto, ml.adicional FROM produto INNER JOIN promocao ON produto.id_promo = promocao.id_promo INNER JOIN ml ON produto.id_ml = ml.id_ml WHERE (produto.nome_prod = @pesquisaProd)">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="pesquisaProd" />
        </SelectParameters>
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
         </div>

    </div>

    <div class="img-produto">
    <center><asp:Image ID="Image1" runat="server" EnableTheming="False" class="foto-prod"/></center>
    </div>


    <div id="compreMais" runat="server">
    <div class="s-posicao">
    <div class="s-titulo">
    <h2>Recomendações para você</h2>
    </div>
    <div class="linha-prod"></div>

        <div id="s1" runat="server" class="s">
         <center>
         <asp:ImageButton ID="ImageButton1" runat="server" Height="250px"  Width="250px" OnClick="ImageButton1_Click" />
         </center>
         <br />
         <br />
                    <center><asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">LinkButton</asp:LinkButton></center>
        </div>
        <div id="s2" runat="server" class="s">
        <center>
        <asp:ImageButton ID="ImageButton2" runat="server" Height="250px"  Width="250px" OnClick="ImageButton2_Click" />
        </center>
        <br />
         <br />          <center><asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">LinkButton</asp:LinkButton></center></div>
        <div id="s3" runat="server" class="s">
        <center>
        <asp:ImageButton ID="ImageButton3" runat="server" Height="250px"  Width="250px" OnClick="ImageButton3_Click" />
         </center>
         <br />
         <br />        <center><asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click">LinkButton</asp:LinkButton></center></div>
        <div id="s4" runat="server" class="s">
        <center>
        <asp:ImageButton ID="ImageButton4" runat="server" Height="250px"  Width="250px" OnClick="ImageButton4_Click" />
         </center>     
         <br />
         <br />      <center><asp:LinkButton ID="LinkButton4" runat="server" OnClick="LinkButton4_Click">LinkButton</asp:LinkButton></center></div>
        
    </div>
    </div>
 
    <div class="info-extra">
    <div class="info-t">
    <h2>Entrega Rápida</h2>
    <br />
    <br />
    <p>Os perfumes são enviados assim que o pagamento é confirmado.</p>
    </div>
    
    <div class="info-t">
    <h2>Devolução Gratuita</h2>
    <br />
    <br />
    <p>Aceitamos devoluções por qualquer motivo e o custo do frete de retorno é nosso. Leia mais <a href="trocas-e-devolucoes.aspx">aqui</a>.</p>
    </div>

    <div class="info-t">
    <h2>Parcelamento</h2>
    <br />
    <br />
    <p>Parcelamos em até 12X sem juros nos cartões de crédito ou pela Paypal.</p>
    </div>
    </div>
   
</asp:Content>

