<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_PerguntaSecreta.aspx.cs" Inherits="PerfilCliente_PerguntaSecreta" %>

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
        height: 300px;

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
    <h1>Pergunta Secreta</h1>


        <div id="container">

     <div id="info-container">
        <div class="nome">
        	    <asp:Label ID="lblPergunta" runat="server" style="color: #000000">Pergunta Secreta</asp:Label></div>
                <div class="caixas">
                <asp:Label ID="lblPergBanco" runat="server"></asp:Label>
            </div>
        </div>
        <div id="info-container">
            <div class="nome">
        	    <asp:Label ID="lblResposta" runat="server" style="color: #000000">Resposta</asp:Label></div>
                <div class="caixas">
                <asp:TextBox ID="txtResposta" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="txtResposta" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <br />
                </div>
            </div>

        <asp:SqlDataSource ID="sqlBuscarPergunta" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT id_cli, perg_cli FROM cliente WHERE (id_cli = @cod)">
                     <SelectParameters>
                         <asp:SessionParameter Name="cod" SessionField="idCliSenha" />
                     </SelectParameters>
         </asp:SqlDataSource>
        

        <div id="info-container">
        <asp:Label ID="lblErroPerg" runat="server" style="color: #FF0000"></asp:Label>
        <br />
            <asp:Button ID="btnVerificarPerg" runat="server" CssClass="btnApp" 
                Text="Verificar" onclick="btnVerificarPerg_Click" />
        </div>
         <asp:SqlDataSource ID="sqlChecarRespSecreta" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             
             SelectCommand="SELECT id_cli, perg_cli, resp_cli FROM cliente WHERE (perg_cli = @perg_cli) AND (id_cli = @cod) AND (resp_cli = @resp_cli)">
             <SelectParameters>
                 <asp:Parameter Name="resp_cli" />
                 <asp:SessionParameter Name="cod" SessionField="idCliSenha" />
                 <asp:SessionParameter Name="perg_cli" SessionField="pergCliSenha" />
             </SelectParameters>
         </asp:SqlDataSource>

     
    </div>
    </div>
    </div>
</asp:Content>

