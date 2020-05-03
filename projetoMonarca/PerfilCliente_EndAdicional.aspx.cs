using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

using System.Net.Mail; // importe o namespace .Net.Mail
using System.Net.Mime;

public partial class PerfilCliente_EndAdicional : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ClienteLogado"] != "Entrar")
        {
            Response.Redirect("PerfilCliente_Entrar.aspx");
        }

    }
    public void PesquisaCEP()
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
    protected void btnOK_Click(object sender, EventArgs e)
    {
        PesquisaCEP();   
    }
    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        if (Session["sacola"] == "sim")
        {
            Session["sacola"] = "";
            Response.Redirect("Compra.aspx");
        }
        else
        {
            Response.Redirect("PerfilCliente_MeusDados.aspx");
        }
    }
    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        sqlInserirEndAdicional.InsertParameters["nome"].DefaultValue = cripto.Encrypt(txtNome.Text);
        sqlInserirEndAdicional.InsertParameters["compl"].DefaultValue = cripto.Encrypt(txtComplemento.Text);
        sqlInserirEndAdicional.InsertParameters["cep"].DefaultValue = cripto.Encrypt(txtCEP.Text);
        sqlInserirEndAdicional.InsertParameters["cidade"].DefaultValue = cripto.Encrypt(txtCidade.Text);
        sqlInserirEndAdicional.InsertParameters["rua"].DefaultValue = cripto.Encrypt(txtRua.Text);
        sqlInserirEndAdicional.InsertParameters["estado"].DefaultValue = cripto.Encrypt(txtEstado.Text);


        sqlInserirEndAdicional.Insert();


        if (Session["sacola"] == "sim")
        {
            Session["sacola"] = "";
            Response.Redirect("Compra.aspx");
        }
        else
        {
            Response.Redirect("PerfilCliente_Enderecos.aspx");
        }

    }
}