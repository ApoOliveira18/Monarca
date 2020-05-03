<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="EditarML.aspx.cs" Inherits="EditarML" %>

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
    <h1 class="posicionamento">Editar Mls</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <p>
        <strong>DADOS ANTERIORES:
        <asp:GridView ID="gvExibir" runat="server" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            DataKeyNames="id_ml" ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center">
            <Columns>
                <asp:BoundField DataField="id_ml" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_ml" />
                <asp:BoundField DataField="desc_ml" HeaderText="ML" SortExpression="desc_ml" />
                <asp:BoundField DataField="adicional" HeaderText="Adicional (%)" 
                    SortExpression="adicional" />
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
        <asp:SqlDataSource ID="sqlExibirInformacaoML" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                
            SelectCommand="SELECT id_ml, desc_ml, adicional FROM ml WHERE (id_ml = @cod)">
            <SelectParameters>
                <asp:SessionParameter Name="cod" SessionField="codML" />
            </SelectParameters>
        </asp:SqlDataSource>
    <p>
    </p>
    <p>
        <strong>ALTERE OS DADOS ABAIXO:</strong></p>
    <div id="descontoPromo" runat="server">
    <p>
        Conteúdo (ML) :
        <asp:TextBox ID="txtML" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtML" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>
        Acréscimo (%):
        <asp:TextBox ID="txtAcres" runat="server" CssClass="caixa-de-texto" 
            Width="133px"></asp:TextBox>
    &nbsp;(Se desejar)</p>
    </div>
    <p>
        <asp:Button ID="btnEditar" runat="server" onclick="btnEditar_Click" 
            Text="Editar" CssClass="btnApp" />
        <asp:SqlDataSource ID="sqlAlterarML" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [ml]" 
            
            UpdateCommand="UPDATE ml SET desc_ml = @ml, adicional = @adicional WHERE (id_ml = @cod)">
            <UpdateParameters>
                <asp:Parameter Name="ml" />
                <asp:Parameter Name="adicional" />
                <asp:SessionParameter Name="cod" SessionField="codML" />
            </UpdateParameters>
        </asp:SqlDataSource>
             <asp:SqlDataSource ID="sqlAlterarPrecoProd" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM [produto]" 
                 
            
            UpdateCommand="UPDATE produto SET valor_prod_final = @preco, valor_acrescimo = @precoAdicional WHERE (id_prod = @prod)">
                 <UpdateParameters>
                     <asp:Parameter Name="preco" />
                     <asp:SessionParameter Name="codML" SessionField="codML" />
                     <asp:SessionParameter Name="prod" SessionField="codProdEditar" />
                     <asp:Parameter Name="precoAdicional" />
                 </UpdateParameters>
             </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.adicional, promocao.desconto, promocao.titulo_promo FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN promocao ON produto.id_promo = promocao.id_promo WHERE (produto.id_ml = @codML)">
        <SelectParameters>
            <asp:SessionParameter Name="codML" SessionField="codML" />
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

