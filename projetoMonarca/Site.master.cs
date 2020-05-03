using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        carrinho.Style.Add("display", "none");


        if (Session["ClienteLogado"] == "Entrar")
        {
            lbLogout.Visible = true;
            
            DataView dv = (DataView)sqlCarrinho.Select(DataSourceSelectArguments.Empty);
            if (dv.Table.Rows.Count != 0)
            {
                carrinho.Style.Add("display", "");
            }
        }

        else
        {
            lbLogout.Visible = false;
        }   

    }

    protected void lbLogout_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        lbLogout.Visible = false;
        Response.Redirect("index.aspx");
    }
  

    protected void txtbusca_TextChanged1(object sender, EventArgs e)
    {
        Session["pesquisa"] = txtbusca.Text;
        Response.Redirect("ResultadoPesquisa.aspx");
    }
}
