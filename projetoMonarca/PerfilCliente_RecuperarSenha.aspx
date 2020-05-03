<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_RecuperarSenha.aspx.cs" Inherits="PerfilCliente_RecuperarSenha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="css/estilo_perfil_cliente.css"/>
<link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />

            <style>
        .cd-main-content {
            padding-top: 80px;
            background-color: #f5f5f5;
        }
    #container
        {
        height: 500px;
        margin-bottom: 50px;
        }


@media screen  and (max-width: 1023px)
{
    .caixa-de-login{
	width:	90%;
	margin:	0 auto;
    }
    .conteudo-de-login{
	width:	98%;
	margin-top:	30px;
	padding-left: 2%;
	float: left;
    }
    .conteudo-cadastro{
	width:	98%;
	margin-top:	30px;
	padding-left: 2%;
	float: left;
    }
    .cd-main-content {
    height:1300px;
}

}



</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="centralizar-total2">
<div id="tudo">
    <br />
    <br />
    <h1>Recuperar Senha</h1>


        <div id="container">
        
        <div id="info-container">
        <div class="caixas">
        	    <strong>Sua senha foi alterada com SUCESSO! 
                <br />
                Confira sua nova senha no seu email.</strong></div>
        <br />
            <div class="caixas">
                <asp:Label ID="lblSucesso" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btnApp" 
                    onclick="btnLogin_Click" />
                </div>
            </div>
         <asp:SqlDataSource ID="sqlResetarSenha" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM [cliente]" 
             
             
             UpdateCommand="UPDATE cliente SET senha_cli = @senha, data_conta = @data_alt WHERE (id_cli = @cod)">
             <UpdateParameters>
                 <asp:SessionParameter Name="cod" SessionField="idCliSenha" />
                 <asp:Parameter Name="data_alt" />
                 <asp:Parameter Name="senha" />
             </UpdateParameters>
         </asp:SqlDataSource>
        </div>
    </div>
    
    </div>
</asp:Content>

