<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="EditarADM.aspx.cs" Inherits="EditarADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Editar Administrador</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <p>
        <strong>DADOS ANTERIORES:</strong><asp:GridView ID="gvExibir" runat="server" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="4" DataKeyNames="id_adm" 
            ForeColor="Black" GridLines="Horizontal">
            <Columns>
                <asp:BoundField DataField="id_adm" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_adm" />
                <asp:BoundField DataField="login_adm" HeaderText="Login" 
                    SortExpression="login_adm" />
                <asp:BoundField DataField="email_adm" HeaderText="Email" 
                    SortExpression="email_adm" />
                <asp:BoundField DataField="data_conta" HeaderText="Data da Conta" 
                    SortExpression="data_conta"></asp:BoundField>
            </Columns>
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        <asp:SqlDataSource ID="sqlADMCadastrado" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString2 %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString2.ProviderName %>" 
            
            SelectCommand="SELECT id_adm, login_adm, senha_adm, email_adm, data_conta FROM adm WHERE (id_adm = @codadm)">
            <SelectParameters>
                <asp:SessionParameter Name="codadm" SessionField="codADM" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <strong>ALTERE OS DADOS ABAIXO:</strong></p>
 <p>Usuário: 
     <asp:TextBox ID="txtUsuario" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
         ControlToValidate="txtUsuario" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>Email:
        <asp:TextBox ID="txtEmail" runat="server" CssClass="caixa-de-texto " Width="300px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
            ControlToValidate="txtEmail" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>Senha:
        <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" 
            CssClass="caixa-de-texto"></asp:TextBox>
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
            CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ControlToValidate="txtConfSenha" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" 
         ControlToCompare="txtSenha" ControlToValidate="txtConfSenha" 
         ErrorMessage="SENHAS NÃO COINCIDEM, TENTE NOVAMENTE."></asp:CompareValidator>
    </p>
 
    <p>
        <asp:Button ID="btnEditar" runat="server" onclick="btnEditar_Click" 
            Text="Editar" CssClass="btnApp" />
    </p>
    <p>
        <asp:SqlDataSource ID="sqlNovosDados" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO adm(login_adm, senha_adm, email_adm) VALUES (@usuario, @senha, @email)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [adm]" 
            UpdateCommand="UPDATE adm SET login_adm = @usuario, senha_adm = @senha, email_adm = @email, data_conta = @datacad WHERE (id_adm = @cod)">
            <InsertParameters>
                <asp:ControlParameter ControlID="txtUsuario" Name="usuario" 
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="txtSenha" Name="senha" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtEmail" Name="email" PropertyName="Text" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="senha" />
                <asp:Parameter Name="email" />
                <asp:Parameter Name="usuario" />
                <asp:SessionParameter Name="cod" SessionField="codADM" />
                <asp:Parameter Name="datacad" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlBuscarDadosAntigos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_adm, login_adm, senha_adm, email_adm FROM adm WHERE (id_adm = @codantigo)">
            <SelectParameters>
                <asp:SessionParameter Name="codantigo" SessionField="codADM" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlExcluirDadosAntigos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            DeleteCommand="DELETE FROM adm WHERE (id_adm = @codantigo)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [adm]">
            <DeleteParameters>
                <asp:SessionParameter Name="codantigo" SessionField="codADM" />
            </DeleteParameters>
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
</asp:Content>

