<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageFunc.master" AutoEventWireup="true" CodeFile="PesquisaClienteFunc.aspx.cs" Inherits="PesquisaCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Pesquisa de Cliente</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />

    <p>
        Digite o nome do cliente: 
        <asp:TextBox ID="txtPesquisa" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" 
        onclick="btnPesquisar_Click" CssClass="btnApp" Height="24px" />
        &nbsp;<asp:Label ID="lblResp" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
        <asp:RadioButtonList ID="rbStatus" runat="server" Font-Names="Calibri" 
            AutoPostBack="True" onselectedindexchanged="rbStatus_SelectedIndexChanged">
            <asp:ListItem>Clientes Ativos</asp:ListItem>
            <asp:ListItem>Clientes Inativos</asp:ListItem>
        </asp:RadioButtonList>
    </p>
    <p>
        <asp:GridView ID="gvExibir" runat="server" AutoGenerateColumns="False" 
         BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
         CellPadding="4" DataKeyNames="id_cli" 
         ForeColor="Black" GridLines="Horizontal" style="text-align: center" 
         onselectedindexchanged="gvExibir_SelectedIndexChanged">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" ShowSelectButton="True" />
                <asp:BoundField DataField="id_cli" HeaderText="Código" InsertVisible="False" 
                 ReadOnly="True" SortExpression="id_cli" />
                <asp:BoundField DataField="nome_cli" HeaderText="Nome" 
                 SortExpression="nome_cli" />
                <asp:BoundField DataField="email_cli" HeaderText="Email" 
                 SortExpression="email_cli" />
                <asp:BoundField DataField="CPF_cli" HeaderText="CPF" 
                 SortExpression="CPF_cli" />
                <asp:TemplateField HeaderText="Data de Nascimento" SortExpression="dtNasc_cli">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("dtNasc_cli") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("dtNasc_cli", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="tel_cli" HeaderText="Telefone" 
                 SortExpression="tel_cli" />
                <asp:BoundField DataField="CEP_cli" HeaderText="CEP" SortExpression="CEP_cli" />
                <asp:TemplateField HeaderText="Data da Conta" SortExpression="data_conta">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("data_conta") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("data_conta","{0:d}") %>'></asp:Label>
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
        <asp:SqlDataSource ID="sqlClienteNome" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            SelectCommand="SELECT id_cli, login_cli, nome_cli, email_cli, senha_cli, CPF_cli, RG_cli, sexo_cli, dtNasc_cli, tel_cli, outroTel_cli, estciv_cli, CEP_cli, num_cli, data_conta, status FROM cliente WHERE (status = @status)">
            <SelectParameters>
                <asp:Parameter Name="nome" />
                <asp:SessionParameter Name="status" SessionField="status" />
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
    <br />
</asp:Content>

