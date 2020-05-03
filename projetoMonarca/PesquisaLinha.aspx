<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="PesquisaLinha.aspx.cs" Inherits="PesquisaLinha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Linhas</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />

    <p>Digite o nome da Linha: 
    <asp:TextBox ID="txtPesq" runat="server" CssClass="caixa-de-texto"></asp:TextBox> &nbsp;<asp:Button 
            ID="btnPesquisar" runat="server" Text="Pesquisar" 
        onclick="btnPesquisar_Click" Height="24px" CssClass="btnApp" />
        &nbsp;<asp:Label ID="lblResp" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
    <asp:RadioButtonList ID="rbStatus" runat="server" Font-Names="Calibri" 
            AutoPostBack="True" onselectedindexchanged="rbStatus_SelectedIndexChanged">
        <asp:ListItem>Linhas Ativas</asp:ListItem>
        <asp:ListItem>Linhas Inativas</asp:ListItem>
    </asp:RadioButtonList>
    &nbsp;</p>
    <p>
        <asp:GridView ID="gvExibir" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center" 
            DataKeyNames="id_linha" 
            onselectedindexchanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" 
                    ShowSelectButton="True" />
                <asp:TemplateField HeaderText="Excluir">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkOP" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
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
        <asp:GridView ID="gvExibirInativo" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center" 
            DataKeyNames="id_linha" 
            onselectedindexchanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" 
                    ShowSelectButton="True" />
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
    </p>
    <p>
        <asp:Button ID="btnExcluir" runat="server" onclick="btnExluir_Click" 
            Text="Excluir" CssClass="btnApp" Visible="False" />
    &nbsp;<asp:Label ID="lblExcluir" runat="server" 
            style="font-weight: 700; font-style: italic"></asp:Label>
        <asp:SqlDataSource ID="sqlPesqLinha" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            DeleteCommand="DELETE FROM linha WHERE (id_linha = @cod)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            
            
            SelectCommand="SELECT linha.id_linha, linha.tipo_linha, promocao.titulo_promo, linha.status FROM linha INNER JOIN promocao ON linha.id_promo = promocao.id_promo WHERE (linha.status = @status)" 
            UpdateCommand="UPDATE linha SET status = '1' WHERE (id_linha = @cod)">
            <DeleteParameters>
                <asp:Parameter Name="cod" />
            </DeleteParameters>
            <SelectParameters>
                <asp:Parameter Name="pesq" />
                <asp:SessionParameter Name="status" SessionField="status" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="cod" />
                <asp:Parameter Name="status" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlTornarProdutosInativos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [produto]" 
            DeleteCommand="DELETE FROM produto WHERE (id_linha = @cod)" 
            UpdateCommand="UPDATE produto SET status = 1 WHERE (id_linha = @cod)">
            <DeleteParameters>
                <asp:Parameter Name="cod" />
            </DeleteParameters>
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
        <asp:Label ID="lblErro" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
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

