<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="PesquisaPerfume.aspx.cs" Inherits="PesquisaPerfume" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Perfumes</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
<p>Digite o nome do produto:
<asp:TextBox ID="txtPesquisa" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
&nbsp;<asp:Button ID="btnPesquisar" runat="server" Text="Pesquisar" 
        onclick="btnPesquisar_Click" CssClass="btnApp" Height="24px" />
        &nbsp;<asp:Label ID="lblResp" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
    <asp:RadioButtonList ID="rbStatus" runat="server" Font-Names="Calibri" 
            AutoPostBack="True" onselectedindexchanged="rbStatus_SelectedIndexChanged">
        <asp:ListItem>Perfumes Ativos</asp:ListItem>
        <asp:ListItem>Perfumes Inativos</asp:ListItem>
    </asp:RadioButtonList>
    </p>
    <p>
        <asp:GridView ID="gvExibir" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" DataKeyNames="id_prod" 
            ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center" 
            onselectedindexchanged="gvExibir_SelectedIndexChanged">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" 
                    ShowSelectButton="True" />
                <asp:TemplateField HeaderText="Excluir">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkOP" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id_prod" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_prod" />
                <asp:TemplateField HeaderText="Imagem" SortExpression="img_prod">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("img_prod") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Height="95px" 
                            ImageUrl='<%# Eval("img_prod", "{0}") %>' Width="92px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="nome_prod" HeaderText="Produto" 
                    SortExpression="nome_prod" />
                <asp:BoundField DataField="tipo_genero" HeaderText="Gênero" 
                    SortExpression="tipo_genero" />
                <asp:BoundField DataField="tipo_linha" HeaderText="Linha" 
                    SortExpression="tipo_linha" />
                <asp:BoundField DataField="desc_ml" HeaderText="Ml" 
                    SortExpression="desc_ml" />
                <asp:TemplateField HeaderText="Preço" SortExpression="valor_prod_final">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" 
                            Text='<%# Bind("valor_prod_final") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("valor_prod_final","{0:C}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="qtd_disponivel" HeaderText="Quantidade Disponível" 
                    SortExpression="qtd_disponivel" />
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
        <asp:GridView ID="gvExibirInativo" runat="server" AutoGenerateColumns="False" 
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" DataKeyNames="id_prod" 
            ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center" 
            onselectedindexchanged="gvExibir_SelectedIndexChanged">
            <Columns>
                <asp:CommandField HeaderText="Detalhes" SelectText="Abrir" 
                    ShowSelectButton="True" />
                <asp:BoundField DataField="id_prod" HeaderText="Código" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_prod" />
                <asp:TemplateField HeaderText="Imagem" SortExpression="img_prod">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("img_prod") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image2" runat="server" Height="95px" 
                            ImageUrl='<%# Eval("img_prod", "{0}") %>' Width="92px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="nome_prod" HeaderText="Produto" 
                    SortExpression="nome_prod" />
                <asp:BoundField DataField="tipo_genero" HeaderText="Gênero" 
                    SortExpression="tipo_genero" />
                <asp:BoundField DataField="tipo_linha" HeaderText="Linha" 
                    SortExpression="tipo_linha" />
                <asp:BoundField DataField="desc_ml" HeaderText="Ml" 
                    SortExpression="desc_ml" />
                <asp:TemplateField HeaderText="Preço" SortExpression="valor_prod_final">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" 
                            Text='<%# Bind("valor_prod_final") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" 
                            Text='<%# Bind("valor_prod_final","{0:C}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="qtd_disponivel" HeaderText="Quantidade Disponível" 
                    SortExpression="qtd_disponivel" />
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
    </p>

    <p>
        <asp:Button ID="btnExcluir" runat="server" onclick="btnExcluir_Click" 
            Text="Excluir" CssClass="btnApp" Visible="False" />
    </p>
        <asp:SqlDataSource ID="sqlPerfumes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
        SelectCommand="SELECT produto.id_prod, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.desc_ml, genero.tipo_genero, linha.tipo_linha, produto.status FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN linha ON produto.id_linha = linha.id_linha INNER JOIN genero ON produto.id_genero = genero.id_genero WHERE (produto.status = @status) ORDER BY linha.tipo_linha" 
        DeleteCommand="DELETE FROM produto WHERE (id_prod = @cod)" 
        UpdateCommand="UPDATE produto SET status = '1' WHERE (id_prod = @cod)">
            <DeleteParameters>
                <asp:Parameter Name="cod" />
            </DeleteParameters>
            <SelectParameters>
                <asp:Parameter Name="nome" />
                <asp:SessionParameter Name="status" SessionField="status" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="cod" />
            </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
        
        
         SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.adicional, promocao.desconto, promocao.titulo_promo FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN promocao ON produto.id_promo = promocao.id_promo">
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
    <br />
    <br />
    <br />
    <br />
    </div>
</asp:Content>

