<%@ Page Title="" Language="C#" MasterPageFile="~/Senha.master" AutoEventWireup="true" CodeFile="EsqueceuSuaSenhaADM.aspx.cs" Inherits="EsqueceuSuaSenhaADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>ESQUECEU SUA SENHA?</h1>
    <p>
        <strong>Email: </strong>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="caixa-de-texto" 
            Width="238px"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="lblErro" runat="server" style="color: #FF0000; font-weight: 700"></asp:Label>
    </p>
    <p>
        <asp:Button ID="btnContinuar" runat="server" Text="Continuar" CssClass="btnApp" 
            onclick="btnContinuar_Click" />
    </p>
    <p>
        <asp:SqlDataSource ID="sqlBuscarDadosADM" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_adm, login_adm, senha_adm, email_adm, data_conta FROM adm WHERE (email_adm = @email)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtEmail" Name="email" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

