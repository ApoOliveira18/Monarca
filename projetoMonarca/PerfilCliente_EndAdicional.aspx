<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_EndAdicional.aspx.cs" Inherits="PerfilCliente_EndAdicional" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="css/estilo_perfil_cliente.css"/>
        <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />
                <style>
.cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
}
</style>


<script type="text/javascript" src="js/mascara.js"></script>
 <%-- MÁSCARA
    
    http://www.devmedia.com.br/mascara-em-asp-net-com-javascript/10252

    Este código não deu conflito com os js já existente no projeto

    Abaixo, segue os comandos para o campo desejado. Não esquecer de mudar o MaxLength="" para ser digitado apenas a qtd necessária
    
    formataCEP – para campos CEP;
    formataCNPJ – para campos CNPJ;
    formataRG – para campos RG;
    formataCPF – para campos CPF;
    formataData – para campos data (dd/MM/yyyy);
    formataMesAno – para campos que somente aceitam o mês e o ano juntos (MM/yyyy);
    formataHora – para campos hora (HH:mm);
    formataInteiro – para campos aonde só aceitam números inteiros;
    formataDouble – para números flutuantes Ex: 3,14159265;
    formataTelefone – para campos com só com telefone com DDD (00) 0000-0000;
    formataCelular – para campos com nono digito com DDD (00) 00000-0000;

        

            <asp:TextBox ID="TextBox1" runat="server"
             onkeyup="formataCPF(this,event);" 
            style="text-align:left" MaxLength="14"></asp:TextBox>

        --%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
<div id="centralizar-total2">
    
    <div id="topo-2">
</div>
<div id="tudo">
    <br />
    <br />
    <h1>Cadastrar Novo Endereço</h1>
	<div id="container">
        <div id="info-container">
        	<div class="nome">
        	    Nome
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtNome" runat="server"
                    CssClass="caixa-de-texto" Width="206px" ValidationGroup="1"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ControlToValidate="txtNome" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>
        
        <div id="info-container">
        	<div class="nome">
        	    CEP
        	</div>
            <div class="resultado_senha">

                <asp:TextBox ID="txtCEP" runat="server" onkeyup="formataCEP(this,event);" CssClass="caixa-de-texto"
            style="text-align:left" MaxLength="09"></asp:TextBox>
                &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ControlToValidate="txtCEP" ErrorMessage="*" CssClass="style14" ValidationGroup="2"></asp:RequiredFieldValidator>
                &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                    ControlToValidate="txtCEP" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
                <asp:Button ID="btnOK" runat="server" onclick="btnOK_Click" Text="Pesquisar" CssClass="ddls" Height="36px" CausesValidation="True" ValidationGroup="2" />
                &nbsp;
                
            </div>
        </div>
        <div id="info-container">
        <div class="resultado_senha">
        <asp:Label ID="lblErro" runat="server" CssClass="style11" ForeColor="Red"></asp:Label>
        </div>
        </div>
        
        <div id="info-container">
        	<div class="nome">
        	    Endereço
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtRua" runat="server"
                    CssClass="caixa-de-texto" Width="206px" Enabled="False" 
                    ValidationGroup="1"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ControlToValidate="txtRua" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Número
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtNumero" runat="server"
                    CssClass="caixa-de-texto" Width="47px" Enabled="True" ValidationGroup="1"></asp:TextBox>
                &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtNumero" ErrorMessage="*" CssClass="style14" 
                    ValidationGroup="1"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Complemento
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtComplemento" runat="server"
                    CssClass="caixa-de-texto" Width="113px" Enabled="True"></asp:TextBox>
            </div>
        &nbsp;</div>
        
        <div id="info-container">
        	<div class="nome">
        	    Bairro
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtBairro" runat="server"
                    CssClass="caixa-de-texto" Width="148px" Enabled="False" 
                    ValidationGroup="1"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ControlToValidate="txtBairro" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Cidade
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtCidade" runat="server"  
                    CssClass="caixa-de-texto" Width="183px" Enabled="False" 
                    ValidationGroup="1"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                ControlToValidate="txtCidade" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Estado
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtEstado" runat="server" 
                    CssClass="caixa-de-texto" Width="36px" Enabled="False" MaxLength="2" ValidationGroup="1"></asp:TextBox>

            </div>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                ControlToValidate="txtEstado" ErrorMessage="*" ValidationGroup="1"></asp:RequiredFieldValidator>
        </div>
        <br
        <div id="info-container">
            <asp:SqlDataSource ID="sqlInserirEndAdicional" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO endereco(CEP_cli, num_cli, compl_cli, id_cli, nome_end, cidade_end, rua_end, estado_end) VALUES (@cep, @numero, @compl, @cliente, @nome, @cidade, @rua, @estado)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [endereco]">
                <InsertParameters>
                    <asp:Parameter Name="cep" />
                    <asp:ControlParameter ControlID="txtNumero" Name="numero" PropertyName="Text" />
                    <asp:Parameter Name="compl" />
                    <asp:SessionParameter Name="cliente" SessionField="idCliente" />
                    <asp:Parameter Name="nome" />
                    <asp:Parameter Name="cidade" />
                    <asp:Parameter Name="rua" />
                    <asp:Parameter Name="estado" />
                </InsertParameters>
            </asp:SqlDataSource>
        <asp:Button ID="btnSalvar" runat="server" Text="Salvar" CssClass="btnApp" 
             Width="116px" OnClick="btnSalvar_Click" ValidationGroup="1" />
            <%--
        <asp:Button ID="btnSair" runat="server" Text="Sair" 
            CssClass="style12" onclick="btnSair_Click" />   --%>&nbsp;<asp:Button 
                ID="btnVoltar" runat="server" CausesValidation="False" CssClass="btnApp" 
                 Text="Voltar" OnClientClick="javascript:return confirm('Tem certeza que deseja sair sem adicionar o endereço?');" OnClick="btnVoltar_Click" />
     
            <br />
            <br />
              </div>
        <br />
        <br />
         	
    </div>
</div>
    </div>

</asp:Content>

