<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="PesquisaFuncionario.aspx.cs" Inherits="PesquisaADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Funcionários</h1>

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
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" 
            AutoGenerateColumns="False" DataKeyNames="id_func" 
            onselectedindexchanged="gvExibir_SelectedIndexChanged" 
            style="text-align: center">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" ShowSelectButton="True" />
                <asp:TemplateField HeaderText="Excluir">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkOP" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id_func" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_func" />
                <asp:BoundField DataField="login_func" HeaderText="Login" 
                    SortExpression="login_func" />
                <asp:BoundField DataField="email_func" HeaderText="Email" 
                    SortExpression="email_func" />
                <asp:BoundField DataField="data_conta" HeaderText="Data da Conta " SortExpression="data_conta" />
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

            <asp:Button ID="btnExcluir" runat="server" onclick="btnExcluir_Click" 
                Text="Excluir" CssClass="btnApp" Visible="False" />
    <p>
        <asp:SqlDataSource ID="sqlFuncionarios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            
            SelectCommand="SELECT id_func, login_func, senha_func, email_func, data_conta, status FROM funcionario WHERE (status = '0')" DeleteCommand="DELETE FROM funcionario WHERE (id_func = @cod)" UpdateCommand="UPDATE funcionario SET status = '1' WHERE (id_func = @cod)">
            <DeleteParameters>
                <asp:Parameter Name="cod" />
            </DeleteParameters>
            <SelectParameters>
                <asp:Parameter Name="nome" />
            </SelectParameters>
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
    </div>
</asp:Content>

