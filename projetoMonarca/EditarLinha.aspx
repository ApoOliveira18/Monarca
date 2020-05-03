<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="EditarLinha.aspx.cs" Inherits="EditarLinha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">

*, *::after, *::before {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <h1 class="posicionamento">Editar Linha</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
 <p>
        <strong>DADOS ANTERIORES:
        <asp:GridView ID="gvExibir" runat="server" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            DataKeyNames="id_linha" ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center">
            <Columns>
                <asp:BoundField DataField="id_linha" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_linha" />
                <asp:BoundField DataField="tipo_linha" HeaderText="Nome Linha" 
                    SortExpression="tipo_linha" />
                <asp:BoundField DataField="titulo_promo" HeaderText="Promoção" 
                    SortExpression="titulo_promo" />
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        </strong>
        <asp:SqlDataSource ID="sqlLinhaCadastrada" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            SelectCommand="SELECT linha.id_linha, linha.tipo_linha, promocao.titulo_promo, linha.id_promo, promocao.desconto FROM linha INNER JOIN promocao ON linha.id_promo = promocao.id_promo WHERE (linha.id_linha = @cod)">
            <SelectParameters>
                <asp:SessionParameter Name="cod" SessionField="codLinha" />
            </SelectParameters>
        </asp:SqlDataSource>
    <p>
       </p>
    <p>
        <strong>ALTERE OS DADOS ABAIXO:</strong></p>
 <p>Nome da Linha:
     <asp:TextBox ID="txtLinha" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
         ControlToValidate="txtLinha" ErrorMessage="*"></asp:RequiredFieldValidator>
         
         <p> Promoção:
             <asp:DropDownList ID="ddlPromo" runat="server" CssClass="ddls" AutoPostBack="True" 
                 onselectedindexchanged="ddlPromo_SelectedIndexChanged">
             </asp:DropDownList>
             &nbsp;(Opcional)
        <asp:SqlDataSource ID="sqlExibirPromo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM promocao"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlPromoEscolhida" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (id_promo = @promo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlPromo" Name="promo" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <div id="descontoPromo" runat="server">
    <p> Desconto da Promoção (%): 
        <asp:TextBox ID="txtDesconto" runat="server" Enabled="False" ReadOnly="True" CssClass="caixa-de-texto"></asp:TextBox>
    </p>
    </div>

         <p>
        <asp:Button ID="btnEditar" runat="server" onclick="btnEditar_Click" 
            Text="Editar" CssClass="btnApp" />
             <asp:SqlDataSource ID="sqlAlterarLinha" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 
                 SelectCommand="SELECT linha.id_linha, linha.tipo_linha, linha.id_promo, promocao.desconto FROM linha INNER JOIN promocao ON linha.id_promo = promocao.id_promo WHERE (linha.id_linha = @cod)" 
                 
                 
                 UpdateCommand="UPDATE linha SET id_promo = @promo, tipo_linha = @linha WHERE (id_linha = @cod)">
                 <SelectParameters>
                     <asp:SessionParameter Name="cod" SessionField="codLinha" />
                 </SelectParameters>
                 <UpdateParameters>
                     <asp:ControlParameter ControlID="ddlPromo" Name="promo" 
                         PropertyName="SelectedValue" />
                     <asp:SessionParameter Name="cod" SessionField="codLinha" />
                     <asp:Parameter Name="linha" />
                 </UpdateParameters>
             </asp:SqlDataSource>
             <asp:SqlDataSource ID="sqlAlterarPrecoProd" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM [produto]" 
                 
                 UpdateCommand="UPDATE produto SET valor_prod_final = @preco WHERE (id_linha = @codLinha) AND (id_prod = @cod)">
                 <UpdateParameters>
                     <asp:SessionParameter Name="cod" SessionField="codProdEditar" />
                     <asp:Parameter Name="preco" />
                     <asp:SessionParameter Name="codLinha" SessionField="codLinha" />
                 </UpdateParameters>
             </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
                 SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.adicional, promocao.desconto, promocao.titulo_promo FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN promocao ON produto.id_promo = promocao.id_promo WHERE (produto.id_linha = @codLinha)">
        <SelectParameters>
            <asp:SessionParameter Name="codLinha" SessionField="codLinha" />
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
    </p>
    </asp:Content>

