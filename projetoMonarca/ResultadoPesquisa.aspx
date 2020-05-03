<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="ResultadoPesquisa.aspx.cs" Inherits="ResultadoPesquisa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <link rel="stylesheet" type="text/css" href="css/estilo_perfil_cliente.css"/>
      <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />
      <style type="text/css">
          .auto-style1 {
              text-align: center;
          }
      </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
<div id="centralizar-total2">
<div id="tudo">
<br />
    <br />
    <h1>Resultado da Pesquisa</h1>
	<div id="container">
        <asp:Label ID="lblQtdResultados" runat="server" Font-Bold="True"></asp:Label>
        &nbsp;<asp:Label ID="lblResultadosEncontrados" runat="server" Text=" resultados foram encontrados."></asp:Label>

        <br />

       <%-- <div id="resultadoProduto">--%>
            <asp:DataList ID="DataList1" runat="server" DataKeyField="id_prod" 
                RepeatDirection="Horizontal" RepeatColumns="3">
                <ItemTemplate>
                    &nbsp;&nbsp;<br />&nbsp;<br />&nbsp;<asp:Image ID="Image1" runat="server" Height="128px" 
                        ImageUrl='<%# Eval("img_prod", "{0}") %>' Width="115px" />
                    <br />
                    &nbsp;<asp:Label ID="nome_prodLabel" runat="server" 
                        Text='<%# Eval("nome_prod") %>' Font-Bold="True" />
                    <br />
                    &nbsp;<asp:Label ID="tipo_linhaLabel" runat="server" 
                        Text='<%# Eval("tipo_linha") %>' />
                    <br />
                    &nbsp;<asp:Label ID="tipo_generoLabel" runat="server" 
                        Text='<%# Eval("tipo_genero") %>' />
                    <br />
                    &nbsp;<asp:Label ID="valor_prod_finalLabel" runat="server" 
                        Text='<%# Eval("valor_prod_final", "{0:C}") %>' />
                    <br />
                    <br />
                    <asp:HyperLink ID="HyperLink1" runat="server" ImageUrl="~/img/vejaMais.png" 
                        NavigateUrl='<%# Eval("id_prod", "produtoBusca.aspx?id={0}") %>'></asp:HyperLink>
                    <br />

                </ItemTemplate>
            </asp:DataList><%--</div>--%>
        <div id="resultadoLinha">
        </div>
        
        <asp:SqlDataSource ID="sqlPesquisaProduto" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT produto.id_prod, produto.status, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, genero.tipo_genero, linha.tipo_linha FROM produto INNER JOIN linha ON produto.id_linha = linha.id_linha INNER JOIN genero ON produto.id_genero = genero.id_genero">
            <SelectParameters>
                <asp:Parameter Name="pesquisa" />
            </SelectParameters>
        </asp:SqlDataSource>
	</div>
</div>

    
    </div>
</asp:Content>

