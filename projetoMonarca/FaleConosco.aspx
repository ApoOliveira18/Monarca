<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="FaleConosco.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
		<script src="js/modernizr3.custom.js"></script>
		<script src="js/modernizr2.custom.js"></script>

            
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="container2">
			<div class="divisoria1">
                <br />
                <h3>Redes Sociais</h3><br />
                <div class="fb-page" data-href="https://www.facebook.com/mnperfumes" data-height="220" data-small-header="true" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false">
                <div class="fb-xfbml-parse-ignore"><blockquote cite="https://www.facebook.com/mnperfumes"><a href="https://www.facebook.com/mnperfumes">Monarca Perfumes</a></blockquote></div></div>
                <br />
                <div class="link-preto"><br />
                 <p><a href="https://twitter.com/mnperfumes" target="_blank" ><img src="images/twitter-contato.png" >twitter.com/mnperfumes</a></p><br />
                <p><a href="http://instagram.com/mnperfumes?ref=badge" target="_blank" ><img src="images/instagram-contato.png">@mnperfumes</a></p><br />
                </div>
                <h3>Outros</h3><br />
                <p><strong>E-MAIL:</strong> monarcaperfumes@gmail.com</p><br />
                <p><strong>ENDEREÇO: </strong></p><br />
                <p>Av. Barão do Rio Branco, 882, Jd. Esplanada</p><br />
                <p>São José dos Campos - SP</p><br />
                <p>12242-800</p><br />
                <p><strong>TELEFONE: </strong>(12)3942-2200</p><br />

            </div>
            <div class="linha-vertical"></div>
            <br />
            <div class="divisoria2">
                <h3>Mensagem</h3><br />
                <p>Nome: <asp:TextBox ID="txtNomeRemetente" runat="server" Width="263px" 
                        CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" 
                        ControlToValidate="txtNomeRemetente"></asp:RequiredFieldValidator></p>    <br />
                <p>E-mail: 
                    <asp:TextBox ID="txtEmailRemetente" runat="server" 
                        placeholder=" nome@exemplo.com" Width="201px" CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" 
                        ControlToValidate="txtEmailRemetente"></asp:RequiredFieldValidator></p><br />
                <p>Assunto: <asp:TextBox ID="txtAssunto" runat="server" Width="181px" 
                        CssClass="caixa-de-texto"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" 
                        ControlToValidate="txtAssunto"></asp:RequiredFieldValidator></p><br />
                <p>Mensagem: </p><br />
                <asp:TextBox ID="txtMensagem" runat="server" Height="216px" 
                    TextMode="MultiLine" Width="402px" CssClass="caixa-de-texto-grande"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
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
            </div>   
			</div>


</asp:Content>

