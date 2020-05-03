using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

using System.Net.Mail; // importe o namespace .Net.Mail
using System.Net.Mime;

public partial class EditarCliente : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            DataView dv;
            dv = (DataView)sqlClienteCadastrado.Select(DataSourceSelectArguments.Empty);

            //mostrar dados do cliente no TextBox
            txtNome.Text = cripto.Decrypt(dv.Table.Rows[0]["nome_cli"].ToString());
            txtEmail.Text = cripto.Decrypt(dv.Table.Rows[0]["email_cli"].ToString());
            txtCPF.Text = cripto.Decrypt(dv.Table.Rows[0]["CPF_cli"].ToString());
            txtRG.Text = cripto.Decrypt(dv.Table.Rows[0]["RG_cli"].ToString());
            ddlSexo.Text = cripto.Decrypt(dv.Table.Rows[0]["sexo_cli"].ToString());


            DateTime dt = Convert.ToDateTime(cripto.Decrypt(dv.Table.Rows[0]["dtNasc_cli"].ToString()));
            txtDataNascimento.Text = dt.ToShortDateString();


            txtNumero.Text = (dv.Table.Rows[0]["num_cli"].ToString());
            txtTel1.Text = cripto.Decrypt(dv.Table.Rows[0]["tel_cli"].ToString());
            txtTel2.Text = cripto.Decrypt(dv.Table.Rows[0]["outroTel_cli"].ToString());
            ddlEstCiv.Text = cripto.Decrypt(dv.Table.Rows[0]["estciv_cli"].ToString());
            txtCEP.Text = cripto.Decrypt(dv.Table.Rows[0]["CEP_cli"].ToString());

            pesquisaCEP();
        }

        if (Session["logado2"] != "Entrar")
            Response.Redirect("LoginFunc.aspx");

    }

    protected void btnEditar_Click(object sender, EventArgs e)
    {
        
        DateTime dt = Convert.ToDateTime(txtDataNascimento.Text);         
        String dataCorreta = dt.ToString("yyyy/MM/dd");

        DateTime dtNascimentoMax = DateTime.Now.AddYears(-18);

        if (dt < dtNascimentoMax)
        {
            lblMaiores18.Text = "";


            //1 - ATUALIZAR DADOS DO CLIENTE

            sqlNovosDados.UpdateParameters["data"].DefaultValue = cripto.Encrypt(dataCorreta);
            sqlNovosDados.UpdateParameters["nome"].DefaultValue = cripto.Encrypt(txtNome.Text);
            sqlNovosDados.UpdateParameters["email"].DefaultValue = cripto.Encrypt(txtEmail.Text);
            sqlNovosDados.UpdateParameters["cpf"].DefaultValue = cripto.Encrypt(txtCPF.Text);
            sqlNovosDados.UpdateParameters["rg"].DefaultValue = cripto.Encrypt(txtRG.Text);
            sqlNovosDados.UpdateParameters["tel1"].DefaultValue = cripto.Encrypt(txtTel1.Text);
            sqlNovosDados.UpdateParameters["tel2"].DefaultValue = cripto.Encrypt(txtTel2.Text);
            sqlNovosDados.UpdateParameters["cep"].DefaultValue = cripto.Encrypt(txtCEP.Text);
            sqlNovosDados.UpdateParameters["comp"].DefaultValue = cripto.Encrypt(txtComplemento.Text);
            sqlNovosDados.Update();

            //2 CONFIRMAR
            Response.Redirect("EditarSucessoFunc.aspx");
        }
        else
        {
            lblMaiores18.Text = "Somente maiores de 18 anos podem se cadastrar no site.";
        }
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        pesquisaCEP();
    }
    public void pesquisaCEP()
    {
        HttpWebRequest requisicao = (HttpWebRequest)WebRequest.Create("http://www.buscacep.correios.com.br/servicos/dnec/consultaLogradouroAction.do?Metodo=listaLogradouro&CEP=" + txtCEP.Text + "&TipoConsulta=cep");
        HttpWebResponse resposta = (HttpWebResponse)requisicao.GetResponse();

        int cont;
        byte[] buffer = new byte[1000];
        StringBuilder sb = new StringBuilder();
        string temp;

        Stream stream = resposta.GetResponseStream();

        do
        {
            cont = stream.Read(buffer, 0, buffer.Length);
            temp = Encoding.Default.GetString(buffer, 0, cont).Trim();
            sb.Append(temp);

        } while (cont > 0);

        string pagina = sb.ToString();

        if (pagina.IndexOf("<font color=\"black\">CEP NAO ENCONTRADO</font>") >= 0)
        {
            lblErro.Text = "CEP NÃO LOCALIZADO.";
            txtRua.Text = "";
            txtBairro.Text = "";
            txtCidade.Text = "";
            txtEstado.Text = "";
            txtNumero.Text = "";
        }

        else
        {
            txtRua.Text = Regex.Match(pagina, "<td width=\"268\" style=\"padding: 2px\">(.*)</td>").Groups[1].Value;
            txtBairro.Text = Regex.Matches(pagina, "<td width=\"140\" style=\"padding: 2px\">(.*)</td>")[0].Groups[1].Value;
            txtCidade.Text = Regex.Matches(pagina, "<td width=\"140\" style=\"padding: 2px\">(.*)</td>")[1].Groups[1].Value;
            txtEstado.Text = Regex.Match(pagina, "<td width=\"25\" style=\"padding: 2px\">(.*)</td>").Groups[1].Value;

            lblErro.Text = "";
        }
    }
}