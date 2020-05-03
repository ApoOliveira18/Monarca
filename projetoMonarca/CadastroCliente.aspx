    
 <%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="CadastroCliente.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


                   <!--cadastro cliente-->
        
        <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />

	    <style type="text/css">
            .style1
            {
                color: #FF0000;
            }
            .cd-main-content {
                padding-top: 80px;
                background-color: #f5f5f5;
            }
        </style>

         <script type="text/javascript" src="js/mascara.js"></script>
         <script type="text/javascript" src="text.js"></script>

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

        
        <!---fim cadastro cliente-->

    <script type="text/javascript">
        function hideDiv() {
            document.getElementById('theDiv').hidden = true;
        }
        function showDiv() {
            document.getElementById('theDiv').hidden = false;
        }
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <div class="container">
			<header class="clearfix">
			</header>


    <div id="centralizar-maior">
     <br />
<h1>Cadastre-se</h1>
<br />
<br />

    <div class="formulario-cadastro">
<br />
 <br />
 <h2>Dados Pessoais</h2>
 <br />
        <asp:Label ID="lblConfere" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
 <br />
 <p>Nome:
     <asp:TextBox ID="txtNome" runat="server" Width="293px" 
         CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator20" runat="server" 
         ControlToValidate="txtNome" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <br />
        
 <p>CPF: 
     <asp:TextBox ID="txtCPF" runat="server" ClientIDMode="Static" 
         CssClass="caixa-de-texto"
         onkeyup="formataCPF(this,event);" 
            style="text-align:left" MaxLength="14">

     </asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
         ControlToValidate="txtCPF" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:Label ID="lblCPFUsado" runat="server" 
         style="color: #FF0000"></asp:Label>
     <asp:SqlDataSource ID="sqlVerificarCPFInserido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT CPF_cli FROM cliente WHERE (CPF_cli = @cpf_inserido)">
         <SelectParameters>
             <asp:Parameter Name="cpf_inserido" />
         </SelectParameters>
     </asp:SqlDataSource>
    </p>
    <br />
 <p>RG: 
     <asp:TextBox ID="txtRG" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="12" onkeyup="formataRG(this,event);" style="text-align:left"></asp:TextBox>

    &nbsp;<asp:Label ID="lblRGUsado" runat="server" 
         style="color: #FF0000"></asp:Label>
     <asp:SqlDataSource ID="sqlVerificarRGInserido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT RG_cli FROM cliente WHERE (RG_cli = @rg_inserido) AND (RG_cli IS NOT NULL)">
         <SelectParameters>
             <asp:Parameter Name="rg_inserido" />
         </SelectParameters>
     </asp:SqlDataSource>
    </p>
    <br />
 <p>Sexo: 
     <asp:DropDownList ID="ddlSexo" runat="server" 
         onselectedindexchanged="ddlSexo_SelectedIndexChanged" CssClass="ddls">
         <asp:ListItem>SELECIONE</asp:ListItem>
         <asp:ListItem>Masculino</asp:ListItem>
         <asp:ListItem>Feminino</asp:ListItem>
     </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
         ControlToValidate="ddlSexo" ErrorMessage="*"></asp:RequiredFieldValidator>
     </p>
     <br />
 <p>Data de Nascimento:&nbsp;<asp:TextBox ID="txtDataNascimento" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="10" onkeyup="formataData(this,event);" style="text-align:left"></asp:TextBox>

&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" 
         ControlToValidate="txtDataNascimento" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:Label ID="lblMaiores18" runat="server" ForeColor="Red"></asp:Label>
    </p>
    <br />
 <p>Telefone: 
     <asp:TextBox ID="txtTel1" runat="server" ClientIDMode="Static" 
         CssClass="caixa-de-texto" onkeyup="formataTelefone(this,event);" 
            style="text-align:left" MaxLength="14" >
     </asp:TextBox>

