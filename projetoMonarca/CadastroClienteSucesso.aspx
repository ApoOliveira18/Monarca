<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="CadastroClienteSucesso.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

 <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />
         <style type="text/css">
        .style1
        {
            text-align: center;
        }
        .Cad
        { 
           text-align: center;
        }
        .link
        {
            text-decoration:none;
            color: #333;
            }
         .link:hover
        {
            text-decoration:none;
            color: #ccc;
            transition: ease-in 0.1s;
            }    
            
            .box{
	width:27%;
	height:300px;
	margin: 0 auto;
	background: #fff;
	margin-top: 2%;
	}
        </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
         <div class="box">
            <div class="text-box2-2">CADASTRO REALIZADO COM SUCESSO! </div>
            <br />
            <div class="Cad">Agora, você pode comprar os produtos da Monarca!<br />
                <a href="index.aspx" class="link"> Clique Aqui</a> para voltar à Página Inicial.</div>
             <asp:SqlDataSource ID="sqlDadosParaEmail" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                        SelectCommand="SELECT MAX(id_cli) AS id_cli FROM cliente">
                    </asp:SqlDataSource>
                    <br />
                    <asp:SqlDataSource ID="sqlDadosEspecificos" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                        SelectCommand="SELECT id_cli, nome_cli, email_cli FROM cliente WHERE (id_cli = @idCliente)">
                        <SelectParameters>
                            <asp:SessionParameter Name="idCliente" SessionField="idClienteNovo" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <p class="style1">
                    <asp:Label ID="lblResp" runat="server" ForeColor="Black"></asp:Label>
                </p>
                <p class="style1">
                    <asp:Label ID="lblErro" runat="server"></asp:Label>
                </p>
                         
            </div>


</asp:Content>

