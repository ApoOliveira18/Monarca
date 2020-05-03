using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Net; // importe o namespace .Net
using System.Net.Mail; // importe o namespace .Net.Mail

public partial class _Default : System.Web.UI.Page
{
    int qtdErros;
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblErro.Text = "";
            txtimgcode.Text = "";
            captcha.Style.Add("display", "none");
            Session["qtdErros"] = null;
        }
    }

       protected void btnEditar_Click(object sender, EventArgs e)
    {
        clickEntrar();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("CadastroCliente.aspx");
    }

     protected void btnEditarApos3Erros_Click(object sender, EventArgs e)
    {
        clickEntrar();
        if (txtimgcode.Text == Session["CaptchaImageText"].ToString())
        {
            Session["qtdErros"] = null;
            Response.Redirect("PerfilCliente_EsqueceuSuaSenha.aspx");
        }
        else
        {
            captcha.Style.Add("display", "");
            lblmsg.Text = "Mensagem incorreta!";
            lblErro.Text = "";

        }
        txtimgcode.Text = "";
    }

    public void clickEntrar() {

        lblmsg.Text = "";

        //CONTA DEVE ESTAR ATIVA PARA ENTRAR >> STATUS=0 
        sqlLogin.SelectParameters["login"].DefaultValue = cripto.Encrypt(txtLogin.Text);
        sqlLogin.SelectParameters["senha"].DefaultValue = cripto.Encrypt(txtSenha.Text);
        DataView dv = (DataView)sqlLogin.Select(DataSourceSelectArguments.Empty);

        //análise do login
        if (dv.Table.Rows.Count == 0)
        {
            lblErro.Text = "Login e/ou Senha não conferem.";
            captcha.Style.Add("display", "none");


            // somando a qtd de erros
            if (Session["qtdErros"] != null)
            {
                qtdErros = (int)Session["qtdErros"];
            }
            qtdErros++;
            Session["qtdErros"] = qtdErros;

            if (qtdErros >= 3)
            {
                btnRecuperar.Visible = true;
                captcha.Style.Add("display", "");
                btnEditar.Visible = false;
                btnEditarApos3Erros.Visible = true;
            }
        }

        else
        {
           
            if (btnEditarApos3Erros.Visible == true)
            {
                captcha.Style.Add("display", "");

                if (txtimgcode.Text != "")
                {
                    login();

                }
            }
            else
            {
                login();
            }
          
        }
    }

    public void login()
    {

        DataView dv = (DataView)sqlLogin.Select(DataSourceSelectArguments.Empty);
        Session["idClienteSenha"] = dv.Table.Rows[0]["id_cli"].ToString();

        Session["idCliente"] = dv.Table.Rows[0]["id_cli"].ToString();
        Session["novaCompra"] = "Sim"; // Session para verif nova venda ou a mesma

       
        //verificar validade da senha
        DataView dv3 = (DataView)sqlDataCliente.Select(DataSourceSelectArguments.Empty);

        Session["nomeCliente"] = cripto.Decrypt(dv3.Table.Rows[0]["nome_cli"].ToString());
        Session["emailCliente"] = cripto.Decrypt(dv3.Table.Rows[0]["email_cli"].ToString());
        DateTime dt = Convert.ToDateTime(dv3.Table.Rows[0]["data_conta"].ToString());
        DateTime dtMax = dt.AddMonths(+6);

        DateTime hoje = DateTime.Now;
        if (hoje >= dtMax)
        {
            string newPass;
            newPass = GenerateRandomCode();

            //mudar para a senha padrão
            DateTime dtAlt = DateTime.Today;
            String dataSenha = dtAlt.ToString("yyyy/MM/dd");

            sqlResetarSenha.UpdateParameters["data_alt"].DefaultValue = dataSenha;
            sqlResetarSenha.UpdateParameters["senha"].DefaultValue =  cripto.Encrypt(newPass.ToString());
            sqlResetarSenha.Update();

            Session["novaSenhaCliente"] = newPass.ToString();

            SmtpClient cliente = new SmtpClient("smtp.live.com");
            cliente.EnableSsl = true;

            // email do remetente -> quem está enviando
            MailAddress remetente = new MailAddress("monarcaperfumes@gmail.com", "Monarca Perfumes Ltda.");

            // email do destinatario -> quem irá receber
            MailAddress destinatario = new MailAddress
                (Session["emailCliente"].ToString(), Session["nomeCliente"].ToString());

            MailMessage mensagem = new MailMessage(remetente, destinatario);

            mensagem.Body = "Olá!" + Session["nomeCliente"].ToString()
                            + "\r\n" + ""
                            + "O prazo de validade de 6 meses de sua senha expirou. Agora, sua senha é <b>" + Session["novaSenhaCliente"].ToString() + "</b>."
                            + "\r\n" + "Lembramos que essa é uma senha temporária. Entre em sua conta <b>imediatamente</b> e atualize sua senha."
                            + "\r\n" + ""
                            + "Atenciosamente,"
                            + "\r\n" + "Monarca Perfumes Ltda.";
            mensagem.IsBodyHtml = true;
            mensagem.Subject = "Comunicado: Senha Expirada";

            NetworkCredential credenciais = new NetworkCredential("generico6wa@hotmail.com", "generico3g", "");

            cliente.Credentials = credenciais;

            try
            {
                cliente.Send(mensagem);
                lblErro.Text = "Sua senha atual expirou. Uma nova senha foi enviada para seu email.";
            }
            catch (Exception ex)
            {
                lblErro.Text = ex.ToString();
            }
        }

        else
        {


            btnRecuperar.Visible = false;
            Session["qtdErros"] = null;
            captcha.Style.Add("display", "none");

            CheckBox chkLogado = chkManterLogado;

            if (chkLogado.Checked == true)
            {
                Session["cliRecente"] = txtLogin.Text;

                DataView dv2 = (DataView)sqlManterLogado.Select(DataSourceSelectArguments.Empty);

                if (dv2.Table.Rows.Count != 0)
                {
                    sqlAtualizarRecente.Update();
                }

                else
                {
                    sqlSalvarRecente.Insert();
                }
            }

            else
            {
                Session["cliRecente"] = null;
                sqlApagarRecente.Delete();
            }

            lblErro.Text = "";
            Session["ClienteLogado"] = "Entrar";
            Session["idCliente"] = dv.Table.Rows[0]["id_cli"].ToString();
            Session["novaCompra"] = "Sim"; // Session para verif nova venda ou a mesma
            Response.Redirect("produto.aspx");

        }
    }

    protected void btnCadastro_Click(object sender, EventArgs e)
    {
        Response.Redirect("CadastroCliente.aspx");
    }

    protected void lbEsqueceuSuaSenha_Click(object sender, EventArgs e)
    {
        Response.Redirect("PerfilCliente_EsqueceuSuaSenha.aspx");
    }
    protected void btnRecuperar_Click(object sender, EventArgs e)
    {
        if (txtimgcode.Text == Session["CaptchaImageText"].ToString())
        {
            Session["qtdErros"] = null;
            Response.Redirect("PerfilCliente_EsqueceuSuaSenha.aspx");
        }
        else
        {
            captcha.Style.Add("display", "");
            lblmsg.Text = "Mensagem incorreta!";

        }
        txtimgcode.Text = "";
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
}



