<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="PesquisaADM.aspx.cs" Inherits="PesquisaADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <h1 class="posicionamento">Administradores</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
<p>Digite o nome de usuário: 
    <asp:TextBox ID="txtPesquisa" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" 
        onclick="btnPesquisar_Click" Height="24px" 
        CssClass="btnApp" />
        &nbsp;<asp:Label ID="lblResp" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
    </p>
    <p>

        <asp:GridView ID="gvExibir" runat="server" BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
            AutoGenerateColumns="False" DataKeyNames="id_adm" 
            onselectedindexchanged="gvExibir_SelectedIndexChanged" 
            style="text-align: center">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" ShowSelectButton="True" />
                <asp:TemplateField HeaderText="Excluir">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkOP" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id_adm" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_adm" />
                <asp:BoundField DataField="login_adm" HeaderText="Login" 
                    SortExpression="login_adm" />
                <asp:BoundField DataField="email_adm" HeaderText="Email" 
                    SortExpression="email_adm" />
                <asp:TemplateField HeaderText="Data da Conta" SortExpression="data_conta">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("data_conta") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("data_conta","{0:d}") %>'></asp:Label>
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
        <p>

        <asp:Label ID="lblErro" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
        <p>

            <asp:Button ID="btnExcluir" runat="server" onclick="btnExcluir_Click" 
                Text="Excluir" Visible="False" CssClass="btnApp" />
    <p>
        <asp:SqlDataSource ID="sqlAdministradores" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            SelectCommand="SELECT id_adm, login_adm, senha_adm, email_adm, data_conta FROM adm" 
            DeleteCommand="DELETE FROM adm WHERE (id_adm = @cod)">
            <DeleteParameters>
                <asp:Parameter Name="cod" />
            </DeleteParameters>
            <SelectParameters>
                <asp:Parameter Name="nome" />
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

