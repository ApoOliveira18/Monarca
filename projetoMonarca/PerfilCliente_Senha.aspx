<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_Senha.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <link rel="stylesheet" type="text/css" href="css/estilo_perfil_cliente.css"/>
        <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div id="centralizar-total2">
    
<div id="tudo">
    <br />
    <br />
    <h1>Senha</h1>
	<div id="container">
    <br/>


        <div id="info-container">
        	<div class="nome">
        	Senha Atual
        	</div>
            <div class="resultado_senha">

                <asp:TextBox ID="txtSenhaAtual" runat="server" TextMode="Password" 
                    CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="txtSenhaAtual" ErrorMessage="*" CssClass="style14"></asp:RequiredFieldValidator>
            </div>
       
     <asp:Label ID="lblErro" runat="server" 
         style="color: #FF0000"></asp:Label>
        </div>

        
        <div id="info-container">
        	<div class="nome">
        	Nova Senha
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtNovaSenha" runat="server" TextMode="Password" 
                    CssClass="caixa-de-texto"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtNovaSenha" ErrorMessage="*" CssClass="style14"></asp:RequiredFieldValidator>                  
            </div>
             <asp:Label ID="lblExigenciasSenha" runat="server" Font-Size="Smaller"></asp:Label>
       
            <br />
            <br />
       
        </div>
        <div id="info-container">
     <asp:Label ID="lblSenhaCurta" runat="server" 
         style="color: #FF0000" ></asp:Label>
            <br /></div>
         <div id="senha" runat= "server">
        <div id="info-container">
     <asp:Label ID="lblMedidor" runat="server" Text="Força da Senha:" 
         style="color: #666666"></asp:Label>&nbsp;<asp:Image ID="imgForcaSenha" 
         runat="server" Height="25px" Visible="False" Width="230px" />
&nbsp;<br />
      </div>
      </div>
        
        <div id="info-container">
        	<div class="nome">
        	Confirmação da Senha
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtConfSenha" runat="server" TextMode="Password" 
                    CssClass="caixa-de-texto"></asp:TextBox>
                
                <br />
                <asp:CompareValidator ID="CompareValidator1" runat="server" 
         ControlToCompare="txtNovaSenha" ControlToValidate="txtConfSenha" 
         ErrorMessage="SENHAS NÃO COINCIDEM, TENTE NOVAMENTE."></asp:CompareValidator>
            </div>
        </div>

        <div id="info-container">
            <br />
        <asp:Button ID="btnSalvar" runat="server" Text="Salvar" CssClass="btnApp" 
            onclick="btnSalvar_Click" Width="116px" OnClientClick="javascript:return confirm('Tem certeza que deseja alterar sua senha?');" />
            <%--
        <asp:Button ID="btnSair" runat="server" Text="Sair" 
            CssClass="style12" onclick="btnSair_Click" />   --%>&nbsp;<asp:Button 
                ID="btnVoltar" runat="server" CausesValidation="False" CssClass="btnApp" 
                onclick="btnVoltar_Click" Text="Voltar" OnClientClick="javascript:return confirm('Tem certeza que deseja sair sem alterar sua senha?');" />
     
            <br />
            <br />
              </div> 	
        <br />
        <br />
            <br />
        <br />
        <br />
            <br />
      
             <asp:SqlDataSource ID="sqlNovosDados" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM cliente" 
            
            UpdateCommand="UPDATE cliente SET senha_cli = @novaSenha, data_conta = @data_alt WHERE (id_cli = @cod)">
                 <UpdateParameters>
                     <asp:Parameter Name="novaSenha" />
                     <asp:SessionParameter Name="cod" SessionField="idCliente" />
                     <asp:Parameter Name="data_alt" />
                 </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlCompararSenhaAntiga" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_cli, senha_cli FROM cliente WHERE (id_cli = @idcliente)">
            <SelectParameters>
                <asp:SessionParameter Name="idcliente" SessionField="idCliente" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</div>
    </div>

</asp:Content>

