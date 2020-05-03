<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="PesquisaML.aspx.cs" Inherits="PesquisaML" %>

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
<h1 class="posicionamento">Mls</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <p>
        Digite o Conteúdo (ML) :
        <asp:TextBox ID="txtPesq" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;<asp:Button 
            ID="btnPesquisar" runat="server" Text="Pesquisar" 
        onclick="btnPesquisar_Click" Height="24px" CssClass="btnApp" />
        &nbsp;<asp:Label ID="lblResp" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
    </p>
    <p>
        <asp:GridView ID="gvExibir" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center" 
            DataKeyNames="id_ml" 
            onselectedindexchanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" 
                    ShowSelectButton="True" />
                <asp:TemplateField HeaderText="Excluir">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkOP" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id_ml" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_ml" />
                <asp:BoundField DataField="desc_ml" HeaderText="ML" 
                    SortExpression="desc_ml" />
                <asp:TemplateField HeaderText="Adicional (%)" SortExpression="adicional">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("adicional") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("adicional") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
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
    </p>
    <p>
        <asp:Label ID="lblErro" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
    </p>
    <p>
        <asp:Button ID="btnExcluir" runat="server" onclick="btnExluir_Click" 
            Text="Excluir" CssClass="btnApp" Visible="False" />
    </p>
    <p>
        <asp:SqlDataSource ID="sqlPesqML" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            DeleteCommand="DELETE FROM ml WHERE (id_ml = @cod)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            
            SelectCommand="SELECT id_ml, desc_ml, adicional FROM ml">
            <DeleteParameters>
                <asp:Parameter Name="cod" />
            </DeleteParameters>
            <SelectParameters>
                <asp:Parameter Name="pesq" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlExcluirProdutoDoML" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [produto]" 
            
            
            
            UpdateCommand="UPDATE produto SET id_ml = 1, valor_acrescimo = @acresc, valor_prod_final = @preco WHERE (id_ml = @cod)">
            <UpdateParameters>
                <asp:Parameter Name="cod" />
                <asp:Parameter Name="acresc" />
                <asp:Parameter Name="preco" />
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
    <asp:SqlDataSource ID="sqlBuscarPrecoProdutoAntigo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
            
                
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.adicional, promocao.desconto, promocao.titulo_promo FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN promocao ON produto.id_promo = promocao.id_promo WHERE (produto.id_ml = @codML)">
        <SelectParameters>
            <asp:SessionParameter Name="codML" SessionField="codML" />
        </SelectParameters>
    </asp:SqlDataSource>
    </p>
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

