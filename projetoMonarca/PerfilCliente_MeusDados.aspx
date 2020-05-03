<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_MeusDados.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="stylesheet" type="text/css" href="css/estilo_perfil_cliente.css"/>
        <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />
<style>
.cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div id="centralizar-total2">
<div id="tudo">
    <br />
    <br />
    <h1>Meus Dados</h1>

	<div id="container"> 
        <div id="info-container">
        	<div class="nome">
        	Nome
        	</div>
            <div class="resultado">
                <asp:Label ID="lblNome" runat="server" CssClass="style3"></asp:Label>
            </div>
        </div>
        <div class="linha-nome"></div>
        
        <div id="info-container">
        	<div class="nome">
        	Data de Nascimento
        	</div>
            <div class="resultado">
                <asp:Label ID="lblData" runat="server" CssClass="style3"></asp:Label>
            </div>
        </div>
        <div class="linha-nome"></div>
        
        
        <div id="info-container">
        	<div class="nome">
        	Endereço de Email
        	</div>
            <div class="resultado">
            &nbsp;<asp:Label ID="lblEnd" runat="server" CssClass="style3"></asp:Label>
            </div>
        </div>
        <div class="linha-nome"></div>
        
        
       <div id="info-container">
        	<div class="nome">
        	Número de Telefone
        	</div>
            <div class="resultado">
            &nbsp;<asp:Label ID="lblTel" runat="server" CssClass="style3"></asp:Label>
            </div>
        </div>
        <div class="linha-nome"></div>
       
        
       <div id="info-container">
        	<div class="nome">
        	CPF
        	</div>
            <div class="resultado">
            &nbsp;<asp:Label ID="lblCPF" runat="server" CssClass="style3"></asp:Label>
            </div>
        </div>
        <div class="linha-nome"></div>
        
       <div id="info-container">
        	<div class="nome">
        	    CEP
        	</div>
            <div class="resultado">
                <asp:Label ID="lblCEP" runat="server" CssClass="style3"></asp:Label></div> 

          
           
           </div>
        
        <asp:SqlDataSource ID="sqlBusca" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            SelectCommand="SELECT nome_cli, CPF_cli, dtNasc_cli, tel_cli, email_cli, CEP_cli FROM cliente WHERE (id_cli = @cod)">
            <SelectParameters>
                <asp:SessionParameter Name="cod" SessionField="idCliente" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div class="linha-nome"></div>
        <br />
        <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btnApp"   onclick="tnEditar_Click" />
             &nbsp;
        <asp:Button ID="btnSair" runat="server" Text="Voltar"  CssClass="btnApp" onclick="btnSair_Click" />  
           <br />
           <br />
           
           <br />
           <div class="topo-container-dados"><a href="PerfilCliente_Enderecos.aspx" >Endereços</a>
           <br />
           <br />
           <a href="PerfilCliente_Senha.aspx">Senha</a>
           <br />
           <br />
           <asp:LinkButton ID="lbDeletarConta" runat="server" OnClick="lbDeletarConta_Click">Excluir Minha Conta</asp:LinkButton></div>
           <br />
           <br />
             
       
    </div>
</div>

    
    </div>
</asp:Content>

