<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageFunc.master" AutoEventWireup="true" CodeFile="CadastroPerfumeFunc.aspx.cs" Inherits="CadastroPerfumeFunc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        #TextArea1
        {
            height: 66px;
            width: 190px;
        }
        .auto-style1 {
            background-color: transparent;
            border-bottom: 1px solid #333;
            color: #212121;
            font-family: "PT Sans", sans-serif;
            font-size: 13px;
            font-size: 1.3rem;
            outline: 0;
            padding-left: 10px;
            font-weight: bold;
            border-left-style: none;
            border-left-color: inherit;
            border-left-width: medium;
            border-right-style: none;
            border-right-color: inherit;
            border-right-width: medium;
            border-top-style: none;
            border-top-color: inherit;
            border-top-width: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1 class="posicionamento">Cadastro de Perfume</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />

    <p>
        Nome do Produto: 
        <asp:TextBox ID="txtNome" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
         ControlToValidate="txtNome" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:Label ID="lblExistente" runat="server" style="color: #FF0000"></asp:Label>
        <asp:SqlDataSource ID="sqlVereficarExistente" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT nome_prod FROM produto WHERE (nome_prod = @nome)">
            <SelectParameters>
                <asp:Parameter Name="nome" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlPrimeiraSelecaoLinha" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT linha.id_promo, linha.tipo_linha, promocao.desconto, promocao.titulo_promo, linha.id_linha FROM linha INNER JOIN promocao ON linha.id_promo = promocao.id_promo WHERE (linha.id_linha = 1)">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlPrimeiraSelecaoGenero" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT genero.id_genero, genero.id_promo, genero.tipo_genero, promocao.desconto, promocao.titulo_promo FROM genero INNER JOIN promocao ON genero.id_promo = promocao.id_promo WHERE (genero.id_genero = 1)">
        </asp:SqlDataSource>
    </p>
    <p>
        <strong>Só aceita uma ÚNICA Promoção!!</strong></p>
    <p>
        <strong>Opção 1.</strong> Promoção do Produto:
        <asp:DropDownList ID="ddlPromocao" runat="server" 
            onselectedindexchanged="ddlPromo_SelectedIndexChanged" CssClass="ddls" 
            AutoPostBack="True">
        </asp:DropDownList>
&nbsp;
        <asp:SqlDataSource ID="sqlExibirPromo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM promocao"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlPromoEscolhida" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (id_promo = @promo)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlPromocao" Name="promo" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <strong>Opção 2.</strong> Linha: 
        <asp:DropDownList ID="ddlLinha" runat="server" 
            onselectedindexchanged="ddlLinha_SelectedIndexChanged" CssClass="ddls" 
            AutoPostBack="True">
        </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
         ControlToValidate="ddlLinha" ErrorMessage="*"></asp:RequiredFieldValidator>
&nbsp;<asp:SqlDataSource ID="sqlLinha" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT * FROM linha"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlLinhaEscolhida" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            SelectCommand="SELECT linha.id_linha, linha.id_promo, linha.tipo_linha, promocao.titulo_promo, promocao.desconto FROM linha INNER JOIN promocao ON linha.id_promo = promocao.id_promo WHERE (linha.id_linha = @linha)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlLinha" Name="linha" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblPromoLinha" runat="server" style="font-weight: 700"></asp:Label>
    </p>
    <p>
        <strong>Opção 3.</strong> Gênero:
        <asp:DropDownList ID="ddlGenero" runat="server" 
            onselectedindexchanged="ddlGenero_SelectedIndexChanged" CssClass="ddls" 
            AutoPostBack="True">
        </asp:DropDownList>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="ddlGenero" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:SqlDataSource ID="sqlGenero" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM genero"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlGeneroEscolhido" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            SelectCommand="SELECT genero.id_genero, genero.id_promo, genero.tipo_genero, promocao.titulo_promo, promocao.desconto FROM genero INNER JOIN promocao ON genero.id_promo = promocao.id_promo WHERE (genero.id_genero = @genero)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlGenero" Name="genero" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblPromoGenero" runat="server" style="font-weight: 700"></asp:Label>
    </p>
    <p>
        Desconto da Promoção (%):
        <asp:TextBox ID="txtDesconto" runat="server" Enabled="False" ReadOnly="True" CssClass="auto-style1" Width="100px"></asp:TextBox>
    </p>
    <p>Preço Unitário (R$):
        <asp:TextBox ID="txtPreco" runat="server" CssClass="caixa-de-texto" Width="150px"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
            ControlToValidate="txtPreco" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:Label ID="lblErro" runat="server" style="color: #FF0000"></asp:Label>
    </p>
    <p>Conteúdo (ML):
                
        
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
            ControlToValidate="rdbML" ErrorMessage="*"></asp:RequiredFieldValidator>
        &nbsp;<asp:RadioButtonList ID="rdbML" runat="server" AutoPostBack="True" 
            onselectedindexchanged="RadioButtonList1_SelectedIndexChanged" 
            margin-right="10px">
        </asp:RadioButtonList>
        <asp:SqlDataSource ID="sqlML" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM ml"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlMLEscolhido" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_ml, desc_ml, adicional FROM ml WHERE (id_ml = @cod)">
            <SelectParameters>
                <asp:ControlParameter ControlID="rdbML" Name="cod" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>Preço do Acréscimo (R$):
        <asp:TextBox ID="txtAcresc" runat="server" Enabled="False" ReadOnly="True" CssClass="caixa-de-texto" Width="120px"></asp:TextBox>
    &nbsp;
        <asp:Label ID="lblAcres" runat="server"></asp:Label>
    </p>
    <p>Preço Final (R$): 
        <asp:TextBox ID="txtPrecoFinal" runat="server" Enabled="False" ReadOnly="True" CssClass="caixa-de-texto" Width="170px"></asp:TextBox>
    &nbsp;</p>
    <p>Quantidade de Estoque:
        <asp:TextBox ID="txtEstoque" runat="server" CssClass="caixa-de-texto" Width="120px" ></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
            ControlToValidate="txtEstoque" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <!--<p>Promoção (FAZER AINDA!!!):
        <asp:DropDownList ID="ddlPromo" runat="server">
        </asp:DropDownList>
&nbsp;<asp:SqlDataSource ID="sqlPromo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM ml"></asp:SqlDataSource>
    </p> !-->
    <p>
        &nbsp;<label class="file-upload"><strong>Foto</strong>
        <asp:FileUpload ID="fileFoto" runat="server" />
        </label>
    </p>
    <p>
        Descrição: 
        <asp:TextBox ID="txtDesc" runat="server" Height="118px" TextMode="MultiLine" 
         Width="310px" CssClass="caixa-de-texto-grande"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
         ControlToValidate="txtDesc" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>
        &nbsp;Slogan:
        <asp:TextBox ID="txtSlogan" runat="server" Width="210px" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
            ControlToValidate="txtSlogan" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Button ID="btnCadastrar" runat="server" onclick="btnCadastrar_Click" 
            Text="Cadastrar" CssClass="btnApp" />
    </p>
    <p>
        <asp:Label ID="lblObr" runat="server" style="color: #FF0000" 
            Text="(*) Campos Obrigatórios!"></asp:Label>
    </p>
    <p>
        <asp:SqlDataSource ID="sqlPerfume" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO produto(id_genero, id_linha, id_ml, nome_prod, desc_prod, slogan_prod, valorUnid_prod, img_prod, qtd_disponivel, valor_prod_final, valor_acrescimo, id_promo, id_android, status) VALUES (@genero, @linha, @ml, @nome, @desc , @slogan, @precoUnid, @foto, @qtd, @precoFinal, @precoAcres, @promo, 1, '0')" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM produto">
            <InsertParameters>
                <asp:ControlParameter ControlID="ddlLinha" Name="linha" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlGenero" Name="genero" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="rdbML" Name="ml" 
                    PropertyName="SelectedValue" />
                <asp:Parameter Name="foto" />
                <asp:Parameter Name="precoFinal" />
                <asp:Parameter Name="precoAcres" />
                <asp:ControlParameter ControlID="ddlPromocao" Name="promo" PropertyName="SelectedValue" />
                <asp:Parameter Name="precoUnid" />
                <asp:Parameter Name="nome"></asp:Parameter>
                <asp:Parameter Name="desc"></asp:Parameter>
                <asp:Parameter Name="slogan"></asp:Parameter>
                <asp:Parameter Name="qtd" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlRegistro" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO registrosfunc(id_func, registro, data_registro, nome_prod) VALUES (@func, @registro, @data, @prod)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [registrosfunc]">
            <InsertParameters>
                <asp:Parameter Name="data" />
                <asp:SessionParameter Name="func" SessionField="idFunc" />
                <asp:Parameter Name="prod" />
                <asp:Parameter Name="registro" />
            </InsertParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

