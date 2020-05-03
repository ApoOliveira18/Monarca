<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_Editar.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <link rel="stylesheet" type="text/css" href="css/estilo_perfil_cliente.css"/>
       
    
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


    <div id="centralizar-total3">

<div id="tudo">
<br />
    <br />
    <h1>Atualizar Meus Dados</h1>
	<div id="container">
    	<asp:SqlDataSource ID="sqlBusca" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT nome_cli, login_cli, CPF_cli, dtNasc_cli, tel_cli, email_cli, RG_cli, sexo_cli, outroTel_cli, estciv_cli, CEP_cli, num_cli, compl_cli, perg_cli, resp_cli, data_conta FROM cliente WHERE (id_cli = @pesq)">
            <SelectParameters>
                <asp:SessionParameter Name="pesq" SessionField="idCliente" />
            </SelectParameters>
            </asp:SqlDataSource>

        
        
        <div id="info-container">
        	<div class="nome">
        	    Nome</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtNome" runat="server" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" 
                    ControlToValidate="txtNome"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Login
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtLogin" runat="server" CssClass="caixa-de-texto" 
                    ontextchanged="txtLogin_TextChanged"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
         ControlToValidate="txtLogin" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:Label ID="lblUsuarioJaExiste" runat="server" 
            style="font-weight: 700; color: #FF0000"></asp:Label>
     <asp:SqlDataSource ID="sqlVerificarUsuarioEscolhido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         
            
                    SelectCommand="SELECT login_cli, id_cli FROM cliente WHERE (login_cli = @usu_escolhido) AND (id_cli &lt;&gt; @cod_usu)">
         <SelectParameters>
             <asp:Parameter Name="usu_escolhido" />
             <asp:SessionParameter Name="cod_usu" SessionField="idCliente" />
         </SelectParameters>
     </asp:SqlDataSource>
            </div>
        </div>
        
        
        <div id="info-container">
        	<div class="nome">
        	Endereço de Email
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtEmail" runat="server" CssClass="caixa-de-texto" 
                    ontextchanged="txtEmail_TextChanged"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
         ControlToValidate="txtEmail" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:Label ID="lblEmailJaCadastrado" runat="server" 
         style="font-weight: 700; color: #FF0000"></asp:Label>&nbsp;<asp:LinkButton ID="lbEsqueceuSuaSenha"
             runat="server" CssClass="fonte-desc" 
         onclick="lbEsqueceuSuaSenha_Click" Visible="False">Clique aqui.</asp:LinkButton>
     <asp:SqlDataSource ID="sqlVerificarEmailEscolhido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         
                    SelectCommand="SELECT email_cli FROM cliente WHERE (email_cli = @email_escolhido) AND (id_cli &lt;&gt; @cod_usu)">
         <SelectParameters>
             <asp:Parameter Name="email_escolhido" />
             <asp:SessionParameter Name="cod_usu" SessionField="idCliente" />
         </SelectParameters>
     </asp:SqlDataSource>
            </div>
        </div>
       
        
        <div id="info-container">
        	<div class="nome">
        	    CPF</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtCPF" runat="server" CssClass="caixa-de-texto" 
                    ontextchanged="txtCPF_TextChanged"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
         ControlToValidate="txtCPF" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:Label ID="lblCPFUsado" runat="server" 
         style="font-weight: 700; color: #FF0000"></asp:Label>
     <asp:SqlDataSource ID="sqlVerificarCPFInserido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         
                    SelectCommand="SELECT CPF_cli FROM cliente WHERE (CPF_cli = @cpf_inserido) AND (id_cli &lt;&gt; @cod_usu)">
         <SelectParameters>
             <asp:Parameter Name="cpf_inserido" />
             <asp:SessionParameter Name="cod_usu" SessionField="idCliente" />
         </SelectParameters>
     </asp:SqlDataSource>
            </div>
            <br /></div>

        
        <div id="info-container">
        	<div class="nome">
        	    RG</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtRG" runat="server" CssClass="caixa-de-texto" 
                    ontextchanged="txtRG_TextChanged"></asp:TextBox>&nbsp;<asp:Label ID="lblRGUsado" runat="server" 
         style="font-weight: 700; color: #FF0000"></asp:Label>
     <asp:SqlDataSource ID="sqlVerificarRGInserido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         
                    SelectCommand="SELECT RG_cli FROM cliente WHERE (RG_cli = @rg_inserido) AND (RG_cli IS NOT NULL) AND (id_cli &lt;&gt; @cod_usu)">
         <SelectParameters>
             <asp:Parameter Name="rg_inserido" />
             <asp:SessionParameter Name="cod_usu" SessionField="idCliente" />
         </SelectParameters>
     </asp:SqlDataSource></div>
        </div>

       
        <div id="info-container">
        	<div class="nome">
        	    Sexo</div>
            <div class="resultado_senha">
     <asp:DropDownList ID="ddlSexo" runat="server" CssClass="ddls" 
                    onselectedindexchanged="ddlSexo_SelectedIndexChanged" >
         <asp:ListItem>SELECIONE</asp:ListItem>
         <asp:ListItem>Masculino</asp:ListItem>
         <asp:ListItem>Feminino</asp:ListItem>
         <asp:ListItem>Outros</asp:ListItem>
     </asp:DropDownList>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" 
                    ControlToValidate="ddlSexo"></asp:RequiredFieldValidator>
            </div>
        </div>

      
        
        <div id="info-container">
        	<div class="nome">
        	    Data de Nascimento</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtDataNascimento" runat="server" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" 
                    ControlToValidate="txtDataNascimento"></asp:RequiredFieldValidator>
            &nbsp;<asp:Label ID="lblMaiores18" runat="server"></asp:Label>
            </div>
        </div>
        
        
        <div id="info-container">
        	<div class="nome">
        	    Telefone 1 (Fixo)</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtTel1" runat="server" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator8" runat="server" ErrorMessage="*" 
                    ControlToValidate="txtTel1"></asp:RequiredFieldValidator>
            </div>
        </div>
        
        
        <div id="info-container">
        	<div class="nome">
        	    Telefone 2 (Celular e outros)</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtTel2" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
            </div>
        </div>
        
        
        <div id="info-container">
        	<div class="nome">
        	    Estado Civil</div>
            <div class="resultado_senha">
     <asp:DropDownList ID="ddlEstCiv" runat="server" CssClass="ddls" 
                    onselectedindexchanged="ddlEstCiv_SelectedIndexChanged" >
         <asp:ListItem>SELECIONE</asp:ListItem>
         <asp:ListItem>Casado</asp:ListItem>
         <asp:ListItem>Solteiro</asp:ListItem>
         <asp:ListItem>Divorciado</asp:ListItem>
         <asp:ListItem>Viúvo</asp:ListItem>
     </asp:DropDownList>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" 
                    ControlToValidate="ddlEstCiv"></asp:RequiredFieldValidator>
            </div>
       
        
        
        </div>
        
        <div id="info-container">
       <div class="nome">
        	    CEP</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtCEP" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;
