using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class EsqueceuSuaSenhaADM : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnContinuar_Click(object sender, EventArgs e)
    {
        DataView dv = (DataView)sqlBuscarDadosADM.Select(DataSourceSelectArguments.Empty);

        if (dv.Table.Rows.Count != 0)
        {
            Session["idADMSenha"] = dv.Table.Rows[0]["id_adm"].ToString();
            Session["senhaADMSenha"] = dv.Table.Rows[0]["senha_adm"].ToString();
            Session["emailADMSenha"] = dv.Table.Rows[0]["email_adm"].ToString();

            lblErro.Text = "";

            Response.Redirect("RecuperarSenhaADM.aspx");
        }

        else
        {
            Session["idADMSenha"] = null;
            Session["senhaADMSenha"] = null;
            Session["emailADMSenha"] = null;

            lblErro.Text = "Este email não foi localizado. Tente novamente.";
        }
    }
}