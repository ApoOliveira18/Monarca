using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using System.Net; // importe o namespace .Net
using System.Net.Mail; // importe o namespace .Net.Mail
using System.IO;
using System.Net.Mime;

public partial class _Default : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        //buscar dados do cliente mais recente
        DataView dv = (DataView)sqlDadosParaEmail.Select(DataSourceSelectArguments.Empty);

        Session["idClienteNovo"] = dv.Table.Rows[0]["id_cli"].ToString();

        DataView dv2 = (DataView)sqlDadosEspecificos.Select(DataSourceSelectArguments.Empty);

        string nome, email;
        nome = cripto.Decrypt(dv2.Table.Rows[0]["nome_cli"].ToString());
        email = cripto.Decrypt(dv2.Table.Rows[0]["email_cli"].ToString());

        SmtpClient cliente = new SmtpClient("smtp.live.com");
        cliente.EnableSsl = true;

        MailAddress remetente = new MailAddress("monarcaperfumes@gmail.com", "Equipe Monarca");
        MailAddress destinatario = new MailAddress(email, nome);

        MailMessage mensagem = new MailMessage(remetente, destinatario);


        var computadorMN = "Image";
        var inlineLogo = new Attachment(Server.MapPath("images/computadormonarca.png"));
        inlineLogo.ContentId = computadorMN;
        inlineLogo.ContentDisposition.Inline = true;
        inlineLogo.ContentDisposition.DispositionType = DispositionTypeNames.Inline;

        var rio = "Image2";
        var inlineLogo2 = new Attachment(Server.MapPath("images/RioEmail.png"));
        inlineLogo2.ContentId = rio;
        inlineLogo2.ContentDisposition.Inline = true;
        inlineLogo2.ContentDisposition.DispositionType = DispositionTypeNames.Inline;

        var linha = "Image3";
        var inlineLogo3 = new Attachment(Server.MapPath("images/linha-email-1.png"));
        inlineLogo3.ContentId = linha;
        inlineLogo3.ContentDisposition.Inline = true;
        inlineLogo3.ContentDisposition.DispositionType = DispositionTypeNames.Inline;

        var logo = "Image4";
        var inlineLogo4 = new Attachment(Server.MapPath("images/logo-email.png"));
        inlineLogo4.ContentId = logo;
        inlineLogo4.ContentDisposition.Inline = true;
        inlineLogo4.ContentDisposition.DispositionType = DispositionTypeNames.Inline;

        var instagram = "Image5";
        var inlineLogo5 = new Attachment(Server.MapPath("images/instagram-email.png"));
        inlineLogo5.ContentId = instagram;
        inlineLogo5.ContentDisposition.Inline = true;
        inlineLogo5.ContentDisposition.DispositionType = DispositionTypeNames.Inline;

        var facebook = "Image6";
        var inlineLogo6 = new Attachment(Server.MapPath("images/facebook-email.png"));
        inlineLogo6.ContentId = facebook;
        inlineLogo6.ContentDisposition.Inline = true;
        inlineLogo6.ContentDisposition.DispositionType = DispositionTypeNames.Inline;

        var twitter = "Image7";
        var inlineLogo7 = new Attachment(Server.MapPath("images/twitter-email.png"));
        inlineLogo7.ContentId = twitter;
        inlineLogo7.ContentDisposition.Inline = true;
        inlineLogo7.ContentDisposition.DispositionType = DispositionTypeNames.Inline;

        mensagem.IsBodyHtml = true;
        mensagem.Attachments.Add(inlineLogo);
        mensagem.Attachments.Add(inlineLogo2);
        mensagem.Attachments.Add(inlineLogo3);
        mensagem.Attachments.Add(inlineLogo4);
        mensagem.Attachments.Add(inlineLogo5);
        mensagem.Attachments.Add(inlineLogo6);
        mensagem.Attachments.Add(inlineLogo7);
        mensagem.Body = 
           "<!DOCTYPE html>" +
               "<html xmlns=\'http://www.w3.org/1999/xhtml'>" +
               "<head>" +
                       "<title>Monarca</title>" +
                   "<style>" +
                   "/*Email para o cliente - cadastro*/" +

       ".topo-email{" +
       "width:			100%;" +
       "height:			7px;" +
       "background:		#000;" +
       "margin-top: 	33px;" +
       "}" +
       "a:link, a:visited {" +
       "text-decoration: none;" +
       "}" +
       ".titulo-email{" +
       "font-family: 	'Lato', Calibri, Arial, sans-serif;" +
       "font-size:		2.3em;" +
       "font-weight:	300;" +
       "-webkit-font-smoothing: antialiased;" +
       "}" +
       ".caixa-email{" +
       "width:			100%;" +
       "height:			auto;" +
       "background:		#FFF;" +
       "border-right: 	1px solid #ccc;" +
       "border-bottom: 	1px solid #ccc;" +
       "margin:			0;" +
       "margin-top: 	-33px;" +
       "padding: 		2px;" +

       "}" +
       ".conteudo-email{" +
       "width:			80%;" +
       "margin:			0 auto;" +
       "font-family:	'Lato', Calibri, Arial, sans-serif;" +
       "line-height:	2.5em;" +
       "}" +
       ".conteudo-email a{" +
       "text-decoration:none;" +
       "}" +
       ".conteudo-email a p{" +
       "text-decoration:none;" +
       "}" +
       ".conteudo-email a p:hover{" +
       "text-decoration:	underline;" +
       "color:				#ccc;" +
       "-webkit-transition: all 0.2s;" +
       "-moz-transition: 	all 0.2s;" +
       "-ms-transition: 	all 0.2s;" +
       "-o-transition: 		all 0.2s;" +
       "transition:		 	all 0.2s;" +

       "}" +
       ".conteudo-email  h1{" +
       "text-align:		center;" +
       "font-size:		2.5em;" +
       "font-weight:	700;" +
       "color:			#212121;" +
       "}" +
       ".conteudo-email  h2{" +
       "text-align:		center;" +
       "font-size:		3em;" +
       "font-weight:	700;" +
       "color:			#212121;" +
       "font-weight:	400;" +
       "-webkit-font-smoothing: antialiased;" +
       "}" +
       ".conteudo-email  h3{" +
       "text-align:		center;" +
       "font-size:		2.2em;" +
       "color:			#999;" +
       "font-weight:	500;" +
       "}" +
       ".conteudo-email  p{" +
       "text-align:		center;" +
       "font-size:		2.1em;" +
       "color:			#212121;" +
       "}" +
       ".linha-email{" +
       "width:			100%;" +
       "height:			1px;" +
       "background:		#ccc;" +
       "}" +
       ".roda-email{" +
       "width:			100%;" +
       "height:			200px;" +
       "background:		#000;" +
       "}" +
       ".img-roda{" +
       "margin-top: 	-50px;" +
       "}" +

       "/*email- recuperar senha*/" +
       ".topo-senha{" +
       "width:			94%;" +
       "height:			100px;" +
       "background: 	#fff;	" +
       "border-bottom:  1px solid #ededed;" +
       "padding-left:   5%;" +

       "}" +
       ".caixa-senha{" +
       "width:			100%;" +
       "height:			700px;" +
       "background: 	#F9F9F9;" +
       "border-bottom:  1px solid #ededed;" +
       "}" +
       ".caixa-senha-conteudo{" +
       "font-size: 		1.4em;" +
       "font-family: 	'Calibri Light', Calibria,Helvetica;" +
       "line-height: 	1.5em;" +
       "color: 			#333;" +
       "width:			60%;" +
       "margin-left:	15%;" +
       "float:			left;" +
       "}" +
       ".roda-senha{" +
       "width:			100%;" +
       "height:			200px;" +
       "background:		#fff;" +
       "border-bottom:  1px solid #ededed;" +
       "}" +

   ".btnSenha {" +
      "border: 1px solid #00700f;" +
      "background: #029b16;" +
      "background: -webkit-gradient(linear, left top, left bottom, from(#029b16), to(#029b16));" +
      "background: -webkit-linear-gradient(top, #029b16, #029b16);" +
      "background: -moz-linear-gradient(top, #029b16, #029b16);" +
      "background: -ms-linear-gradient(top, #029b16, #029b16);" +
      "background: -o-linear-gradient(top, #029b16, #029b16);" +
      "background-image: -ms-linear-gradient(top, #029b16 0%, #029b16 100%);" +
      "padding: 14.5px 29px;" +
      "-webkit-border-radius: 10px;" +
      "-moz-border-radius: 10px;" +
      "border-radius: 10px;" +
      "-webkit-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;" +
      "-moz-box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;" +
      "box-shadow: rgba(255,255,255,0.4) 0 0px 0, inset rgba(255,255,255,0.4) 0 0px 0;" +
      "text-shadow: #029b16 0 1px 0;" +
      "color: #ffffff;" +
      "font-size: 1.2em;" +
      "font-family: helvetica, serif;" +
      "text-decoration: none;" +
      "vertical-align: middle;" +
      "}" +
   ".btnSenha:hover {" +
     "border: 1px solid #005e0d;" +
     "text-shadow: #029b16 0 1px 0;" +
     "background: #00690e;" +
      "background: -webkit-gradient(linear, left top, left bottom, from(#00700f), to(#00690e));" +
      "background: -webkit-linear-gradient(top, #00700f, #00690e);" +
      "background: -moz-linear-gradient(top, #00700f, #00690e);" +
      "background: -ms-linear-gradient(top, #00700f, #00690e);" +
      "background: -o-linear-gradient(top, #00700f, #00690e);" +
      "background-image: -ms-linear-gradient(top, #00700f 0%, #00690e 100%);" +
      "color: #fff;" +
      "}" +
   ".btnSenha:active {" +
      "text-shadow: #029b16 0 1px 0;" +
      "border: 1px solid #00700f;" +
      "background: #029b16;" +
      "background: -webkit-gradient(linear, left top, left bottom, from(#029b16), to(#029b16));" +
      "background: -webkit-linear-gradient(top, #029b16, #029b16);" +
      "background: -moz-linear-gradient(top, #029b16, #029b16);" +
      "background: -ms-linear-gradient(top, #029b16, #029b16);" +
      "background: -o-linear-gradient(top, #029b16, #029b16);" +
      "background-image: -ms-linear-gradient(top, #029b16 0%, #029b16 100%);" +
      "color: #fff;" +
      "}" +
   "input:focus {" +
     "outline: none;" +
   "}" +
                   "</style>" +
               "</head>" +
               "<body style=\'margin: 0'\">" +
                   "<div class='caixa-email'>" +
                   "<div class='topo-email'></div>" +
                   "<div class='conteudo-email'>" + " <br />" +
                       "<div class='titulo-email'>Monarca</div><br />" +

            //           "<center><picture>"+
            //"<source srcset='cid:computadormonarca2.png' media='(max-width: 799px)'><source srcset='cid:computadormonarca.png'><img srcset='cid:computadormonarca.png' alt='Monarca'>" +
            //"</picture></center>"+
                       "<center><img src=\"cid:" + computadorMN + "\"></center>" +
                    "<h2>Nem todo Rei usa coroa!</h2>" +
                    "<h3>Seja bem vindo ao Monarca.</h3>" +
                    "<div class='linha-email'></div><br />" +
                    "<center> <img src=\"cid:" + rio + "\"> </center>" +
                    //"<center><picture>" +
                    //"<source srcset=@'C:\\images/RioEmail2.png' media='(max-width: 799px)'><source srcset=@'C:\\images/RioEmail.png'><img srcset=@'C:\\images/RioEmail.png' alt='Perfume Rio'>" +
                    //"</picture></center>" +
                        "<h2>Fragâncias inesquecíveis!</h2>" +
                        "<h3>Perfumes de altíssima qualidade.</h3>" +
                    "<div class='linha-email'></div><br />" +
                    "<center><img src=\"cid:" + linha + "\"></center>" +
                    //"<center><picture>" +
                    //"<source srcset=@'C:\\images/linha-email-2.png' media='(max-width: 799px)'><source srcset=@'C:\\images/linha-email-1.png'><img srcset=@'C:\\images/linha-email-1.png' alt='Encore'>" +
                    //"</picture></center>" +
                        "<h2>Exclusividades Monarca!</h2>" +
                        "<h3>Linhas especiais para você.</h3><br />" +
                    "<a href='http://instagram.com/mnperfumes?ref=badge' target='_blank' ><p>Comece Já!</p></a><br /><br />" +
                    "<div class='linha-email'></div>" +

                "</div>" +
                "</div>" +

                "<div  class='roda-email'>" +
                "<center><img class='img-roda' src=\"cid:" + logo + "\"> </center>" +
                     "<br />" +
                      "<center>" +
                            "<a href='http://instagram.com/mnperfumes?ref=badge' target='_blank'><img src=\"cid:" + instagram + "\"></a>" +
                            "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                            "<a href='https://www.facebook.com/mnperfumes' target='_blank'><img src=\"cid:" + facebook + "\"></a>" +
                            "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                            "<a href='https://twitter.com/mnperfumes' target='_blank'><img src=\"cid:" + twitter + "\"></a>" +
                        "</center>" +
                "</div></body> </html>";

        mensagem.Subject = "Seja Bem-Vindo ao Monarca!";

        NetworkCredential credenciais = new NetworkCredential("generico6wa@hotmail.com", "generico3g", "");

        cliente.Credentials = credenciais;

        try
        {
            cliente.Send(mensagem);
            lblResp.Text = "Em breve, você receberá um email de boas-vindas ao Monarca. Fique atento.";
        }
        catch (Exception ex)
        {
            lblErro.Text = ex.ToString();
        }
    }

    protected void lbLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("index.aspx");
    }

   
}

