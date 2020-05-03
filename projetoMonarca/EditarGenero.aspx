<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="EditarGenero.aspx.cs" Inherits="EditarGenero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">



* {
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
}

        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <h1 class="posicionamento">Editar Gênero</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <h1>
        Feminino<asp:SqlDataSource ID="sqlPromocao" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM promocao"></asp:SqlDataSource>
    </h1>
    <div id="FemExibir" runat="server">
        <p>
            <strong>Promoção:</strong>
        <asp:Label ID="lblFemPromo" runat="server"></asp:Label>
&nbsp;<strong>Desconto:</strong>
        <asp:Label ID="lblFemDesc" runat="server"></asp:Label>
    &nbsp;
        <asp:Button ID="btnEditarFem" runat="server" Text="Editar" CssClass="btnApp" 
            Height="25px" onclick="btnAlterarFem_Click" Width="80px" />
    </p>

    </div>

    <div id="FemPromo" runat="server">
    <p>
        <strong>Promoção:</strong>
        <asp:DropDownList ID="ddlFeminino" runat="server" CssClass="ddls" 
            AutoPostBack="True" onselectedindexchanged="ddlFeminino_SelectedIndexChanged">
        </asp:DropDownList>
&nbsp;<strong>Desconto: </strong>
        <asp:Label ID="lblPromo1" runat="server"></asp:Label>
&nbsp;
        <asp:Button ID="btnConcluirFem" runat="server" Text="Alterar" CssClass="btnApp" 
            Height="25px" onclick="btnConcluirFem_Click" Width="80px" />
        <asp:SqlDataSource ID="sqlPromoEscolhidaFem" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (id_promo = @promo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlFeminino" Name="promo" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlFemPromoCadastrada" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            SelectCommand="SELECT genero.id_genero, genero.id_promo, genero.tipo_genero, promocao.desconto, promocao.titulo_promo FROM genero INNER JOIN promocao ON genero.id_promo = promocao.id_promo WHERE (genero.id_genero = 1)" 
            UpdateCommand="UPDATE genero SET id_promo = @promo WHERE (id_genero = 1)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlFeminino" Name="promo" 
                    PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
        </p>
    </div>


    <h1>
        Masculino</h1>
    <div id="MascExibir" runat="server">
        <p>
            <strong>Promoção:</strong>
        <asp:Label ID="lblMascPromo" runat="server"></asp:Label>
&nbsp;<strong>Desconto:</strong>
        <asp:Label ID="lblMascDesc" runat="server"></asp:Label>
    &nbsp;
        <asp:Button ID="btnAlterarMasc" runat="server" Text="Editar" 
            CssClass="btnApp" Height="25px" onclick="btnAlterarMasc_Click" 
            Width="80px" />
    </p>
        </div>
   <div id="MascPromo" runat="server">
    <p>
        <strong>Promoção:</strong> <asp:DropDownList ID="ddlMasculino" runat="server" 
            CssClass="ddls" AutoPostBack="True" 
            onselectedindexchanged="ddlMasculino_SelectedIndexChanged">
        </asp:DropDownList>
    &nbsp; <strong>Desconto:</strong>&nbsp;
        <asp:Label ID="lblPromo2" runat="server"></asp:Label>
&nbsp;
        <asp:Button ID="btnConcluirMasc" runat="server" Text="Alterar" 
            CssClass="btnApp" Height="25px" onclick="btnConcluirMasc_Click" 
            Width="80px" />
        <asp:SqlDataSource ID="sqlPromoEscolhidaMasc" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (id_promo = @promo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlMasculino" Name="promo" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlMascPromoCadastrada" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            SelectCommand="SELECT genero.id_genero, genero.id_promo, genero.tipo_genero, promocao.titulo_promo, promocao.desconto FROM genero INNER JOIN promocao ON genero.id_promo = promocao.id_promo WHERE (genero.id_genero = 2)" 
            UpdateCommand="UPDATE genero SET id_promo = @promo WHERE (id_genero = 2)">
            <UpdateParameters>
                <asp:ControlParameter ControlID="ddlMasculino" Name="promo" 
                    PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
       </p>
       <p>
             <asp:SqlDataSource ID="sqlAlterarPrecoProd" runat="server" 
                 ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                 ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                 SelectCommand="SELECT * FROM [produto]" 
                 
                 UpdateCommand="UPDATE produto SET valor_prod_final = @preco WHERE (id_prod = @cod)">
                 <UpdateParameters>
                     <asp:SessionParameter Name="cod" SessionField="codProdEditar" />
                     <asp:Parameter Name="preco" />
                 </UpdateParameters>
             </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.adicional, promocao.desconto, promocao.titulo_promo FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN promocao ON produto.id_promo = promocao.id_promo WHERE (produto.id_genero = @codGenero)">
        <SelectParameters>
            <asp:SessionParameter Name="codGenero" SessionField="codGenero" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDaLinha" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        SelectCommand="SELECT linha.id_promo, linha.tipo_linha, promocao.desconto, promocao.titulo_promo FROM linha INNER JOIN promocao ON linha.id_promo = promocao.id_promo WHERE (linha.id_linha = @cod)">
        <SelectParameters>
            <asp:SessionParameter Name="cod" SessionField="codLinhaRelacionada" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoGenero" runat="server" ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" SelectCommand="SELECT genero.id_genero, genero.id_promo, genero.tipo_genero, promocao.titulo_promo, promocao.desconto FROM genero INNER JOIN promocao ON genero.id_promo = promocao.id_promo WHERE (genero.id_genero = @cod)">
        <SelectParameters>
            <asp:SessionParameter Name="cod" SessionField="codGeneroRelacionado" />
        </SelectParameters>
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
    </asp:Content>

