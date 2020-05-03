<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="fale-conosco.aspx.cs" Inherits="Fale_Conosco" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="content-fc">

    <div class="parte1">
    
        <div class="caixaMenu">
            <%--<div class="topo_menu">Auto Atendimento</div>--%>
            <div class="opcoes-menu">
                <ul>
                    
                    <li><a href="politica_de_privacidade.aspx"> Política de Privacidade </a></li>
                    <li><a href="termos-e-condicoes.aspx"> Termos e Condições </a></li>
                    <li><a href="trocas-e-devolucoes.aspx"> Trocas e Devoluções </a></li>
                    <li><a href="prazos-de-entrega.aspx"> Prazos de Entrega </a></li>
                    <li><a href="duvidas-frequentes.aspx"> Dúvidas Frequentes</a></li>
                    <li><a href="fale-conosco.aspx"> Fale Conosco </a></li>
                    
                </ul>
            </div>
        </div>

    </div>
    
    <div class="parte2">
        
        <h1>Fale Conosco</h1>
        <br />
        <br />
        <br />

                    <div class="sub-titulo">MANDE UM E-MAIL PARA NÓS.</div>
                    <p>
                    <br />
                    Nome: <asp:TextBox ID="txtNomeRemetente" runat="server" Width="250px" 
                        CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" 
                        ControlToValidate="txtNomeRemetente"></asp:RequiredFieldValidator></p>   
                    <p>
                    <br />
                    E-mail: 
                    <asp:TextBox ID="txtEmailRemetente" runat="server" 
                        placeholder=" nome@exemplo.com" Width="201px" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" 
                        ControlToValidate="txtEmailRemetente"></asp:RequiredFieldValidator></p>
                    <p>
                    <br />
                    Assunto: <asp:TextBox ID="txtAssunto" runat="server" Width="181px" 
                        CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" 
                        ControlToValidate="txtAssunto"></asp:RequiredFieldValidator></p>
                    <p>
                    <br />
                    Mensagem: </p><br />
                    <asp:TextBox ID="txtMensagem" runat="server" Height="216px" 
                    TextMode="MultiLine" Width="100%" CssClass="caixa-de-texto-grande"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" 
                        ControlToValidate="txtMensagem"></asp:RequiredFieldValidator>
                    <br />



                    <p><br />Anexar Imagem:
                
                    <label class="file-upload">
                    <strong>Procurar</strong>
                    <asp:FileUpload ID="arquivosAnexo" runat="server" >
                    </asp:FileUpload>
                    </label>

                    </p><br />
                    <br />


                    <asp:Button ID="btnEnviar" runat="server" onclick="btnEnviar_Click" 
                        Text="Enviar" CssClass="btnApp" />
                    <br />
                    <br />
                    &nbsp;<asp:Label ID="lblResp" runat="server" style="color: #808080"></asp:Label><br />

                    <br />

                    <br />
                    
                    <div class="sub-titulo">REDES SOCIAIS</div>
                    <br />
                    <br />
                    
                    <div style="width:100%" >
                    <div class="fb-page" data-href="https://www.facebook.com/mnperfumes" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="false" data-show-posts="false">
                        <div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/mnperfumes"><a href="https://www.facebook.com/mnperfumes">Monarca Perfumes</a></blockquote>
                        </div>
                    </div>
                    </div>



                    <br />
                    <br />
                   

                    <br />
                    <div class="link-preto"><br />
                    <br />
                    <p><a href="https://twitter.com/mnperfumes" target="_blank" ><img src="images/twitter-contato.png" >twitter.com/mnperfumes</a></p><br />
                    <p><a href="http://instagram.com/mnperfumes?ref=badge" target="_blank" ><img src="images/instagram-contato.png">@mnperfumes</a></p><br />
                    </div>
                    <br />
                    
                    <div class="sub-titulo">OUTROS</div>
                    <br />

                    <p><br /><strong>E-MAIL:</strong> monarcaperfumes@gmail.com</p>
                    <p><br /><strong>ENDEREÇO: </strong></p>
                    <p><br />Av. Barão do Rio Branco, 882, Jd. Esplanada - 12242-800</p>
                    <p><br />São José dos Campos - SP</p>
                    <p><br /><strong>TELEFONE: </strong>(12)3942-2200</p>

           
    </div>



</div>


</asp:Content>

