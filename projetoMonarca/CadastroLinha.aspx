<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="CadastroLinha.aspx.cs" Inherits="CadastroLinha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Cadastro de Linhas de Perfumes</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <p> Nome da Linha: 
        <asp:TextBox ID="txtLinha" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtLinha" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:Label ID="lblExistente" runat="server" style="color: #FF0000"></asp:Label>
        <asp:SqlDataSource ID="sqlVerificarExistente" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_linha, id_promo, tipo_linha FROM linha WHERE (tipo_linha = @nome)">
            <SelectParameters>
                <asp:Parameter Name="nome" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
   <div id="dadosPromocao" runat="server">

    <p> Promoção:
        <asp:DropDownList ID="ddlPromo" runat="server" AutoPostBack="True" 
            onselectedindexchanged="ddlPromo_SelectedIndexChanged" CssClass="ddls">
        </asp:DropDownList>
        &nbsp;(Opcional)
        <asp:SqlDataSource ID="sqlExibirPromo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM promocao"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlPromoEscolhida" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (id_promo = @promo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlPromo" Name="promo" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlPromoSession" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (id_promo = @promo)">
            <SelectParameters>
                <asp:SessionParameter Name="promo" SessionField="idPromo" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    </div>
    <p> 
        <asp:Label ID="lblPromo" runat="server"></asp:Label>
        <asp:SqlDataSource ID="sqlExibirCadastro" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (id_promo = @promo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlPromo" Name="promo" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <div id="descontoPromo" runat= "server">
    <p> Desconto da Promoção (%): 
        <asp:TextBox ID="txtDesconto" runat="server" Enabled="False" ReadOnly="True" CssClass="caixa-de-texto"></asp:TextBox>
    </p>
    </div>
    <p> 
        <asp:Button ID="btnCadastrar" runat="server" onclick="btnCadastrar_Click" 
            Text="Cadastrar" CssClass="btnApp" />
        <asp:Label ID="lblResp" runat="server" style="font-weight: 700"></asp:Label>
    </p>
    <p> 
        <asp:Label ID="lblObr" runat="server" style="color: #FF0000" 
            Text="(*) Campos Obrigatórios!"></asp:Label>
    </p>
    <p> 
        <asp:SqlDataSource ID="sqlCadastroLinha" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO linha(tipo_linha, id_promo, status) VALUES (@linha, @promo, '0')" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM linha">
            <InsertParameters>
                <asp:Parameter Name="linha" />
                <asp:ControlParameter ControlID="ddlPromo" Name="promo" 
                    PropertyName="SelectedValue" />
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
        <asp:SqlDataSource ID="sqlCriarSessionParaLinhaCadastrada" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_linha, id_promo, tipo_linha FROM linha WHERE (tipo_linha = @linha)">
            <SelectParameters>
                <asp:Parameter Name="linha" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="btnProduto" runat="server" OnClick="btnProduto_Click" 
            Text="+ Produto na Nova Linha" Visible="False" CssClass="btnApp" Width="200px" />
    </p>
       <br />
       <br />
       <br />
       <br />
       <br />
       <br />
       <br />
       <br /> 
</asp:Content>

