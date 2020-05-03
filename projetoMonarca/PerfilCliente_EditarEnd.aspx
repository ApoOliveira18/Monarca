<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_EditarEnd.aspx.cs" Inherits="PerfilCliente_EditarEnd" %>

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
    
    <div id="topo-2">
</div>
<div id="tudo">
<br />
    <br />
    <h1>Editar Endereço</h1>
	<div id="container">
        <div id="info-container">
        <asp:SqlDataSource ID="sqlBusca" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT id_end, CEP_cli, num_cli, compl_cli, nome_end FROM endereco WHERE (id_end = @cod)">
            <SelectParameters>
                <asp:QueryStringParameter Name="cod" QueryStringField="id" />
            </SelectParameters>
            </asp:SqlDataSource>
        	<div class="nome">
        	    Nome
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtNome" runat="server"
                    CssClass="caixa-de-texto" Width="206px"></asp:TextBox>
            </div>
        </div>
        
        <div id="info-container">
        	<div class="nome">
        	    CEP
        	</div>
            <div class="resultado_senha">

                <asp:TextBox ID="txtCEP" runat="server"  CssClass="caixa-de-texto">
                </asp:TextBox>       &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtCEP" ErrorMessage="*" CssClass="style14"></asp:RequiredFieldValidator>            &nbsp;
                <asp:Button ID="btnOK" runat="server" onclick="btnOK_Click" Text="Pesquisar" CssClass="ddls" Height="36px" CausesValidation="False" />       &nbsp;
                
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
                    CssClass="caixa-de-texto" Width="206px" Enabled="False"></asp:TextBox>
            </div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Número
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtNumero" runat="server"
                    CssClass="caixa-de-texto" Width="47px" Enabled="True"></asp:TextBox>
                &nbsp;
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtNumero" ErrorMessage="*" CssClass="style14"></asp:RequiredFieldValidator>
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
                    CssClass="caixa-de-texto" Width="148px" Enabled="False"></asp:TextBox>
            </div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Cidade
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtCidade" runat="server"  
                    CssClass="caixa-de-texto" Width="183px" Enabled="False"></asp:TextBox>
            </div>
        </div>

        <div id="info-container">
        	<div class="nome">
        	    Estado
        	</div>
            <div class="resultado_senha">
                <asp:TextBox ID="txtEstado" runat="server" 
                    CssClass="caixa-de-texto" Width="36px" Enabled="False"></asp:TextBox>

            </div>
        </div>
        <br
        <div id="info-container">
            <asp:SqlDataSource ID="sqlAtualizarEndAdicional" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [endereco]" 
            
            UpdateCommand="UPDATE endereco SET CEP_cli = @cep, num_cli = @numero, compl_cli = @complemento, nome_end = @nome, cidade_end = @cidade, rua_end = @rua, estado_end = @estado WHERE (id_end = @cod)">
                <UpdateParameters>
                    <asp:Parameter Name="nome" />
                    <asp:Parameter Name="cep" />
                    <asp:ControlParameter ControlID="txtNumero" Name="numero" PropertyName="Text" />
                    <asp:Parameter Name="complemento" />
                    <asp:QueryStringParameter Name="cod" QueryStringField="id" />
                    <asp:Parameter Name="rua" />
                    <asp:Parameter Name="cidade" />
                    <asp:Parameter Name="estado" />
                </UpdateParameters>
            </asp:SqlDataSource>
        <asp:Button ID="btnSalvar" runat="server" Text="Salvar" CssClass="btnApp" 
             Width="116px" OnClick="btnSalvar_Click" />
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

