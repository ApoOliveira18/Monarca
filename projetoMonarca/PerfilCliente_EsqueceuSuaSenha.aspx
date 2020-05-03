<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_EsqueceuSuaSenha.aspx.cs" Inherits="PerfilCliente_EsqueceuSuaSenha" %>

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
        height: 200px;

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
        	<div class="nome">
        	    Email</div>
            <div class="caixas">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtEmail" ErrorMessage="*"></asp:RequiredFieldValidator>
            </div>
        </div>
        
         <asp:SqlDataSource ID="sqlBuscarDados" runat="server" ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" SelectCommand="SELECT id_cli, login_cli, nome_cli, email_cli, senha_cli FROM cliente WHERE (email_cli = @email)">
             <SelectParameters>
                 <asp:Parameter Name="email" />
             </SelectParameters>
         </asp:SqlDataSource>
        <asp:Label ID="lblErro" runat="server" style="color: #FF0000"></asp:Label>
       
        <div id="info-container">
            <asp:Button ID="btnContinuar" runat="server" CssClass="btnApp" OnClick="btnContinuar_Click" Text="Continuar" />
        </div>
    </div>
    <br />
    <br />
     </div>
    </div>

</asp:Content>

