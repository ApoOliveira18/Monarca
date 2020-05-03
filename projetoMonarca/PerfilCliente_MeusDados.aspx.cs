using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ClienteLogado"] != "Entrar")
        {
            Response.Redirect("PerfilCliente_Entrar.aspx");
        }

        DataView dv;
        dv = (DataView)sqlBusca.Select(DataSourceSelectArguments.Empty);

        //mostrar dados do cliente no TextBox
        lblNome.Text = cripto.Decrypt(dv.Table.Rows[0]["nome_cli"].ToString());
        lblEnd.Text = cripto.Decrypt(dv.Table.Rows[0]["email_cli"].ToString());
        lblCPF.Text = cripto.Decrypt(dv.Table.Rows[0]["CPF_cli"].ToString());
        lblCEP.Text = cripto.Decrypt(dv.Table.Rows[0]["CEP_cli"].ToString());

        DateTime dt = Convert.ToDateTime(cripto.Decrypt(dv.Table.Rows[0]["dtNasc_cli"].ToString()));
        lblData.Text = dt.ToShortDateString();

        lblTel.Text = cripto.Decrypt(dv.Table.Rows[0]["tel_cli"].ToString());
    }

    protected void tnEditar_Click(object sender, EventArgs e)
    {
        Response.Redirect("PerfilCliente_Editar.aspx");
    }

    protected void btnSair_Click(object sender, EventArgs e)
    {
        Response.Redirect("index.aspx");
    }

    protected void lbDeletarConta_Click(object sender, EventArgs e)
    {
        Response.Redirect("PerfilCliente_ExcluirConta.aspx");
    }
}