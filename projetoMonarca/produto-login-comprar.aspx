<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="produto-login-comprar.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="centralizar-menor">
<div class="login_Comprar">
        <span class="style2">Se tiver uma conta, preencha os campos.<br />
        Caso não possua cadastro, clique em <em><strong>Cadastre-se</strong></em><br />
        </span>
        &nbsp;</br>
      <div class="caixas">
      <asp:TextBox ID="txtLogin" CssClass=style1 runat="server" placeholder="Usuário" 
              Height="35px" Width="233px" ></asp:TextBox>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
              ControlToValidate="txtLogin" ErrorMessage="*"></asp:RequiredFieldValidator>
          <%-- <asp:Label ID="Label1" runat="server" Text="*"  style="color: #FF0000"></asp:Label>--%>
          <br />
      <br />
      <asp:TextBox ID="txtSenha" CssClass=style1 runat="server" placeholder="Senha" 
              TextMode="Password" Height="35px" Width="230px"></asp:TextBox><asp:RequiredFieldValidator
                  ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" 
              ControlToValidate="txtSenha"></asp:RequiredFieldValidator>
          <%--<asp:Label ID="Label2" runat="server" Text="*" style="color: #FF0000"></asp:Label>--%>
          <br/>
          <br />
          <div class = "Resposta"><a href="login-comprar.aspx"> 
          <asp:Label ID="lblErro" runat="server" style="color: #FF0000"></asp:Label>
          </a>
          
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

        <div id="info-container">
            <asp:CheckBox ID="chkManterLogado" runat="server" Text="Manter conectado" 
                CssClass="style1" />
            &nbsp;
            &nbsp;<asp:LinkButton ID="lbEsqueceuSuaSenha" runat="server" 
                OnClick="lbEsqueceuSuaSenha_Click" CausesValidation="False" 
                Font-Underline="False" CssClass="style1">Esqueceu Sua Senha?</asp:LinkButton>
                      
        </div>


       
        <div id="info-container0">
            <div id="captcha" runat= "server">
                <asp:TextBox ID="txtimgcode" runat="server" ValidationGroup="2" 
                    CssClass="caixa-de-texto"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                      ControlToValidate="txtimgcode" ErrorMessage="*" ValidationGroup="2"></asp:RequiredFieldValidator>
                    <asp:Button ID="btnRecuperar" runat="server" CssClass="btnApp" 
                      OnClick="btnRecuperar_Click" Text="Recuperar Senha" ValidationGroup="2" 
                       Visible="False" />
                 
                    <br />
                <br />
                <asp:Image ID="Image1" runat="server" ImageUrl="~/CImage.aspx"/>
                    <asp:Label ID="lblmsg" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
             </div>

            <asp:Button ID="btnEditarApos3Erros" runat="server" Text="Entrar" CssClass="btnApp" 
            onclick="btnEditarApos3Erros_Click" ValidationGroup="2" Visible="False" />
            <asp:Button ID="btnEditar" runat="server" Text="Entrar" CssClass="btnApp" 
            onclick="btnEditar_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnCadastro" runat="server" Text="Cadastre-se" CssClass="btnApp" 
                onclick="btnCadastro_Click" CausesValidation="False" ValidationGroup="1" />
               
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
        </div>

          <%--<asp:Button ID="btnCadastro" runat="server" CssClass="botao_cadastre" 
            onclick="btnCadastro_Click" Text="Cadastre-se"/>--%>
    </div>


    </div>
</asp:Content>

