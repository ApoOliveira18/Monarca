<%@ Page Title="" Language="C#" MasterPageFile="~/Senha.master" AutoEventWireup="true" CodeFile="RecuperarSenhaFunc.aspx.cs" Inherits="RecuperarSenhaFunc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1>RECUPERAR SENHA</h1>
<p>
    <asp:Label ID="lblSucesso" runat="server"></asp:Label></p>
<p>
    <asp:Button ID="btnLogin" runat="server" Text="Ir para Login" 
        CssClass="btnApp" onclick="btnLogin_Click" />
</p>
<p>
    <asp:SqlDataSource ID="sqlResetarSenhaFunc" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM [funcionario]" 
        
        UpdateCommand="UPDATE funcionario SET senha_func = @senha, data_conta = @data_alt WHERE (id_func = @codFunc)">
        <UpdateParameters>
            <asp:SessionParameter Name="codFunc" SessionField="idFuncSenha" />
            <asp:Parameter Name="data_alt" />
            <asp:Parameter Name="senha" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>

