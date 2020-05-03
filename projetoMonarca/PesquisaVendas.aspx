<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="PesquisaVendas.aspx.cs" Inherits="PesquisaVendas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Vendas</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
<p>Digite o nome do cliente:
<asp:TextBox ID="txtPesquisa" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" 
        CssClass="btnApp" Height="24px" onclick="btnPesquisar_Click" />
    &nbsp;
        <asp:Label ID="lblResp" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
        <asp:SqlDataSource ID="sqlVendasPorNome" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            
        SelectCommand="SELECT venda.id_venda, venda.id_cli, venda.id_pagto, venda.total_venda, cliente.nome_cli, cliente.email_cli, pagamento.tipo_pagto, cliente.status FROM venda INNER JOIN pagamento ON venda.id_pagto = pagamento.id_pagto INNER JOIN cliente ON venda.id_cli = cliente.id_cli">
            <SelectParameters>
                <asp:Parameter Name="nome" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:GridView ID="gvExibir" runat="server" BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" AutoGenerateColumns="False" 
            DataKeyNames="id_venda">
            <Columns>
                <asp:BoundField DataField="id_venda" HeaderText="Código da Venda" 
                    InsertVisible="False" ReadOnly="True" SortExpression="id_venda" />
                <asp:BoundField DataField="nome_cli" HeaderText="Nome do Cliente" 
                    SortExpression="nome_cli" />
                <asp:BoundField DataField="status" HeaderText="Status" 
                    SortExpression="status" />
                <asp:BoundField DataField="email_cli" HeaderText="Email" 
                    SortExpression="email_cli" />
                <asp:BoundField DataField="tipo_pagto" HeaderText="Pagamento" 
                    SortExpression="tipo_pagto" />
                <asp:TemplateField HeaderText="Total Compra" SortExpression="total_venda">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("total_venda") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("total_venda", "{0:C}") %>'></asp:Label>
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

