<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="registrosADMLogin.aspx.cs" Inherits="registrosADMLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Registros de Login de Admnistradores</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 

   <br />
    Consulte a frequência de acesso ao setor Administrativo.<br />
    Obs: O ID que estiver <strong>zero(0)</strong>, significa que <strong>não
    </strong>houve acesso pelo respectivo da tabela.<br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id_registrosLogin" style="text-align: center"
        
        BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
        >
        <Columns>
            <asp:BoundField DataField="id_registrosLogin" HeaderText="Código do Registros" 
                InsertVisible="False" ReadOnly="True" SortExpression="id_registrosLogin" />
            <asp:BoundField DataField="registro" HeaderText="Registro" 
                SortExpression="registro" />
            <asp:BoundField DataField="data_registro" HeaderText="Data" 
                SortExpression="data_registro" />
            <asp:BoundField DataField="id_adm" HeaderText="ID ADM Acesso" 
                SortExpression="id_adm" />
            <asp:BoundField DataField="id_func" HeaderText="ID FUNC Acesso" 
                SortExpression="id_func" />
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
        
        
        SelectCommand="SELECT id_registrosLogin, id_adm, id_func, data_registro, registro FROM registrologin ORDER BY data_registro DESC">
    </asp:SqlDataSource>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>

