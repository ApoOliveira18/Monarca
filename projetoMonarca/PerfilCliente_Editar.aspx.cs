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

public partial class _Default : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ClienteLogado"] != "Entrar")
        {
            Response.Redirect("PerfilCliente_Entrar.aspx");
        }

        if (IsPostBack == false)
        {
            DataView dv;
            dv = (DataView)sqlBusca.Select(DataSourceSelectArguments.Empty);

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


            txtLogin.Text = cripto.Decrypt(dv.Table.Rows[0]["login_cli"].ToString());
            txtPergunta.Text = cripto.Decrypt(dv.Table.Rows[0]["perg_cli"].ToString());
            txtResposta.Text = cripto.Decrypt(dv.Table.Rows[0]["resp_cli"].ToString());
            pesquisaCEP();
            pesquisarEstadoCivil();
            pesquisaSexo();
        }
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
    public void pesquisaSexo()
    {
        if (ddlSexo.SelectedIndex == 1)
        {
            Session["sexo"] = cripto.Encrypt("Masculino");
        }

        if (ddlSexo.SelectedIndex == 2)
        {
            Session["sexo"] = cripto.Encrypt("Feminino");
        }
    }

    public void pesquisarEstadoCivil()
    {
        if (ddlEstCiv.SelectedIndex == 1)
        {
            Session["estciv"] = cripto.Encrypt("Casado");
        }

        if (ddlEstCiv.SelectedIndex == 2)
        {
            Session["estciv"] = cripto.Encrypt("Solteiro");
        }

        if (ddlEstCiv.SelectedIndex == 3)
        {
            Session["estciv"] = cripto.Encrypt("Divorciado");
        }

        if (ddlEstCiv.SelectedIndex == 4)
        {
            Session["estciv"] = cripto.Encrypt("Viúvo");
        }   
    }

    protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
    {
        pesquisaSexo();
    }

    protected void ddlEstCiv_SelectedIndexChanged(object sender, EventArgs e)
    {
        pesquisarEstadoCivil();
    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        pesquisaCEP();
    }

    protected void btnSair_Click(object sender, EventArgs e)
    {
        Response.Redirect("index.aspx");
    }

    protected void lbEsqueceuSuaSenha_Click(object sender, EventArgs e)
    {
        Response.Redirect("RecuperarSenha.aspx");
    }

    protected void txtLogin_TextChanged(object sender, EventArgs e)
    {
        sqlVerificarUsuarioEscolhido.SelectParameters["usu_escolhido"].DefaultValue = cripto.Encrypt(txtLogin.Text);
        DataView dv = (DataView)sqlVerificarUsuarioEscolhido.Select(DataSourceSelectArguments.Empty);

        if (dv.Table.Rows.Count != 0) //usuário (1) já existe
        {
            lblUsuarioJaExiste.Text = "Este nome de usuário já existe. Por favor, escolha outro.";
            Session["loginOK"] = "Falhou";
        }

        else
        {
            lblUsuarioJaExiste.Text = "";
            Session["loginOK"] = null;
        }
    }

    protected void txtEmail_TextChanged(object sender, EventArgs e)
    {
        sqlVerificarEmailEscolhido.SelectParameters["email_escolhido"].DefaultValue = cripto.Encrypt(txtEmail.Text);           
        DataView dv2 = (DataView)sqlVerificarEmailEscolhido.Select(DataSourceSelectArguments.Empty);

        if (dv2.Table.Rows.Count != 0) //e-mail (2) já existe
        {
            lblEmailJaCadastrado.Text = "Já existe um cadastro com este e-mail.";
            Session["emailOK"] = "Falhou";
        }

        else
        {
            lblEmailJaCadastrado.Text = "";
            Session["emailOK"] = null;
        }
    }

    protected void txtCPF_TextChanged(object sender, EventArgs e)
    {
        sqlVerificarCPFInserido.SelectParameters["cpf_inserido"].DefaultValue = cripto.Encrypt(txtCPF.Text);
        DataView dv3 = (DataView)sqlVerificarCPFInserido.Select(DataSourceSelectArguments.Empty);

        if (dv3.Table.Rows.Count != 0)
        {
            lblCPFUsado.Text = "Este CPF já está sendo usado.";
            Session["cpfOK"] = "Falhou";
        }

        else
        {
            lblCPFUsado.Text = "";
            Session["cpfOK"] = null;
        }
    }

    protected void txtRG_TextChanged(object sender, EventArgs e)
    {
        if (txtRG.Text != null)
        {
            sqlVerificarRGInserido.SelectParameters["rg_inserido"].DefaultValue = cripto.Encrypt(txtRG.Text);
            DataView dv4 = (DataView)sqlVerificarRGInserido.Select(DataSourceSelectArguments.Empty);

            if (dv4.Table.Rows.Count != 0)
            {
                lblRGUsado.Text = "Este RG já está sendo usado.";
                Session["rgOK"] = "Falhou";
            }

            else
            {
                Session["rgOK"] = null;
                lblRGUsado.Text = "";
            }
        }

        else
        {
            Session["rgOK"] = null;
        }
    }

    protected void tnEditar_Click(object sender, EventArgs e)
    {
        if (Session["loginOK"] == null && Session["emailOK"] == null && Session["cpfOK"] == null && Session["rgOK"] == null)
        {
            lblUsuarioJaExiste.Text = "";
            lblEmailJaCadastrado.Text = "";
            lblCPFUsado.Text = "";
            lblRGUsado.Text = "";

            DateTime dt = Convert.ToDateTime(txtDataNascimento.Text);
            String dataCorreta = dt.ToString("yyyy/MM/dd");

            DateTime dtNascimentoMax = DateTime.Now.AddYears(-18);

            if (dt < dtNascimentoMax)
            {
                lblMaiores18.Text = "";

                sqlNovosDados.UpdateParameters["datanasc"].DefaultValue = cripto.Encrypt(dataCorreta);
                sqlNovosDados.UpdateParameters["nome"].DefaultValue = cripto.Encrypt(txtNome.Text);
                sqlNovosDados.UpdateParameters["cep"].DefaultValue = cripto.Encrypt(txtCEP.Text);
                sqlNovosDados.UpdateParameters["cpf"].DefaultValue = cripto.Encrypt(txtCPF.Text);
                sqlNovosDados.UpdateParameters["tel1"].DefaultValue = cripto.Encrypt(txtTel1.Text);
                sqlNovosDados.UpdateParameters["tel2"].DefaultValue = cripto.Encrypt(txtTel2.Text);
                sqlNovosDados.UpdateParameters["email"].DefaultValue = cripto.Encrypt(txtEmail.Text);
                sqlNovosDados.UpdateParameters["rg"].DefaultValue = cripto.Encrypt(txtRG.Text);
                sqlNovosDados.UpdateParameters["login"].DefaultValue = cripto.Encrypt(txtLogin.Text);
                sqlNovosDados.UpdateParameters["complemento"].DefaultValue = cripto.Encrypt(txtComplemento.Text);
                sqlNovosDados.UpdateParameters["pergunta"].DefaultValue = cripto.Encrypt(txtPergunta.Text);
                sqlNovosDados.UpdateParameters["resposta"].DefaultValue = cripto.Encrypt(txtResposta.Text);

                sqlNovosDados.UpdateParameters["sexo"].DefaultValue = Session["sexo"].ToString();
                sqlNovosDados.UpdateParameters["estciv"].DefaultValue = Session["estciv"].ToString();              
                sqlNovosDados.Update();

                Session["loginOK"] = 0;
                Session["emailOK"] = 0;
                Session["cpfOK"] = 0;
                Session["rgOK"] = 0;
                Session["sexo"] = null;
                Session["estciv"] = null;

                Response.Redirect("PerfilCliente_MeusDados.aspx");
            }

            else
            {
                lblMaiores18.Text = "Data inválida: somente maiores de 18 anos podem utilizar o site.";
            }
        }
    }
}