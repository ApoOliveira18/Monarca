<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageADM.master" AutoEventWireup="true" CodeFile="EditarPerfume.aspx.cs" Inherits="EditarPerfume" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        #TextArea1
        {
            width: 190px;
            height: 66px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <h1 class="posicionamento">Editar Perfume</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
    <div class="dados">
    <p>
        <strong>DADOS ANTERIORES:</strong><asp:GridView ID="gvExibir" runat="server" 
            AutoGenerateColumns="False" DataKeyNames="id_prod" 

            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
            CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" 
            style="text-align: center">
            <Columns>
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
                <asp:BoundField DataField="desc_ml" HeaderText="Ml" SortExpression="desc_ml" />
                <asp:TemplateField HeaderText="Preço" SortExpression="valor_prod_final">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" 
                            Text='<%# Bind("valor_prod_final") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" 
                            Text='<%# Bind("valor_prod_final", "{0:C}") %>'></asp:Label>
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
    <asp:SqlDataSource ID="sqlBuscarDescontoDoProduto" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
            
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, promocao.titulo_promo, promocao.desconto, ml.adicional, ml.desc_ml FROM produto INNER JOIN promocao ON produto.id_promo = promocao.id_promo INNER JOIN ml ON produto.id_ml = ml.id_ml WHERE (produto.id_prod = @cod)">
        <SelectParameters>
            <asp:SessionParameter Name="cod" SessionField="codProduto" />
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
        <p>
        <br />
        <asp:SqlDataSource ID="sqlPerfumeCadastrado" runat="server" 
        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
        
        
            
            
            
            
                SelectCommand="SELECT produto.id_prod, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, ml.desc_ml, genero.tipo_genero, linha.tipo_linha, produto.valorUnid_prod, produto.valor_acrescimo, produto.id_genero, produto.id_linha, produto.id_ml, ml.adicional FROM produto INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN linha ON produto.id_linha = linha.id_linha INNER JOIN genero ON produto.id_genero = genero.id_genero WHERE (produto.id_prod = @cod)">
            <SelectParameters>
                <asp:SessionParameter Name="cod" SessionField="codProduto" />
            </SelectParameters>
    </asp:SqlDataSource>
        </p>
        <p>
            <strong>ALTERE OS DADOS ABAIXO:</strong></p>
 <p>Nome do Produto: 
     <asp:TextBox ID="txtNome" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
         ControlToValidate="txtNome" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>
    <p> ----------------------------------------------------</p>
    <p> Só aceita uma ÚNICA Promoção!!</p>
    <p> <strong>Opção 1.</strong> Promoção do Produto:
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
    <p><strong>Opção 2.</strong> Linha:&nbsp;<asp:DropDownList ID="ddlLinha" 
            runat="server" 
           CssClass="ddls" onselectedindexchanged="ddlLinha_SelectedIndexChanged" 
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
    <p><strong>Opção 3.</strong> Gênero:
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
    <p> Desconto da Promoção (%):
        <asp:TextBox ID="txtDesconto" runat="server" Enabled="False" ReadOnly="True" CssClass="caixa-de-texto"></asp:TextBox>
    </p>
    <p>---------------------------------------------------------</p>
    <p>Preço Unitário (R$):
        <asp:TextBox ID="txtPreco" runat="server" CssClass="caixa-de-texto"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
            ControlToValidate="txtPreco" ErrorMessage="*"></asp:RequiredFieldValidator>
        <asp:Label ID="lblErro" runat="server" style="color: #FF0000"></asp:Label>
    </p>
    <p>Conteúdo (ML):
                
        
        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
            ControlToValidate="rdbML" ErrorMessage="*"></asp:RequiredFieldValidator>
        &nbsp;<asp:RadioButtonList ID="rdbML" runat="server" AutoPostBack="True" 
            onselectedindexchanged="RadioButtonList1_SelectedIndexChanged" margin-right="10px">
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
        <asp:TextBox ID="txtAcresc" runat="server" Enabled="False" ReadOnly="True" CssClass="caixa-de-texto"></asp:TextBox>
    &nbsp;
        <asp:Label ID="lblAcres" runat="server"></asp:Label>
    </p>
    <p>Preço Final (R$): 
        <asp:TextBox ID="txtPrecoFinal" runat="server" Enabled="False" ReadOnly="True" CssClass="caixa-de-texto"></asp:TextBox>
    &nbsp;</p>
    <p>Quantidade de Estoque:
        <asp:TextBox ID="txtEstoque" runat="server" CssClass="caixa-de-texto" ></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
            ControlToValidate="txtEstoque" ErrorMessage="*"></asp:RequiredFieldValidator>
    </p>

         <p>
         <label class="file-upload">
         <strong>Foto</strong>
         <asp:FileUpload ID="fileFoto" runat="server" >
         </asp:FileUpload>
         </label>
         </p>



 <p>Descrição: 
     <asp:TextBox ID="txtDesc" runat="server" Height="118px" TextMode="MultiLine" 
         Width="310px" CssClass="caixa-de-texto-grande"></asp:TextBox>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
         ControlToValidate="txtDesc" ErrorMessage="*"></asp:RequiredFieldValidator>
     </p>
        <p>Slogan:
        <asp:TextBox ID="txtSlogan" runat="server" Width="310px" 
            CssClass="caixa-de-texto-grande" Height="70px" TextMode="MultiLine"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
            ControlToValidate="txtSlogan" ErrorMessage="*"></asp:RequiredFieldValidator>
     </p>
    </div>
    <p>
        <asp:Button ID="btnEditar" runat="server" onclick="btnEditar_Click" 
            Text="Editar" CssClass="btnApp" />
    </p>
    <p>
        <asp:SqlDataSource ID="sqlAlterarDadosAntigos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [produto]" 
            UpdateCommand="UPDATE produto SET id_genero = @genero, id_linha = @linha, id_ml = @ml, id_promo = @promo, nome_prod = @nome, desc_prod = @descricao, slogan_prod = @slogan, valorUnid_prod = @precoUnid, valor_acrescimo = @precoAcres, valor_prod_final = @precoFinal, img_prod = @foto, qtd_disponivel = @qtd WHERE (id_prod = @cod)">
            <UpdateParameters>
                <asp:SessionParameter Name="cod" SessionField="codProduto" />
                <asp:Parameter Name="nome" />
                <asp:ControlParameter ControlID="ddlPromocao" Name="promo" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlGenero" Name="genero" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlLinha" Name="linha" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="rdbML" Name="ml" 
                    PropertyName="SelectedValue" />
                <asp:Parameter Name="slogan" />
                <asp:Parameter Name="descricao" />
                <asp:Parameter Name="precoUnid" />
                <asp:Parameter Name="precoAcres" />
                <asp:Parameter Name="precoFinal" />
                <asp:Parameter Name="foto" />
                <asp:Parameter Name="qtd" />
            </UpdateParameters>
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

