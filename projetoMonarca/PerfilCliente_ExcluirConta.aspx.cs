using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PerfilCliente_ExcluirConta : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ClienteLogado"] != "Entrar")
        {
            Response.Redirect("PerfilCliente_Entrar.aspx");
        }
    }

    protected void btnEnviarSugestao_Click(object sender, EventArgs e)
    {
        sqlEnviarSugestao.Insert();
        txtSugestao.Text = "";
        lblEnviado.Text = "Sua sugestão foi enviada. Agradecemos seus comentários!";
    }

    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("PerfilCliente_MeusDados.aspx");
    }
    protected void btnExcluirDef_Click(object sender, EventArgs e)
    {
       
        sqlDeletarEnderecosVinculados.Delete();
        //DEIXAR CONTA INATIVA
        sqlContaInativa.Update();
        Session.Abandon();
        Session["ClienteLogado"] = 0;
        Response.Redirect("ContaDeletada.aspx");
    }
}