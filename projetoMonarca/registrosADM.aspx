<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="registrosADM.aspx.cs" Inherits="registrosADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Registros de Administradores</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    Consulte as Alterações, Cadastros e/ou Exclusões realizadas recentemente pelo 
    Administrador.
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id_registros" style="text-align: center"
        
        BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
        >
        <Columns>
            <asp:BoundField DataField="id_registros" HeaderText="Código do Registro" 
                InsertVisible="False" ReadOnly="True" SortExpression="id_registros" />
            <asp:BoundField DataField="id_adm" HeaderText="ID ADM Acesso" 
                SortExpression="id_adm" />
            <asp:BoundField DataField="registro" HeaderText="Registro" 
                SortExpression="registro" />
            <asp:BoundField DataField="data_registro" HeaderText="Data do Registro" 
                SortExpression="data_registro" />
            <asp:BoundField DataField="login_cliente" HeaderText="Login Cliente" 
                SortExpression="login_cliente" />
            <asp:BoundField DataField="login_adm" HeaderText="Login adm" 
                SortExpression="login_adm" />
            <asp:BoundField DataField="login_func" HeaderText="Login func" 
                SortExpression="login_func" />
            <asp:BoundField DataField="nome_prod" HeaderText="Produto" 
                SortExpression="nome_prod" />
            <asp:BoundField DataField="desc_ml" HeaderText="ML" 
                SortExpression="desc_ml" />
            <asp:BoundField DataField="tipo_linha" HeaderText="Linha" 
                SortExpression="tipo_linha" />
            <asp:BoundField DataField="tipo_genero" HeaderText="Gênero" 
                SortExpression="tipo_genero" />
            <asp:BoundField DataField="tipo_promo" HeaderText="Promoção" 
                SortExpression="tipo_promo" />
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
        
        
        SelectCommand="SELECT id_registros, id_adm, registro, data_registro, login_cliente, login_adm, login_func, nome_prod, desc_ml, tipo_promo, tipo_linha, tipo_genero FROM registrosadm ORDER BY data_registro DESC"></asp:SqlDataSource>
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

