<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_Entrar.aspx.cs" Inherits="teste_cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
.cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
    height: 850px;
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


<div class="caixa-de-login">
    
    <br />
    <br />
    <h1>Login</h1>

    <div class="conteudo-de-login">
        <br />
        <br />
        <h2>Já sou cliente:</h2>
        <br />
        <br />              
        <div id="info-container">
        	<div class="nome">
        	    Usuário</div>
            <div class="caixas">
                <asp:TextBox ID="txtLogin" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtLogin" ErrorMessage="*"></asp:RequiredFieldValidator>
            </div>
        </div>
        <br />
        <br />
        <div id="info-container">
        	<div class="nome">
        	    Senha 
        	</div>
            <div class="caixas">
                <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" 
                    CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtSenha" ErrorMessage="*"></asp:RequiredFieldValidator>
                <br />
                <br />
                <asp:Label ID="lblErro" runat="server" style="color: #FF0000"></asp:Label>
            </div>
        </div>
      
        
        <asp:SqlDataSource ID="sqlLogin" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            SelectCommand="SELECT id_cli, login_cli, senha_cli, status FROM cliente WHERE (login_cli = @login) AND (senha_cli = @senha) AND (status = '0')">
            <SelectParameters>
                <asp:Parameter Name="login" />
                <asp:Parameter Name="senha" />
            </SelectParameters>
        </asp:SqlDataSource>

                 <asp:SqlDataSource ID="sqlManterLogado" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM loginrecentecli"></asp:SqlDataSource>

         <asp:SqlDataSource ID="sqlAtualizarRecente" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM [loginrecentecli]" 
             UpdateCommand="UPDATE loginrecentecli SET login_rec_cli = @login">
             <UpdateParameters>
                 <asp:ControlParameter ControlID="txtLogin" Name="login" PropertyName="Text" />
             </UpdateParameters>
         </asp:SqlDataSource>

         <asp:SqlDataSource ID="sqlApagarRecente" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             DeleteCommand="DELETE FROM loginrecentecli" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM [loginrecentecli]"></asp:SqlDataSource>

         <asp:SqlDataSource ID="sqlSalvarRecente" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             InsertCommand="INSERT INTO loginrecentecli(login_rec_cli) VALUES (@login)" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM [loginrecentecli]">
             <InsertParameters>
                 <asp:ControlParameter ControlID="txtLogin" Name="login" PropertyName="Text" />
             </InsertParameters>
         </asp:SqlDataSource>
         <br />
         <br />
        <div id="info-container">
            <asp:CheckBox ID="chkManterLogado" runat="server" Text="Manter conectado" 
                />
            &nbsp;
            &nbsp;<asp:LinkButton ID="lbEsqueceuSuaSenha" runat="server" 
                OnClick="lbEsqueceuSuaSenha_Click" CausesValidation="False" 
                Font-Underline="False" CssClass="style1">Esqueceu Sua Senha?</asp:LinkButton>
                      
        </div>

        <br />
        <br />
       
        <div id="info-container">
            <div id="captcha" runat= "server">
                <asp:Label ID="lblCaptcha" runat="server" ></asp:Label>
                <br />
                <br />
                
                <asp:Image ID="Image1" runat="server" ImageUrl="~/CImage.aspx"/>
                    <asp:Label ID="lblmsg" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
                    <br />
                    <br />
                <asp:TextBox ID="txtimgcode" runat="server" ValidationGroup="2" 
                    CssClass="caixa-de-texto"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                      ControlToValidate="txtimgcode" ErrorMessage="*" ValidationGroup="2"></asp:RequiredFieldValidator>
                    <asp:Button ID="btnRecuperar" runat="server" CssClass="btnApp" 
                      OnClick="btnRecuperar_Click" Text="Recuperar Senha" ValidationGroup="2" 
                       Visible="False" />
                 
                    <br />
                <br />
                
             </div>

            <asp:Button ID="btnEditarApos3Erros" runat="server" Text="Entrar" CssClass="btnApp" 
            onclick="btnEditarApos3Erros_Click" ValidationGroup="2" Visible="False" />
            <asp:Button ID="btnEditar" runat="server" Text="Entrar" CssClass="btnApp" 
            onclick="btnEditar_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
               
            <asp:SqlDataSource ID="sqlDataCliente" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT id_cli, nome_cli, email_cli, data_conta FROM cliente WHERE (id_cli = @cod)">
                <SelectParameters>
                    <asp:SessionParameter Name="cod" SessionField="idClienteSenha" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlResetarSenha" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT * FROM [cliente]" 
                UpdateCommand="UPDATE cliente SET senha_cli = @senha, data_conta = @data_alt WHERE (id_cli = @cod)">
                <UpdateParameters>
                    <asp:SessionParameter Name="cod" SessionField="idClienteSenha" />
                    <asp:Parameter Name="senha" />
                    <asp:Parameter Name="data_alt" />
                </UpdateParameters>
            </asp:SqlDataSource>
             <br />
             <br />  
            <br />
        </div>

    </div>

    <div class="conteudo-cadastro">
    <br />
        <br />
        <h2>Novo cliente:</h2>
        <br />
        <br />
            <div class="nome">
        	    Nome Completo</div>
            <div class="caixas">
                <asp:TextBox ID="txtNomeCli" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="txtNomeCli" ErrorMessage="*" ValidationGroup="3" ></asp:RequiredFieldValidator>
            </div>
            <br />
            <br />
            <div class="nome">
        	    Email</div>
            <div class="caixas">
                <asp:TextBox ID="txtEmailCli" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                    ControlToValidate="txtEmailCli" ErrorMessage="*" ValidationGroup="3" ></asp:RequiredFieldValidator>
            </div>
            <br />
            <br />
          
            <br /><br />
            <br /><br />
            

              
        <asp:Button ID="btnCadastro" runat="server" Text="Cadastre-se" 
            CssClass="btnApp" onclick="btnCadastro_Click" CausesValidation="True" 
            ValidationGroup="3" />
            <br /><br /><br />
          
            
 
     

    </div>

</div>
<br />
<br />

</asp:Content>