&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
         ControlToValidate="txtTel1" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <br />
 <p>Celular:
     <asp:TextBox ID="txtTel2" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="15" onkeyup="formataCelular(this,event);" style="text-align:left"></asp:TextBox>
    &nbsp;</p>
    <br />
 <p>Estado Civil: 
     <asp:DropDownList ID="ddlEstCiv" runat="server" 
         onselectedindexchanged="ddlEstCiv_SelectedIndexChanged" CssClass="ddls">
         <asp:ListItem>SELECIONE</asp:ListItem>
         <asp:ListItem>Casado</asp:ListItem>
         <asp:ListItem>Solteiro</asp:ListItem>
         <asp:ListItem>Divorciado</asp:ListItem>
         <asp:ListItem>Viúvo</asp:ListItem>
     </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
         ControlToValidate="ddlEstCiv" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <br />
    <p>CEP:
        <asp:TextBox ID="txtCEP" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="9" onkeyup="formataCEP(this,event);" style="text-align:left"></asp:TextBox>
&nbsp;<asp:Button ID="btnOK" runat="server" Text="Pesquisar" onclick="btnOK_Click" 
            CausesValidation="False" CssClass="btnApp" Height="20px" />
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
            ControlToValidate="txtCEP" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
<asp:Label ID="lblErro" runat="server" style="color: #FF0000"></asp:Label>

    </p>
    <br />
    <p>Endereço:
        <asp:TextBox ID="txtRua" runat="server" ReadOnly="True" Enabled="False" 
            Width="239px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <br />
    <p>Número:
        <asp:TextBox ID="txtNumero" runat="server" CssClass="caixa-de-texto"
            onkeyup="formataInteiro(this,event);" 
            style="text-align:left"></asp:TextBox>
        &nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" 
            ControlToValidate="txtNumero" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <br />
    <p>Complemento:
        <asp:TextBox ID="txtComplemento" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;</p>
<br />
    <p>Bairro:
        <asp:TextBox ID="txtBairro" runat="server" ReadOnly="True" Enabled="False" 
            Width="195px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <br />
    <p>Cidade:
        <asp:TextBox ID="txtCidade" runat="server" ReadOnly="True" Enabled="False" 
            Width="203px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <br />
    <p>Estado (UF):
        <asp:TextBox ID="txtEstado" runat="server" ReadOnly="True" Enabled="False" 
            Width="46px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <br />
    <p>Usuário: 
     <asp:TextBox ID="txtUsuario" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
         ControlToValidate="txtUsuario" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;</p>
        <p><asp:Label ID="lblUsuarioJaExiste" runat="server" 
            style="color: #FF0000"></asp:Label>
     <asp:SqlDataSource ID="sqlVerificarUsuarioEscolhido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         
            SelectCommand="SELECT login_cli FROM cliente WHERE (login_cli = @usu_escolhido)">
         <SelectParameters>
             <asp:Parameter Name="usu_escolhido" />
         </SelectParameters>
     </asp:SqlDataSource>
    </p>
    <br />
 <p>E-mail:
     <asp:TextBox ID="txtEmail" runat="server" Width="250px" 
         placeholder="nome@exemplo.com.br" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
         ControlToValidate="txtEmail" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;</p>
        <p><asp:Label ID="lblEmailJaCadastrado" runat="server" 
         style="color: #FF0000"></asp:Label>&nbsp;<asp:LinkButton ID="lbEsqueceuSuaSenha"
             runat="server" CssClass="fonte-desc" 
         onclick="lbEsqueceuSuaSenha_Click" Visible="False" ValidationGroup="1">Clique aqui.</asp:LinkButton>
     <asp:SqlDataSource ID="sqlVerificarEmailEscolhido" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT email_cli FROM cliente WHERE (email_cli = @email_escolhido)">
         <SelectParameters>
             <asp:Parameter Name="email_escolhido" />
         </SelectParameters>
     </asp:SqlDataSource>
    </p>
    <br />
 
 
        
     <p>Senha: 
     <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" 
         CssClass="caixa-de-texto" onkeyup="javascript:passStr()" onfocus="showDiv();" onblur="hideDiv();"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" 
         ControlToValidate="txtSenha" ErrorMessage="*"></asp:RequiredFieldValidator>
            <p>
            <br />
                <asp:Label ID="lblExigenciasSenha" runat="server" Font-Size="Smaller"></asp:Label>
            <p>
     <asp:Label ID="lblSenhaCurta" runat="server" 
         style="color: #FF0000"></asp:Label>
      <br />

      <br />


      <div id="theDiv" runat="server" ClientIDMode="Static">
        
                <div id="cadeado">
                <img src="images/lock.png" />
                <br />
                <h2>&nbsp;&nbsp;Dicas para a sua senha:</h2>
                <br />
                </div>

                <div id="texto-dica">
         
                <ul> 
                    <li>•Inclua letras maiúsculas, minúsculas, números e caracteres especiais.</li>
                    <br />
                    <li>•Use pelos menos oito caracteres.</li>
                    <br />
                    <li>•Opte por uma senha diferente das demais que já usa.</li>
                    <br />
                </ul>
                </div>
      </div>
         <br /><div id="senha" runat= "server">
                
     <asp:Label ID="lblMedidor" runat="server" Text="Força da Senha:" 
         style="color: #666666"></asp:Label>&nbsp;<asp:Image ID="imgForcaSenha" 
         runat="server" Height="25px" Visible="False" Width="230px" />
