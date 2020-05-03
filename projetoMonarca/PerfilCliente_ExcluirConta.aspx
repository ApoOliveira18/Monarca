<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_ExcluirConta.aspx.cs" Inherits="PerfilCliente_ExcluirConta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
             <style type="text/css">
                 .cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
}
        .Cad
        { 
           padding:2%;
           -webkit-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
             -moz-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
            box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
            font-family: "Century Gothic";
        }
        .Cad h2
        {
    font-size: 1.3em;
    color: #333;

    font-weight: bold;
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
	background-color: #FFF;
	width:60%;
	height:auto;
	margin:0 auto;
	}
	h1
	{
	    font-size: 3rem;
    line-height: 4.35rem;
    font-weight: 600;
    letter-spacing: .1em;
    text-transform: uppercase;
    margin: 0 auto;
    padding-top: 10px;
    color: #000;
    font-family: "Century Gothic";
    width: 60%;
	    }
    #TextArea1 {
      height: 88px;
    }

                 
                 
    @media screen and (max-width: 1023px) 
{
    .box{
	background-color: #FFF;
	width:90%;
	height:auto;
	margin:0 auto;
	}
    h1
	{
	    font-size: 3rem;
    line-height: 4.35rem;
    font-weight: 600;
    letter-spacing: .1em;
    text-transform: uppercase;
    margin: 0 auto;
    padding-top: 10px;
    color: #000;
    font-family: "Century Gothic";
    width: 90%;
	    }
}
        </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <br />
     <br />
     <br />
    <h1>Exclusão da Conta</h1>
    <br />
    <br />
         <div class="box">
            <div class="Cad">

                <h2>Diga-nos por que está partindo.</h2>
                <br />
                Caso deseje, envie suas sugetões para que possamos melhorar cada vez mais o nosso serviço.<br />
                <br />
              
                <asp:TextBox ID="txtSugestao" runat="server" CssClass="caixa-de-texto-grande" Height="227px" TextMode="MultiLine" Width="100%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtSugestao" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Button ID="btnEnviarSugestao" runat="server" CssClass="btnApp" 
                    Text="Enviar Sugestão" OnClick="btnEnviarSugestao_Click" 
                    ValidationGroup="1" Width="150px" />
                <br />
                <br />
                <asp:Label ID="lblEnviado" runat="server"></asp:Label>
                <br />
                <br />
                <asp:Button ID="btnVoltar" runat="server" CssClass="btnApp" Text="Voltar" OnClick="btnVoltar_Click" />
&nbsp;<asp:Button ID="btnExcluirDef" runat="server" CssClass="btnApp" Text="Excluir Conta" ToolTip="Excluir sua conta definitivamente do site." OnClick="btnExcluirDef_Click" OnClientClick="javascript:return confirm('Tem certeza que deseja EXCLUIR permanentemente sua conta?');" />
                <br />
                <asp:SqlDataSource ID="sqlContaInativa" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                    DeleteCommand="DELETE FROM cliente WHERE (id_cli = @codigo)" 
                    ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                    SelectCommand="SELECT * FROM [cliente]" 
                    UpdateCommand="UPDATE cliente SET status = '1' WHERE (id_cli = @cod)">
                    <DeleteParameters>
                        <asp:SessionParameter Name="codigo" SessionField="idCliente" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:SessionParameter Name="cod" SessionField="idCliente" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlEnviarSugestao" runat="server" ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" InsertCommand="INSERT INTO sugestoes(sugestao) VALUES (@sugestao)" ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [sugestoes]">
                    <InsertParameters>
                        <asp:ControlParameter ControlID="txtSugestao" Name="sugestao" PropertyName="Text" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlDeletarEnderecosVinculados" runat="server" ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" DeleteCommand="DELETE FROM endereco WHERE (id_cli = @cod)" ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [endereco]">
                    <DeleteParameters>
                        <asp:SessionParameter Name="cod" SessionField="idCliente" />
                    </DeleteParameters>
                </asp:SqlDataSource>
            </div>      
         </div>

</asp:Content>

