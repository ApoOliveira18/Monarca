<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="CadastroML.aspx.cs" Inherits="CadastroML" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Cadastro da Quantidade de MLs</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <p>
        Conteúdo (ML) :
        <asp:TextBox ID="txtML" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtML" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:Label ID="lblExistente" runat="server" style="color: #FF0000"></asp:Label>
        <asp:SqlDataSource ID="sqlVerificarExistente" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            SelectCommand="SELECT desc_ml FROM ml WHERE (desc_ml LIKE @ML)">
            <SelectParameters>
                <asp:Parameter Name="ML" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        Acréscimo (%):
        <asp:TextBox ID="txtAcres" runat="server" CssClass="caixa-de-texto" 
            Width="133px"></asp:TextBox>
    &nbsp;(Se desejar)</p>
    <p>
        <asp:Button ID="btnCadastrar" runat="server" onclick="btnCadastrar_Click" 
            Text="Cadastrar" CssClass="btnApp" />
        <asp:SqlDataSource ID="sqlCadastrarML" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO ml(desc_ml, adicional) VALUES (@ml, @adicional)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM ml">
            <InsertParameters>
                <asp:Parameter Name="ML" />
                <asp:Parameter Name="adicional" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCadastrarMLSemAdd" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO ml(desc_ml, adicional) VALUES (@ML, @adicional)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [ml]">
            <InsertParameters>
                <asp:Parameter Name="ML" />
                <asp:Parameter Name="adicional" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblCadastro" runat="server"></asp:Label>
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
    <p>
        <asp:Label ID="lblObr" runat="server" style="color: #FF0000" 
            Text="(*) Campos Obrigatórios!"></asp:Label>
        </p>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
</div>
    </div>
</asp:Content>

