<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="EditarCliente.aspx.cs" Inherits="EditarCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .style1
        {
            color: #FF0000;
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
        <h1 class="posicionamento">Editar Cliente</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
 <asp:SqlDataSource ID="sqlClienteCadastrado" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            
            SelectCommand="SELECT id_cli, login_cli, nome_cli, email_cli, senha_cli, CPF_cli, RG_cli, sexo_cli, dtNasc_cli, tel_cli, outroTel_cli, estciv_cli, CEP_cli, num_cli, compl_cli, data_conta FROM cliente WHERE (id_cli = @cod)">
        <SelectParameters>
            <asp:SessionParameter Name="cod" SessionField="codCliente" />
        </SelectParameters>
        </asp:SqlDataSource>
        
 <p>Nome: 
     <asp:TextBox ID="txtNome" runat="server" Width="293px" 
         CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator19" runat="server" 
         ControlToValidate="txtNome" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
 <p>E-mail:
     <asp:TextBox ID="txtEmail" runat="server" Width="250px" 
         CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
         ControlToValidate="txtEmail" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
 <p>CPF: 
     <asp:TextBox ID="txtCPF" runat="server" ClientIDMode="Static" 
         CssClass="caixa-de-texto"
         onkeyup="formataCPF(this,event);" 
            style="text-align:left" MaxLength="14">

     </asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
         ControlToValidate="txtCPF" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
 <p>RG: 
     <asp:TextBox ID="txtRG" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="12" 
         onkeyup="formataRG(this,event);" style="text-align:left"></asp:TextBox>
    </p>
 <p>Sexo: 
     <asp:DropDownList ID="ddlSexo" runat="server" CssClass="ddls" >
         <asp:ListItem>SELECIONE</asp:ListItem>
         <asp:ListItem>Masculino</asp:ListItem>
         <asp:ListItem>Feminino</asp:ListItem>
         <asp:ListItem>Outros</asp:ListItem>
     </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
         ControlToValidate="ddlSexo" ErrorMessage="*"></asp:RequiredFieldValidator>
&nbsp;</p>
 <p>Data de Nascimento: 
     <asp:TextBox ID="txtDataNascimento" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="10" onkeyup="formataData(this,event);" style="text-align:left"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
         ControlToValidate="txtDataNascimento" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:Label ID="lblMaiores18" runat="server"></asp:Label>
    </p>
 <p>Telefone 1 (Fixo): 
      <asp:TextBox ID="txtTel1" runat="server" ClientIDMode="Static" 
         CssClass="caixa-de-texto" onkeyup="formataTelefone(this,event);" 
            style="text-align:left" MaxLength="14" >
     </asp:TextBox>

&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
         ControlToValidate="txtTel1" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
 <p>Telefone 2 (Celular ou Outros):
     <asp:TextBox ID="txtTel2" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="15" onkeyup="formataCelular(this,event);" style="text-align:left"></asp:TextBox>
    </p>
 <p>Estado Civil: 
     <asp:DropDownList ID="ddlEstCiv" runat="server" CssClass="ddls">
         <asp:ListItem>SELECIONE</asp:ListItem>
         <asp:ListItem>Casado</asp:ListItem>
         <asp:ListItem>Solteiro</asp:ListItem>
         <asp:ListItem>Divorciado</asp:ListItem>
         <asp:ListItem>Viúvo</asp:ListItem>
     </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
         ControlToValidate="ddlEstCiv" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>CEP:
        <asp:TextBox ID="txtCEP" runat="server" ClientIDMode="Static" CssClass="caixa-de-texto" MaxLength="9" onkeyup="formataCEP(this,event);" style="text-align:left"></asp:TextBox>
&nbsp;<asp:Button ID="btnOK" runat="server" Text="Pesquisar" onclick="btnOK_Click" 
            CausesValidation="False" CssClass="btnApp" Height="21px" />
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
            ControlToValidate="txtCEP" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
<asp:Label ID="lblErro" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>

    </p>
    <p>Endereço:
        <asp:TextBox ID="txtRua" runat="server" ReadOnly="True" Enabled="False" 
            Width="239px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <p>Número:
        <asp:TextBox ID="txtNumero" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" 
            ControlToValidate="txtNumero" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>Complemento:
        <asp:TextBox ID="txtComplemento" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;</p>
    <p>Bairro:
        <asp:TextBox ID="txtBairro" runat="server" ReadOnly="True" Enabled="False" 
            Width="195px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <p>Cidade:
        <asp:TextBox ID="txtCidade" runat="server" ReadOnly="True" Enabled="False" 
            Width="250px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <p>Estado (UF):
        <asp:TextBox ID="txtEstado" runat="server" ReadOnly="True" Enabled="False" 
            Width="46px" CssClass="caixa-de-texto"></asp:TextBox>
        &nbsp;
    </p>
    <p>
         <asp:SqlDataSource ID="sqlNovosDados" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM cliente" 
             
             
             UpdateCommand="UPDATE cliente SET nome_cli = @nome, email_cli = @email, CPF_cli = @cpf, RG_cli = @rg, sexo_cli = @sexo, dtNasc_cli = @data, tel_cli = @tel1, outroTel_cli = @tel2, estciv_cli = @estciv, CEP_cli = @cep, num_cli = @num, compl_cli = @comp WHERE (id_cli = @cod)">
             <UpdateParameters>
                 <asp:Parameter Name="nome" />
                 <asp:Parameter Name="email" />
                 <asp:Parameter Name="cpf" />
                 <asp:Parameter Name="rg" />
                 <asp:ControlParameter ControlID="ddlSexo" Name="sexo" 
                     PropertyName="SelectedValue" />
                 <asp:Parameter Name="data" />
                 <asp:Parameter Name="tel1" />
                 <asp:Parameter Name="tel2" />
                 <asp:ControlParameter ControlID="ddlEstCiv" Name="estciv" 
                     PropertyName="SelectedValue" />
                 <asp:Parameter Name="cep" />
                 <asp:ControlParameter ControlID="txtNumero" Name="num" PropertyName="Text" />
                 <asp:Parameter Name="comp" />
                 <asp:SessionParameter Name="cod" SessionField="codCliente" />
             </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlRegistro" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO registrosadm(id_adm, data_registro, registro, login_adm, nome_prod, desc_ml, tipo_promo, tipo_linha, tipo_genero, login_cliente, login_func) VALUES (@cod, @data, @registro, @adm, @prod, @ml, @promo, @linha, @genero, @cliente, @func)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM registrosadm">
            <InsertParameters>
                <asp:Parameter Name="data" />
                <asp:SessionParameter Name="cod" SessionField="idADM" />
                <asp:Parameter Name="registro" />
                <asp:Parameter Name="adm" />
                <asp:Parameter Name="prod" />
                <asp:Parameter Name="ml" />
                <asp:Parameter Name="linha" />
                <asp:Parameter Name="genero" />
                <asp:Parameter Name="promo" />
                <asp:Parameter Name="cliente" />
                <asp:Parameter Name="func" />
            </InsertParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style1">
        (*) Campos Obrigatórios!</p>
    <p>
        <asp:Button ID="btnEditar" runat="server" onclick="btnEditar_Click" 
            Text="Editar" CssClass="btnApp" />
    </p>
</asp:Content>

