using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PerfilCliente_PerguntaSecreta : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        DataView dv2 = (DataView)sqlBuscarPergunta.Select(DataSourceSelectArguments.Empty);

        lblPergBanco.Text = cripto.Decrypt(dv2.Table.Rows[0]["perg_cli"].ToString());
        Session["pergCliSenha"] = cripto.Encrypt(lblPergBanco.Text);
    }

    protected void btnVerificarPerg_Click(object sender, EventArgs e)
    {
        sqlChecarRespSecreta.SelectParameters["resp_cli"].DefaultValue = cripto.Encrypt(txtResposta.Text);
        DataView dv3 = (DataView)sqlChecarRespSecreta.Select(DataSourceSelectArguments.Empty);

        if (dv3.Table.Rows.Count != 0)
        {
            lblErroPerg.Text = "";
            Response.Redirect("PerfilCliente_RecuperarSenha.aspx");
        }

        else
        {
            lblErroPerg.Text = "Resposta Inválida.";
        }
    }
}