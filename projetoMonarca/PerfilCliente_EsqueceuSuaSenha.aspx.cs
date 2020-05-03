using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PerfilCliente_EsqueceuSuaSenha : System.Web.UI.Page
{

    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnContinuar_Click(object sender, EventArgs e)
    {
        sqlBuscarDados.SelectParameters["email"].DefaultValue = cripto.Encrypt(txtEmail.Text);
        DataView dv = (DataView)sqlBuscarDados.Select(DataSourceSelectArguments.Empty);

        if (dv.Table.Rows.Count != 0)
        {
            Session["idCliSenha"] = dv.Table.Rows[0]["id_cli"].ToString();
            Session["nomeCliSenha"] = cripto.Decrypt(dv.Table.Rows[0]["nome_cli"].ToString());
            Session["senhaCliSenha"] =  cripto.Decrypt(dv.Table.Rows[0]["senha_cli"].ToString());
            Session["emailCliSenha"] =  cripto.Decrypt(dv.Table.Rows[0]["email_cli"].ToString());

            lblErro.Text = "";

            Response.Redirect("PerfilCliente_PerguntaSecreta.aspx");
        }

        else
        {
            Session["idCliSenha"] = null;
            Session["nomeCliSenha"] = null;
            Session["senhaCliSenha"] = null;
            Session["emailCliSenha"] = null;

            lblErro.Text = "Este email não foi localizado. Tente novamente.";
        }
    }
}