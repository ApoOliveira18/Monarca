using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PesquisaMasterPageADM : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] == "Entrar")
        {
            lbLogout.Visible = true;
        }

        else
        {
            lbLogout.Visible = false;
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        lbLogout.Visible = false;
        Response.Redirect("LoginADM.aspx");
    }
}
