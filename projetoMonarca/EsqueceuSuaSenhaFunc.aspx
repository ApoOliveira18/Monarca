<%@ Page Title="" Language="C#" MasterPageFile="~/Senha.master" AutoEventWireup="true" CodeFile="EsqueceuSuaSenhaFunc.aspx.cs" Inherits="EsqueceuSuaSenhaFunc" %>

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
        <asp:SqlDataSource ID="sqlBuscarDadosFunc" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            SelectCommand="SELECT id_func, login_func, senha_func, email_func, data_conta FROM funcionario WHERE (email_func = @email)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtEmail" Name="email" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

