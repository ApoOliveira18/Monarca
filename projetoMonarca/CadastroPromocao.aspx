<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="CadastroPromocao.aspx.cs" Inherits="CadastroPromocao" %>

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
<h1 class="posicionamento">Cadastro de Promoções</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
 <p>Título da Promoção: 
     <asp:TextBox ID="txtTitulo" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
         ControlToValidate="txtTitulo" ErrorMessage="*"></asp:RequiredFieldValidator>
    &nbsp;<asp:Label ID="lblExistente" runat="server" style="color: #FF0000"></asp:Label>
     <asp:SqlDataSource ID="sqlVerificarExistente" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT titulo_promo FROM promocao WHERE (titulo_promo = @promo)">
         <SelectParameters>
             <asp:Parameter Name="promo" />
         </SelectParameters>
     </asp:SqlDataSource>
    </p>
 <p>Desconto (%): 
     <asp:TextBox ID="txtDesconto" runat="server" CssClass="caixa-de-texto" ></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
         ControlToValidate="txtDesconto" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:Label ID="lblObr" runat="server" style="color: #FF0000" 
            Text="(*) Campos Obrigatórios!"></asp:Label>
    </p>
    <p>
        <asp:Button ID="btnCadastrar" runat="server" onclick="btnCadastrar_Click" 
            Text="Cadastrar" CssClass="btnApp" />
        <asp:SqlDataSource ID="sqlInserirPromo" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM promocao" 
            
            InsertCommand="INSERT INTO promocao(titulo_promo, desconto) VALUES (@titulo, @desc )">
            <InsertParameters>
                <asp:Parameter Name="titulo" />
                <asp:Parameter Name="desc" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlCriarSessionPromoCadastrada" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            SelectCommand="SELECT id_promo, titulo_promo, desconto FROM promocao WHERE (titulo_promo = @promo)">
            <SelectParameters>
                <asp:Parameter Name="promo" />
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
        <asp:Label ID="lblResp" runat="server" style="font-weight: 700"></asp:Label>
    </p>




    <div id="dadosPromocao" runat="server">

    <h1> ESCOLHER REFERÊNCIA DA PROMOÇÃO</h1>
 <p><strong>Por Linha :</strong>&nbsp;<asp:Button ID="btnLinha" runat="server" 
         onclick="btnLinha_Click" Text="+ Linha" CssClass="btnApp" Height="30px" 
         Width="100px" />
     &nbsp;&nbsp;
     &nbsp;<asp:RadioButtonList ID="rbLinha" runat="server">
     </asp:RadioButtonList>
     <asp:SqlDataSource ID="sqlLinha" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT * FROM linha"></asp:SqlDataSource>
     <asp:SqlDataSource ID="sqlLinhaEscolhida" runat="server" 
         ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
         ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
         SelectCommand="SELECT * FROM linha" 
         UpdateCommand="UPDATE linha SET id_promo = @promo WHERE (id_linha = @linha)">
         <UpdateParameters>
             <asp:SessionParameter Name="promo" SessionField="idPromo" />
             <asp:ControlParameter ControlID="rbLinha" Name="linha" 
                 PropertyName="SelectedValue" />
         </UpdateParameters>
     </asp:SqlDataSource>
    </p>
    <p><strong>Por Gênero:</strong>
        <asp:RadioButtonList ID="rbGenero" runat="server">
        </asp:RadioButtonList>
        <asp:SqlDataSource ID="sqlGenero" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM genero"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlGeneroEscolhido" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM genero" 
            UpdateCommand="UPDATE genero SET id_promo = @promo WHERE (id_genero = @genero)">
            <UpdateParameters>
                <asp:SessionParameter Name="promo" SessionField="idPromo" />
                <asp:ControlParameter ControlID="rbGenero" Name="genero" 
                    PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p><strong>Por Produto: 
        </strong> 
        <asp:Button ID="btnProduto" runat="server" onclick="btnProduto_Click" 
            Text="+ Produto" CssClass="btnApp" Height="30px" Width="100px" />
        <asp:RadioButtonList ID="rbProduto" runat="server">
        </asp:RadioButtonList>
        <asp:SqlDataSource ID="sqlProduto" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM produto"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sqlProdutoEscolhido" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [produto]" 
            UpdateCommand="UPDATE produto SET id_promo = @promo WHERE (id_prod = @produto)">
            <UpdateParameters>
                <asp:SessionParameter Name="promo" SessionField="idPromo" />
                <asp:ControlParameter ControlID="rbProduto" Name="produto" 
                    PropertyName="SelectedValue" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:Button ID="btnOK" runat="server" onclick="btnOK_Click" Text="OK" 
            CssClass="btnApp" />
        <asp:Label ID="lblTeste" runat="server"></asp:Label>
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
            
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.adicional, promocao.desconto, promocao.titulo_promo FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN promocao ON produto.id_promo = promocao.id_promo ">
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
    </p>

        </div>

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
        <br />
        <br />

    </asp:Content>

