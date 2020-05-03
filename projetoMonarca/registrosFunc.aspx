<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="registrosFunc.aspx.cs" Inherits="registrosFunc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Registros</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    Consulte os Cadastros realizados recentemente pelo Funcionário.
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id_registrosFunc" style="text-align: center"
        
        BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
        >
        <Columns>
            <asp:BoundField DataField="id_registrosFunc" HeaderText="Código do Registro" 
                InsertVisible="False" ReadOnly="True" SortExpression="id_registrosFunc" />
            <asp:BoundField DataField="id_func" HeaderText="ID FUNC Acesso" 
                SortExpression="id_func" />
            <asp:BoundField DataField="registro" HeaderText="Registro" 
                SortExpression="registro" />
            <asp:BoundField DataField="data_registro" HeaderText="Data" 
                SortExpression="data_registro" />
            <asp:BoundField DataField="nome_prod" HeaderText="Produto" 
                SortExpression="nome_prod" />
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
    <asp:SqlDataSource ID="sqlRegistros" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        SelectCommand="SELECT id_registrosFunc, id_func, registro, data_registro, nome_prod FROM registrosfunc ORDER BY data_registro DESC">
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
    <br />    <br />
    <br />
    <br />
    <br />
    <br />    <br />
    <br />
    <br />


</asp:Content>

