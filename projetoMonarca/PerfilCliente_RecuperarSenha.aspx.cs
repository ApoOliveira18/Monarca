﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net; // importe o namespace .Net
using System.Net.Mail; // importe o namespace .Net.Mail

public partial class PerfilCliente_RecuperarSenha : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        string newPass;
        newPass = GenerateRandomCode();

        //mudar para a senha padrão
        DateTime dtAlt = DateTime.Today;
        String dataSenha = dtAlt.ToString("yyyy/MM/dd");

        sqlResetarSenha.UpdateParameters["data_alt"].DefaultValue = dataSenha;
        sqlResetarSenha.UpdateParameters["senha"].DefaultValue = cripto.Encrypt(newPass.ToString());
        sqlResetarSenha.Update();

        Session["novaSenhaCliSenha"] = newPass.ToString();

        SmtpClient cliente = new SmtpClient("smtp.live.com");
        cliente.EnableSsl = true;

        MailAddress remetente = new MailAddress("monarcaperfumes@gmail.com", "Monarca Perfumes Ltda.");
        MailAddress destinatario = new MailAddress(Session["emailCliSenha"].ToString(), Session["nomeCliSenha"].ToString());
        MailMessage mensagem = new MailMessage(remetente, destinatario);

        mensagem.Body = "Olá, " + Session["nomeCliSenha"].ToString() + "!"
                        + "\r\n" + ""
                        + "Sua senha foi alterada, conforme pedido enviado para nosso site. Agora, sua senha é <b>" + Session["novaSenhaCliSenha"].ToString() + "</b>."
                        + "\r\n" + "Lembramos que essa é uma senha temporária. Entre em sua conta <b>imediatamente</b> e atualize sua senha."
                        + "\r\n" + ""
                        + "Atenciosamente,"
                        + "\r\n" + "Monarca Perfumes Ltda.";
        mensagem.IsBodyHtml = true;
        mensagem.Subject = "Recuperação de Senha";

        NetworkCredential credenciais = new NetworkCredential("generico6wa@hotmail.com", "generico3g", "");

        cliente.Credentials = credenciais;

        try
        {
            cliente.Send(mensagem);
            lblSucesso.Text = "Enviamos um email para você, com instruções para recuperar sua senha.";
        }
        catch (Exception ex)
        {
            lblSucesso.Text = ex.ToString();
        }
    }

    private string GenerateRandomCode()
    {
        Random r = new Random();
        string s = "";

        for (int j = 0; j < 8; j++)
        {
            int i = r.Next(3);
            int ch;

            switch (i)
            {
                case 1:
                    ch = r.Next(0, 9);
                    s = s + ch.ToString();
                    break;

                case 2:
                    ch = r.Next(65, 90);
                    s = s + Convert.ToChar(ch).ToString();
                    break;

                case 3:
                    ch = r.Next(97, 122);
                    s = s + Convert.ToChar(ch).ToString();
                    break;

                default:
                    ch = r.Next(97, 122);
                    s = s + Convert.ToChar(ch).ToString();
                    break;
            }

            r.NextDouble();
            r.Next(100, 1999);
        }

        return s;
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("PerfilCliente_Entrar.aspx");
    }
}