&nbsp;<br />
                  </div>
        </p>


           
        <br />
 <p>Confirmação da Senha:
     <asp:TextBox ID="txtConfSenha" runat="server" TextMode="Password" 
         CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator23" runat="server" 
         ControlToValidate="txtConfSenha" ErrorMessage="*"></asp:RequiredFieldValidator>
     &nbsp;<br /><asp:CompareValidator ID="CompareValidator1" runat="server" 
         ControlToCompare="txtSenha" ControlToValidate="txtConfSenha" 
         ErrorMessage="SENHAS NÃO COINCIDEM, TENTE NOVAMENTE."></asp:CompareValidator>
    </p>
    <br />
    <p>Pergunta Secreta:
        <asp:TextBox ID="txtPergSecreta" runat="server" CssClass="caixa-de-texto" 
            Width="300px"></asp:TextBox>
    </p>
    <br />
    <p>Resposta Secreta:
        <asp:TextBox ID="txtRespSecreta" runat="server" CssClass="caixa-de-texto" 
            Width="200px"></asp:TextBox>
    </p>
        <br />
    <p class="style1">(*) Campos Obrigatórios!</p>
    <br />
    <p>
    
        <asp:Button ID="btnCadastrar" runat="server" onclick="btnCadastrar_Click" 
            Text="Cadastrar" CssClass="btnApp" />
            &nbsp;
        <asp:Button ID="btnVoltar" runat="server" onclick="btnVoltar_Click" 
            Text="Voltar ao Início" CssClass="btnApp" CausesValidation="False" />
    </p>
    <br />
    </div>
    </div>
    <p>
        <asp:SqlDataSource ID="sqlCadastro" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO cliente(login_cli, nome_cli, email_cli, senha_cli, CPF_cli, RG_cli, sexo_cli, dtNasc_cli, tel_cli, outroTel_cli, estciv_cli, CEP_cli, num_cli, compl_cli, perg_cli, resp_cli, data_conta, status) VALUES (@usuario, @nome, @email, @senha, @cpf, @rg, @sexo, @datanasc, @tel1, @tel2, @estciv, @cep, @numero, @complemento, @pergunta, @resposta, @datacad, '0')" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [cliente]">
            <InsertParameters>
                <asp:Parameter Name="nome" />
                <asp:Parameter Name="usuario" />
                <asp:Parameter Name="email" />
                <asp:Parameter Name="senha" />
                <asp:Parameter Name="cpf" />
                <asp:Parameter Name="rg" />
                <asp:Parameter Name="sexo" />
                <asp:Parameter Name="datanasc" />
                <asp:Parameter Name="tel1" />
                <asp:Parameter Name="tel2" />
                <asp:Parameter Name="estciv" />
                <asp:Parameter Name="cep" />
                <asp:ControlParameter ControlID="txtNumero" Name="numero" PropertyName="Text" />
                <asp:Parameter Name="complemento" />
                <asp:Parameter Name="pergunta" />
                <asp:Parameter Name="resposta" />
                <asp:Parameter Name="datacad" />
            </InsertParameters>
        </asp:SqlDataSource>
    </p>
                 <p>
                     &nbsp;</p>
    <br />
    <br />
    </div>
    </asp:Content>

