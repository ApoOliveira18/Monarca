<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="Store.aspx.cs" Inherits="Store" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <!-- Nova Store-->
    <div class="cor-fundo">
        
        <div class="titulo-store">
        <h1>Perfumes</h1>

        </div>
        <div class="menu-store">
            <div class="tipo-menu"> Gênero </div>
               
                 <asp:RadioButtonList ID="rbGenero"  runat="server"   onselectedindexchanged="rbGenero_SelectedIndexChanged"  AutoPostBack="True" CssClass="rb">
                     <asp:ListItem Value="0">Feminino</asp:ListItem> 
                     <asp:ListItem Value="1">Masculino</asp:ListItem> 
                 </asp:RadioButtonList>
                
            
            
               <div class="tipo-menu"> Linha </div>
                
                 <asp:RadioButtonList ID="rbLinha" runat="server" AutoPostBack="True" 
                OnSelectedIndexChanged="rbLinha_SelectedIndexChanged">
                 </asp:RadioButtonList>
            <asp:SqlDataSource ID="sqlExibirLinha" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                SelectCommand="SELECT * FROM linha"></asp:SqlDataSource>
                <br />
            <asp:LinkButton ID="lbDesmarcar" runat="server" onclick="lbDesmarcar_Click">Desmarcar Opções</asp:LinkButton>
                 
             
        </div>

        <!--sqls-->
        			
       <asp:SqlDataSource ID="sqlStore" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                
                
            SelectCommand="SELECT produto.id_prod, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, genero.tipo_genero, linha.tipo_linha, produto.id_linha, produto.status FROM produto INNER JOIN genero ON produto.id_genero = genero.id_genero INNER JOIN linha ON produto.id_linha = linha.id_linha WHERE (produto.status = '0')"></asp:SqlDataSource>

         <asp:SqlDataSource ID="sqlGenero" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             
             
            
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.id_promo, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, linha.tipo_linha, genero.tipo_genero, produto.status FROM produto INNER JOIN genero ON produto.id_genero = genero.id_genero INNER JOIN linha ON produto.id_linha = linha.id_linha WHERE (produto.id_genero = @sexo) AND (produto.status = '0')">
             <SelectParameters>
                 <asp:SessionParameter Name="sexo" SessionField="sexo" />
             </SelectParameters>
         </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlPerfumePorLinha" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                
                
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, linha.tipo_linha, genero.tipo_genero, produto.status FROM produto INNER JOIN linha ON produto.id_linha = linha.id_linha INNER JOIN genero ON produto.id_genero = genero.id_genero WHERE (produto.id_linha = @codlinha) AND (produto.status = '0')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="rbLinha" Name="codlinha" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
			
			<asp:SqlDataSource ID="sqlPerfumePorLinhaEMasculino" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, genero.tipo_genero, linha.tipo_linha, produto.status FROM produto INNER JOIN genero ON produto.id_genero = genero.id_genero INNER JOIN linha ON produto.id_linha = linha.id_linha WHERE (produto.id_genero = 2) AND (produto.id_linha = @linha) AND (produto.status = '0')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="rbLinha" Name="linha" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlPerfumePorLinhaEFeminino" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                
            SelectCommand="SELECT produto.id_prod, produto.id_genero, produto.id_linha, produto.id_ml, produto.nome_prod, produto.desc_prod, produto.slogan_prod, produto.valorUnid_prod, produto.valor_acrescimo, produto.valor_prod_final, produto.img_prod, produto.qtd_disponivel, linha.tipo_linha, genero.tipo_genero, linha.status FROM produto INNER JOIN linha ON produto.id_linha = linha.id_linha INNER JOIN genero ON produto.id_genero = genero.id_genero WHERE (produto.id_linha = @linha) AND (produto.id_genero = 1) AND (linha.status = '0')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="rbLinha" Name="linha" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        <!--fim sqls-->


        <div class="produtos-store">

            <asp:SqlDataSource ID="sqlPesquisaPreco" runat="server" 
                ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
                
                SelectCommand="SELECT id_prod, valorUnid_prod, valor_prod_final, valor_acrescimo FROM produto WHERE (id_prod = @cod)">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="cod" SessionField="pesquisaPreco" />
                </SelectParameters>
            </asp:SqlDataSource>

            <div  class="prod">

                <div id="divProd1" runat="server" class="img-prod">
                    <asp:ImageButton ID="ImageButton1" runat="server" Height="300px"  Width="300px" onclick="ImageButton1_Click" />
                </div>

                <div id="divProd11" runat="server" class="preco-prod">
                    <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click" CssClass="texto-venda" Font-Bold="True">LinkButton</asp:LinkButton>
                    <br />
                    <div class="linha-store"><asp:Label ID="lblLinha1" runat="server" CssClass="texto-venda"></asp:Label>
                    <br />
                    <asp:Label ID="lblGenero1" runat="server" CssClass="texto-venda"></asp:Label>
                    </div>
                    
                    <br />
                    <asp:Label ID="lblPrecoAntigo1" runat="server" CssClass="texto-venda" 
                        Font-Overline="False" Font-Strikeout="True" Font-Underline="False" 
                        Visible="False" Font-Size="11pt"></asp:Label>
                &nbsp;<br />
                    <asp:Label ID="lblPreco1" runat="server" CssClass="texto-venda"></asp:Label>
                    <br />
                &nbsp;&nbsp;
                </div>

            </div>

            <div class="prod">
                <div id="divProd2" runat="server" class="img-prod">
                    <asp:ImageButton ID="ImageButton2" runat="server"  Height="300px"  Width="300px" onclick="ImageButton2_Click" />
                </div>
                <div id="divProd22" runat="server" class="preco-prod">
                     <asp:LinkButton ID="LinkButton2" runat="server" onclick="LinkButton2_Click" CssClass="texto-venda" Font-Bold="True">LinkButton</asp:LinkButton>
                     <br />
                     <div class="linha-store"><asp:Label ID="lblLinha2" runat="server" CssClass="texto-venda"></asp:Label>
                     <br />
                     <asp:Label ID="lblGenero2" runat="server" CssClass="texto-venda"></asp:Label>
                     </div>
                     <br />
                    <asp:Label ID="lblPrecoAntigo2" runat="server" CssClass="texto-venda" 
                         Font-Overline="False" Font-Strikeout="True" Font-Underline="False" 
                         Visible="False" Font-Size="11pt"></asp:Label>
                     <br />
                     <asp:Label ID="lblPreco2" runat="server" CssClass="texto-venda"></asp:Label>
                </div>
            </div>

            <div class="prod">

                <div id="divProd3" runat="server" class="img-prod">
                    <asp:ImageButton ID="ImageButton3" runat="server"  Height="300px"  Width="300px" onclick="ImageButton3_Click" />
                </div>

                <div id="divProd33" runat="server" class="preco-prod">
                    <asp:LinkButton ID="LinkButton3" runat="server" onclick="LinkButton3_Click" CssClass="texto-venda" Font-Bold="True">LinkButton</asp:LinkButton>
                    <br />
                    <div class="linha-store"><asp:Label ID="lblLinha3" runat="server" CssClass="texto-venda"></asp:Label>
                    <br />
                    <asp:Label ID="lblGenero3" runat="server" CssClass="texto-venda"></asp:Label>
                    </div>
                    <br />
                    <asp:Label ID="lblPrecoAntigo3" runat="server" CssClass="texto-venda" 
                        Font-Overline="False" Font-Strikeout="True" Font-Underline="False" 
                        Visible="False" Font-Size="11pt"></asp:Label>
                &nbsp;<br />
                    <asp:Label ID="lblPreco3" runat="server" CssClass="texto-venda"></asp:Label>
                </div>

            </div>

            <div  class="prod">

                <div id="divProd4" runat="server" class="img-prod">
                    <asp:ImageButton ID="ImageButton4" runat="server"  Height="300px"  Width="300px" onclick="ImageButton4_Click" />
                </div>

                <div id="divProd44" runat="server" class="preco-prod">
                    <asp:LinkButton ID="LinkButton4" runat="server" onclick="LinkButton4_Click" CssClass="texto-venda" Font-Bold="True">LinkButton</asp:LinkButton>
                    <br />
                    <div class="linha-store"><asp:Label ID="lblLinha4" runat="server" CssClass="texto-venda"></asp:Label>
                    <br />
                    <asp:Label ID="lblGenero4" runat="server" CssClass="texto-venda"></asp:Label>
                    </div>
                    <br />
                    <asp:Label ID="lblPrecoAntigo4" runat="server" CssClass="texto-venda" 
                        Font-Overline="False" Font-Strikeout="True" Font-Underline="False" 
                        Visible="False" Font-Size="11pt"></asp:Label>
                &nbsp;<br />
                    <asp:Label ID="lblPreco4" runat="server" CssClass="texto-venda"></asp:Label>
                </div>

            </div>

            <div class="prod">
                <div id="divProd5" runat="server" class="img-prod">
                    <asp:ImageButton ID="ImageButton5" runat="server"  Height="300px"  Width="300px" onclick="ImageButton5_Click" />
                </div>

                <div id="divProd55" runat="server" class="preco-prod">
                    <asp:LinkButton ID="LinkButton5" runat="server" onclick="LinkButton5_Click" CssClass="texto-venda" Font-Bold="True">LinkButton</asp:LinkButton>
                    <br />
                    <div class="linha-store"><asp:Label ID="lblLinha5" runat="server" CssClass="texto-venda"></asp:Label>
                    <br />
                    <asp:Label ID="lblGenero5" runat="server" CssClass="texto-venda"></asp:Label>
                    </div>
                    <br />
                    <asp:Label ID="lblPrecoAntigo5" runat="server" CssClass="texto-venda" 
                        Font-Overline="False" Font-Strikeout="True" Font-Underline="False" 
                        Visible="False" Font-Size="11pt"></asp:Label>
                &nbsp;<br />
                    <asp:Label ID="lblPreco5" runat="server" CssClass="texto-venda"></asp:Label>
                </div>

            </div>
    
        </div>
    
    
    </div>






</asp:Content>

