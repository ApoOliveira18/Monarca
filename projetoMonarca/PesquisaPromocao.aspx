<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="PesquisaPromocao.aspx.cs" Inherits="PesquisaPromocao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   

    <style type="text/css">




* {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

        </style>
   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Promoção</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <p>
        Digite o nome da Promoção:
        <asp:TextBox ID="txtPesquisa" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" 
        onclick="btnPesquisar_Click" Height="24px" CssClass="btnApp" />
        &nbsp;<asp:Label ID="lblResp" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
            <asp:SqlDataSource ID="sqlExibirInformacaoPromo" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao" 
                DeleteCommand="DELETE FROM promocao WHERE (id_promo = @cod)">
                <DeleteParameters>
                    <asp:Parameter Name="cod" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:Parameter Name="promo" />
                </SelectParameters>
            </asp:SqlDataSource>
    </p>
            <p>
            <asp:GridView ID="gvExibir" runat="server"
            BackColor="White" onselectedindexchanged="gvExibir_SelectedIndexChanged" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
             ForeColor="Black" GridLines="Horizontal" 
            AutoGenerateColumns="False" 
            
            style="text-align: center" DataKeyNames="id_promo">
                <Columns>
                    <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" ShowSelectButton="True" />
                    <asp:TemplateField HeaderText="Excluir">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkOP" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="id_promo" HeaderText="Código da Promoção" InsertVisible="False" ReadOnly="True" SortExpression="id_promo" />
                    <asp:BoundField DataField="titulo_promo" HeaderText="Título" SortExpression="titulo_promo" />
                    <asp:BoundField DataField="desconto" HeaderText="Desconto (%)" SortExpression="desconto" />
                </Columns>
                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                <SelectedRowStyle BackColor="#cc3333" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                <SortedDescendingHeaderStyle BackColor="#242121" />
            </asp:GridView>
        <p>
        <asp:Label ID="lblErro" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
        <p>
            <asp:Button ID="btnExcluir" runat="server" onclick="btnExcluir_Click" 
                Text="Excluir" CssClass="btnApp" Visible="False" />
            <asp:SqlDataSource ID="sqlExcluirPromoDoProd" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT * FROM [produto]" 
                UpdateCommand="UPDATE produto SET id_promo = 1 WHERE (id_promo = @cod)">
                <UpdateParameters>
                    <asp:Parameter Name="cod" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlExcluirPromoDaLinha" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT * FROM [linha]" 
                UpdateCommand="UPDATE linha SET id_promo = 1 WHERE (id_promo = @cod)">
                <UpdateParameters>
                    <asp:Parameter Name="cod" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlExcluirPromoDoGenero" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT * FROM [genero]" 
                UpdateCommand="UPDATE genero SET id_promo = 1 WHERE (id_promo = @cod)">
                <UpdateParameters>
                    <asp:Parameter Name="cod" />
                </UpdateParameters>
            </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlRegistro" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO registrosadm(id_adm, data_registro, registro, login_adm, nome_prod, desc_ml, tipo_promo, tipo_linha, tipo_genero, login_cliente, login_func) VALUES (@cod, @data, @registro, @adm, @prod, @ml, @promo, @linha, @genero, @cliente, @func)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM registrosadm">
            <InsertParameters>
                <asp:Parameter Name="data" />
                <asp:SessionParameter Name="cod" SessionField="idADM" />
                <asp:Parameter Name="registro" />
                <asp:Parameter Name="adm" />
                <asp:Parameter Name="prod" />
                <asp:Parameter Name="ml" />
                <asp:Parameter Name="linha" />
                <asp:Parameter Name="genero" />
                <asp:Parameter Name="promo" />
                <asp:Parameter Name="cliente" />
                <asp:Parameter Name="func" />
            </InsertParameters>
        </asp:SqlDataSource>
            &nbsp;<asp:SqlDataSource ID="sqlAlterarPrecoProd" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM [produto]" 
                 
                 UpdateCommand="UPDATE produto SET valor_prod_final = @preco WHERE (id_prod = @cod)">
                 <UpdateParameters>
                     <asp:SessionParameter Name="cod" SessionField="codProdEditar" />
                     <asp:Parameter Name="preco" />
                 </UpdateParameters>
             </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
            
                
                SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.adicional, promocao.desconto, promocao.titulo_promo FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN promocao ON produto.id_promo = promocao.id_promo ">
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
        <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
        </asp:Content>

