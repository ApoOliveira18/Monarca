<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="Compra.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
.cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
    height: 1600px;
}
input[type="checkbox"] {
	position:           relative;
	opacity: 			1;
	-moz-opacity: 		1;
	-webkit-opacity: 	1;
	-o-opacity: 		1;
	}

h1{
    font-size: 3rem;
    line-height: 4.35rem;
    font-weight: 600;
    letter-spacing: .1em;
    text-transform: uppercase;
    margin: 0 auto;
    padding-top: 10px;
    color: #000;
    font-family: "Century Gothic";
    width:80%;
    }
    
    @media screen  and (max-width: 1023px)
    {
        .conteudo-produtos{
        float: left;
        margin-left: 5%;
        background-color: #fff;
        -webkit-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        -moz-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        margin-right: 10px;
        min-height: 400px;
        width: 90%;
        padding: 2%;
        }
        .resumo{
        width: 90%;
        height: 250px;
        float: right;
        margin-right: 5%;
        margin-top: 20px;
        background-color: #fff;
        -webkit-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        -moz-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        padding: 2%;
        }
        .frete{
        float: left;
        margin-left: 5%;
        background-color: #fff;
        -webkit-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        -moz-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
        margin-right: 10px;
        width: 90%;
        padding: 2%;
        margin-top: 10px;
        
        }
        .cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
    height: 1800px;
}
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<br />
<br />
<h1>Minha Sacola</h1>
<br />
<br />
<div class="conteudo-produtos">
        <h2>Produto(s) Escolhidos:</h2>
        <br />
        <div class="linha-100"></div>
        <!---Grid-->
        <asp:GridView ID="GridView1" runat="server" BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            ForeColor="Black" GridLines="Horizontal" Width="595px" 
            AutoGenerateColumns="False" style="text-align: center" DataKeyNames="id_itens" >
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:CheckBox ID="chkOP" runat="server" BorderColor="#000000" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="id_itens" HeaderText="id_itens" 
                            InsertVisible="False" ReadOnly="True" SortExpression="id_itens" />
                        <asp:TemplateField HeaderText="qtd_item" SortExpression="qtd_item">
                            <EditItemTemplate>
   
        
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("qtd_item") %>'></asp:TextBox>
   
        
                                <asp:Label ID="lblQTD" runat="server" Text='<%# Bind("qtd_item") %>'></asp:Label>
                            </EditItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("qtd_item") %>'></asp:TextBox>
   
        
                                <asp:Label ID="lblQTD" runat="server" Text='<%# Bind("qtd_item") %>'></asp:Label>
                            
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="img_prod" SortExpression="img_prod">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="91px" 
                                    ImageUrl='<%# Eval("img_prod", "{0}") %>' Width="98px" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("img_prod") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="nome_prod" HeaderText="nome_prod" 
                            SortExpression="nome_prod" />
                        <asp:BoundField DataField="desc_ml" HeaderText="ML" SortExpression="desc_ml" />
                        <asp:BoundField DataField="tipo_genero" HeaderText="tipo_genero" 
                            SortExpression="tipo_genero" />
                        <asp:TemplateField HeaderText="total_prod" SortExpression="total_prod">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("total_prod", "{0:C}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("total_prod") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
            <FooterStyle BackColor="#FFFFFF" ForeColor="Black" />
            <HeaderStyle BackColor="#FFFFFF" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        <!--Grid-->

        <asp:Button ID="btnExcluir" runat="server" Text="Excluir" CssClass="btnApp" OnClick="btnExcluir_Click" />


        <!--SQLS-->
                    <asp:SqlDataSource ID="sqlProdutoEscolhido" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
      
                    SelectCommand="SELECT produto.id_prod, produto.nome_prod, produto.valorUnid_prod, produto.img_prod, genero.tipo_genero, produto.status FROM produto INNER JOIN genero ON produto.id_genero = genero.id_genero WHERE (produto.id_prod = @prodCompra)">
                    <SelectParameters>
                        <asp:SessionParameter Name="prodCompra" SessionField="ProdutoEscolhido" />
                    </SelectParameters>
                </asp:SqlDataSource>
        <!--Sqls-->


</div>
<div class="resumo">
        <h2>Resumo</h2>
        <br />
        <h4>Subtotal  <asp:Label ID="lblValorCompra" runat="server"></asp:Label></h4>
        <br />
        <h4>Frete   <asp:Label ID="lblValorFrete" runat="server"></asp:Label></h4>
        <br />
        <div class="linha-100"></div>
        <br />
        <h3>Total   R$   <asp:Label ID="lblValorTotal" runat="server"></asp:Label></h3>
        <br />
        <asp:Button ID="btnComprar" runat="server" onclick="btnComprar_Click" Text="Continuar" CssClass="btnApp" />
</div>
<div class="frete">
        <h2>Calcular Frete:</h2>
        <br />
        <div class="linha-100"></div>
        <br />
        <h3>Destino:</h3>
        <div class="opcoes-end">
            <asp:RadioButtonList ID="rbMeuEnd" runat="server" AutoPostBack="True" 
                onselectedindexchanged="rbMeuEnd_SelectedIndexChanged">
            </asp:RadioButtonList>
        <asp:RadioButtonList ID="rbEnd" runat="server" AutoPostBack="True" onselectedindexchanged="rbEnd_SelectedIndexChanged"> </asp:RadioButtonList>
            <asp:SqlDataSource ID="sqlMeuEnd" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT id_cli, status, sexo_cli, CEP_cli, num_cli FROM cliente WHERE (status = '0')">
                <SelectParameters>
                    <asp:SessionParameter Name="cod" SessionField="idCliente" />
                </SelectParameters>
            </asp:SqlDataSource>
        <br /><asp:LinkButton ID="linkEndereco" runat="server" onclick="linkEndereco_Click">Adicionar endereço.</asp:LinkButton>
        <!---sqls-->
                        <asp:SqlDataSource ID="sqlEndAdicionais" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                    
                SelectCommand="SELECT id_end, CEP_cli, num_cli, compl_cli, nome_end, cidade_end, rua_end, estado_end, id_cli FROM endereco WHERE (id_cli = @cod)">
                    <SelectParameters>
                        <asp:SessionParameter Name="cod" SessionField="idCliente" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlEndEscolhido" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                    ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                    SelectCommand="SELECT id_end, CEP_cli, num_cli, compl_cli, nome_end, cidade_end, rua_end, estado_end, id_cli FROM endereco WHERE (id_end = @end)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="rbEnd" Name="end" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlFormaPagto" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                        SelectCommand="SELECT * FROM pagamento"></asp:SqlDataSource>

                    <asp:SqlDataSource ID="sqlItensComprados" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                        
                        SelectCommand="SELECT itens.id_itens, itens.qtd_item, produto.img_prod, produto.nome_prod, ml.desc_ml, genero.tipo_genero, itens.total_prod, itens.status FROM itens INNER JOIN produto ON itens.id_prod = produto.id_prod INNER JOIN ml ON produto.id_ml = ml.id_ml INNER JOIN genero ON produto.id_genero = genero.id_genero INNER JOIN venda ON itens.id_venda = venda.id_venda WHERE (itens.status = '0') AND (venda.id_cli = @codCli)" 
                        DeleteCommand="DELETE FROM itens WHERE (id_itens = @cod)" 
                        UpdateCommand="UPDATE itens SET status = '1' WHERE (id_prod = @cod)">
                        <DeleteParameters>
                            <asp:Parameter Name="cod" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:SessionParameter Name="id" SessionField="ProdutoEscolhido" />
                            <asp:SessionParameter Name="codCli" SessionField="idCliente" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:SessionParameter Name="cod" SessionField="ProdutoEscolhido" />
                        </UpdateParameters>
                    </asp:SqlDataSource>

                    <asp:SqlDataSource ID="sqlSomarItensdoCarrinho" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                        ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                        SelectCommand="SELECT id_itens, id_venda, id_prod, qtd_item, SUM(total_prod) as Total FROM itens WHERE (id_venda = @id)">
                        <SelectParameters>
                            <asp:SessionParameter Name="id" SessionField="idVendas" />
                        </SelectParameters>
                    </asp:SqlDataSource>
        <!---sqls-->
        </div>
        <br />
        <h3>Frete:
            <asp:Label ID="lblValorFrete2" runat="server"></asp:Label>
        </h3>
        <br />
        <h3>Estado de Entrega: <asp:Label ID="lblEstadoEntrega" runat="server"></asp:Label></h3>
        <br />
        <h3>Prazo de Entrega: <asp:Label ID="lblPrazo" runat="server"></asp:Label>
            <asp:SqlDataSource ID="sqlPesquisaEndCliente" runat="server" ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" SelectCommand="SELECT id_cli, status, CEP_cli FROM cliente WHERE (id_cli = @cod) AND (status = '0')">
                <SelectParameters>
                    <asp:SessionParameter Name="cod" SessionField="idCliente" />
                </SelectParameters>
            </asp:SqlDataSource>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="ddls" 
                    AutoPostBack="True" onselectedindexchanged="ddlEstado_SelectedIndexChanged1" Visible="False">
                    <asp:ListItem>SELECIONE</asp:ListItem>
                    <asp:ListItem>AC</asp:ListItem>
                    <asp:ListItem>AL</asp:ListItem>
                    <asp:ListItem>AP</asp:ListItem>
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem>BA</asp:ListItem>
                    <asp:ListItem>CE</asp:ListItem>
                    <asp:ListItem>DF</asp:ListItem>
                    <asp:ListItem>ES</asp:ListItem>
                    <asp:ListItem>GO</asp:ListItem>
                    <asp:ListItem>MA</asp:ListItem>
                    <asp:ListItem>MT</asp:ListItem>
                    <asp:ListItem>MS</asp:ListItem>
                    <asp:ListItem>MG</asp:ListItem>
                    <asp:ListItem>PA</asp:ListItem>
                    <asp:ListItem>PB</asp:ListItem>
                    <asp:ListItem>PR</asp:ListItem>
                    <asp:ListItem>PE</asp:ListItem>
                    <asp:ListItem>PI</asp:ListItem>
                    <asp:ListItem>RJ</asp:ListItem>
                    <asp:ListItem>RN</asp:ListItem>
                    <asp:ListItem>RS</asp:ListItem>
                    <asp:ListItem>RO</asp:ListItem>
                    <asp:ListItem>RR</asp:ListItem>
                    <asp:ListItem>SC</asp:ListItem>
                    <asp:ListItem>SP</asp:ListItem>
                    <asp:ListItem>SE</asp:ListItem>
                    <asp:ListItem>TO</asp:ListItem>
                </asp:DropDownList>
                </h3>
</div>


</asp:Content>

