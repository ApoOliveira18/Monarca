using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class EsqueceuSuaSenhaFunc : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnContinuar_Click(object sender, EventArgs e)
    {
        DataView dv = (DataView)sqlBuscarDadosFunc.Select(DataSourceSelectArguments.Empty);

        if (dv.Table.Rows.Count != 0)
        {
            Session["idFuncSenha"] = dv.Table.Rows[0]["id_func"].ToString();
            Session["senhaFuncSenha"] = dv.Table.Rows[0]["senha_func"].ToString();
            Session["emailFuncSenha"] = dv.Table.Rows[0]["email_func"].ToString();

            lblErro.Text = "";

            Response.Redirect("RecuperarSenhaFunc.aspx");
        }

        else
        {
            Session["idFuncSenha"] = null;
            Session["senhaFuncSenha"] = null;
            Session["emailFuncSenha"] = null;

            lblErro.Text = "Este email não foi localizado. Tente novamente.";
        }
    }
}