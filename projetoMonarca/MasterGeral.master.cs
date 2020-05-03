using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class MasterGeral : System.Web.UI.MasterPage
{
    Criptografia cripto = new Criptografia("@@Monarca123");
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
      
        Session.Clear();
        Session.RemoveAll();
        Session.Abandon();
        lbLogout.Visible = false;
        Response.Redirect("index.aspx");

    }

    private void txtbusca_Enter(object sender, EventArgs e)
    {
        Session["pesquisa"] = cripto.Encrypt(txtbusca.Text);
        Response.Redirect("ResultadoPesquisa.aspx");
    }






}
