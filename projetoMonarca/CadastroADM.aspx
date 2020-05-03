<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="CadastroADM.aspx.cs" Inherits="css_CadastroADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<h1 class="posicionamento">Cadastro de Administradores</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
 <p>Usuário: 
     <asp:TextBox ID="txtUsuario" runat="server" CssClass="caixa-de-texto "></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
         ControlToValidate="txtUsuario" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:Label ID="lblExistente" runat="server" style="color: #FF0000"></asp:Label>
        <asp:SqlDataSource ID="sqlVerificarExistenciaUsuario" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT id_adm, login_adm, senha_adm, email_adm, data_conta FROM adm WHERE (login_adm = @USUARIO)">
            <SelectParameters>
                <asp:Parameter Name="USUARIO" />
            </SelectParameters>
     </asp:SqlDataSource>
    </p>
    <p>
        Email: 
        <asp:TextBox ID="txtEmail" runat="server" CssClass="caixa-de-texto "></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
            ControlToValidate="txtEmail" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:Label ID="lblExistente2" runat="server" style="color: #FF0000"></asp:Label>
        <asp:SqlDataSource ID="sqlVerificarExistenciaEmail" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_adm, login_adm, senha_adm, email_adm, data_conta FROM adm WHERE (email_adm = @EMAIL)">
            <SelectParameters>
                <asp:Parameter Name="EMAIL" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>Senha:
        <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" 
            CssClass="caixa-de-texto "></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtSenha" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;</p>
    <p>
        <asp:Label ID="lblExigenciasSenha" runat="server" Font-Size="Smaller"></asp:Label>
        <asp:Label ID="lblSenhaCurta" runat="server" 
            style="color: #FF0000"></asp:Label>
    </p>
     <div id="senha" runat= "server">
        &nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblMedidor" runat="server" style="color: #666666" 
            Text="Força da Senha:"></asp:Label>
        &nbsp;<asp:Image ID="imgForcaSenha" runat="server" Height="25px" Visible="False" 
            Width="230px" />
        &nbsp;<br />
        </div>
    <p>Confirmação da Senha:
        <asp:TextBox ID="txtConfSenha" runat="server" TextMode="Password" 
            CssClass="caixa-de-texto "></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ControlToValidate="txtConfSenha" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" 
         ControlToCompare="txtSenha" ControlToValidate="txtConfSenha" 
         ErrorMessage="SENHAS NÃO COINCIDEM, TENTE NOVAMENTE."></asp:CompareValidator>
    </p>
    <p>Pergunta Secreta:
        <asp:TextBox ID="txtPergSecreta" runat="server" CssClass="caixa-de-texto" 
            Width="300px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
            ControlToValidate="txtPergSecreta" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>Resposta Secreta:
        <asp:TextBox ID="txtRespSecreta" runat="server" CssClass="caixa-de-texto" 
            Width="200px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
            ControlToValidate="txtRespSecreta" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
 
    <p>
        <asp:Button ID="btnCadastrar" runat="server" onclick="btnCadastrar_Click1" 
            Text="Cadastrar" CssClass="btnApp" />
    </p>
    <p>
        <asp:Label ID="lblObr" runat="server" style="color: #FF0000" 
            Text="(*) Campos Obrigatórios!"></asp:Label>
    </p>
<p>
        <asp:SqlDataSource ID="sqlCadastrarADM" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_adm, login_adm, senha_adm, email_adm, data_conta FROM adm" 
            
            InsertCommand="INSERT INTO adm(login_adm, email_adm, senha_adm, data_conta, perg_adm, resp_adm, status) VALUES ( @user , @email, @senha, @dataCad, @perg, @resp, '0')">
            <InsertParameters>
                <asp:Parameter Name="user" />
                <asp:Parameter Name="email" />
                <asp:Parameter Name="senha" />
                <asp:Parameter Name="dataCad" />
                <asp:Parameter Name="perg" />
                <asp:Parameter Name="resp" />
            </InsertParameters>
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
</div>
    </div>
</asp:Content>