&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" 
                    ControlToValidate="txtCEP"></asp:RequiredFieldValidator>
                    &nbsp;
                 <asp:Button ID="btnOK" runat="server" onclick="btnOK_Click" Text="Pesquisar" CssClass="ddls" Height="36px" />
            </div>
        
            &nbsp;
            <asp:Label ID="lblErro" runat="server" 
            style="font-weight: 700; color: #FF0000"></asp:Label>
        
        
        </div>
       
        <div id="info-container">
        	<div class="nome">
        	    Endereço</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtRua" runat="server" Enabled="False" Width="237px" CssClass="caixa-de-texto"></asp:TextBox>
            </div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Número</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtNumero" runat="server" Width="63px" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator10" runat="server" ErrorMessage="*" 
                    ControlToValidate="txtNumero"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Complemento</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtComplemento" runat="server" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;
            </div>
        </div>
        
        
        <div id="info-container">
        	<div class="nome">
        	    Bairro</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtBairro" runat="server" Width="159px" Enabled="False" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;
            </div>
        </div>
       
        <div id="info-container">
        	<div class="nome">
        	    Cidade</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtCidade" runat="server" Width="219px" Enabled="False" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;</div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Estado (UF)</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtEstado" runat="server" Width="40px" Enabled="False" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;</div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Pergunta Secreta</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtPergunta" runat="server" Width="300px" Enabled="True" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;</div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Resposta</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtResposta" runat="server" Width="200px" Enabled="True" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;</div>
        </div>
    
        <asp:SqlDataSource ID="sqlNovosDados" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [cliente]" 
            
            
            
            
            
            UpdateCommand="UPDATE cliente SET nome_cli = @nome, email_cli = @email, CPF_cli = @cpf, RG_cli = @rg, sexo_cli = @sexo, dtNasc_cli = @datanasc, tel_cli = @tel1, outroTel_cli = @tel2, estciv_cli = @estciv, CEP_cli = @cep, login_cli = @login, num_cli = @numero, compl_cli = @complemento, perg_cli = @pergunta, resp_cli = @resposta WHERE (id_cli = @cod)">
            <UpdateParameters>
                <asp:Parameter Name="nome" />
                <asp:Parameter Name="cep" />
                <asp:Parameter Name="cpf" />
                <asp:Parameter Name="estciv" />
                <asp:Parameter Name="sexo" />
                <asp:Parameter Name="datanasc" />
                <asp:Parameter Name="tel1" />
                <asp:Parameter Name="tel2" />
                <asp:Parameter Name="email" />
                <asp:SessionParameter Name="cod" SessionField="idCliente" />
                <asp:Parameter Name="rg" />
                <asp:Parameter Name="login" />
                <asp:ControlParameter ControlID="txtNumero" Name="numero" 
                    PropertyName="Text" />
<asp:Parameter Name="complemento"></asp:Parameter>
                <asp:Parameter Name="pergunta" />
                <asp:Parameter Name="resposta" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:Button ID="tnEditar" runat="server" Text="Salvar" CssClass="btnApp" onclick="tnEditar_Click"  OnClientClick="javascript:return confirm('Tem certeza que deseja alterar seus dados?');" />

       &nbsp;<asp:Button ID="btnSair" runat="server" Text="Voltar" 
            CssClass="btnApp" onclick="btnSair_Click" 
            OnClientClick="javascript:return confirm('Tem certeza que deseja sair sem salvar?');"  />   
            
       
    </div>
</div>

    </div>
    <br />

</asp:Content>

