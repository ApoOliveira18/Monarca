using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net; // importe o namespace .Net
using System.Net.Mail; // importe o namespace .Net.Mail
using System.IO;
using System.Net.Mime;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnEnviar_Click(object sender, EventArgs e)
    {
        // criando um servidor smtp do tipo HOTMAIL para
        // usarmos o email generico6wa
        SmtpClient cliente = new SmtpClient("smtp.live.com");
        cliente.EnableSsl = true;

        // email do remetente -> quem está enviando
        MailAddress remetente = new MailAddress(txtEmailRemetente.Text, txtNomeRemetente.Text);

        // email do destinatario -> quem irá receber
        MailAddress destinatario = new MailAddress("monarcaperfumes@gmail.com", "Equipe Monarca");

        // criando a mensagem
        MailMessage mensagem = new MailMessage(remetente, destinatario);

        // criando conteúdo da mensagem
        mensagem.Body = "Nome do Usuário: " + txtNomeRemetente.Text + "\r\n" +
            "Email do Usuário: " + txtEmailRemetente.Text + "\r\n" +
            "Assunto da Mensagem: " + txtAssunto.Text + "\r\n" +
            "Mensagem do Usuário: " + txtMensagem.Text;
        // conteúdo
        mensagem.Subject = "SAC Monarca - Nova Mensagem"; // assunto


        // Recupera o binario enviado pelo FileUpload
        MemoryStream MS = new MemoryStream(arquivosAnexo.FileBytes);

        // cria o anexo do email
        Attachment anexado = new Attachment(MS, arquivosAnexo.FileName);

        // anexa o arquivo a mensagem
        mensagem.Attachments.Add(anexado);


        // criar um email no HOTMAIL para ser o gerenciador de envio de email´s
        // aqui precisa do email completo e da senha
        NetworkCredential credenciais = new NetworkCredential("generico6wa@hotmail.com", "generico3g", "");

        cliente.Credentials = credenciais;

        try
        {
            cliente.Send(mensagem);
            lblResp.Text = "Seu email foi enviado com sucesso. Aguarde contato.";
        }
        catch (Exception ex)
        {
            lblResp.Text = ex.ToString();
        }
    }
}