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

public partial class PerfilCliente_Enderecos : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ClienteLogado"] != "Entrar")
        {
            Response.Redirect("PerfilCliente_Entrar.aspx");
        }
        else
        {

            lblSemEnd.Text = "";
            DataView dv = (DataView)sqlEndAdicionais.Select(DataSourceSelectArguments.Empty);
            if (dv.Table.Rows.Count != 0)
            {
                descriptDatalist();
            }
            else
            {
                DataList1.Visible = false;
                lblSemEnd.Text = "Você não possui nenhum endereço. Cadastre novos!";
            }
        }
    }
    public void descriptDatalist()
    {
         
        DataView dv = (DataView)sqlEndAdicionais.Select(DataSourceSelectArguments.Empty);

        DataTable newTB = new DataTable();

        newTB = dv.Table.Clone();

        //string pesq, pesq2;
        //pesq = txtarea.Text;
        //pesq2 = ddlestado.Text;
        // newTB.DefaultView.RowFilter = "nome_prod like '" + Session["pesquisa"].ToString() + "%'";
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            DataRow linha = newTB.NewRow();
            linha["nome_end"] = cripto.Decrypt(dv.Table.Rows[i]["nome_end"].ToString());
            linha["CEP_cli"] = cripto.Decrypt(dv.Table.Rows[i]["CEP_cli"].ToString());
            linha["cidade_end"] = cripto.Decrypt(dv.Table.Rows[i]["cidade_end"].ToString());
            linha["rua_end"] = cripto.Decrypt(dv.Table.Rows[i]["rua_end"].ToString());
            linha["estado_end"] = cripto.Decrypt(dv.Table.Rows[i]["estado_end"].ToString());
            linha["id_end"] = dv.Table.Rows[i]["id_end"].ToString();

            newTB.Rows.Add(linha);
        }

        DataList1.DataSource = newTB;
        DataList1.DataBind();

    }

    protected void btnNovoEnd_Click(object sender, EventArgs e)
    {
        Response.Redirect("PerfilCliente_EndAdicional.aspx");
    }

    protected void btnEditar_Click(object sender, EventArgs e)
    {
        /// NÃO ESTA FUNCIONANDO

        var btn = (Button)sender;
        var row = (DataListItem)btn.NamingContainer;
        int id = Convert.ToInt32(((Label)row.FindControl("lblID")).Text);

        Session["id"] = id;
        Response.Redirect("PerfilCliente_EditarEnd.aspx?id=" + id);
    }
    protected void lbExcluir_Click1(object sender, EventArgs e)
    {
        var lbl = (LinkButton)sender;
        var row = (DataListItem)lbl.NamingContainer;
        int id = Convert.ToInt32(((Label)row.FindControl("lblID")).Text);

        Session["endExcluir"] = id;
        sqlEndAdicionais.Delete();
        lblSemEnd.Text = "";

        DataView dv = (DataView)sqlEndAdicionais.Select(DataSourceSelectArguments.Empty);
        if (dv.Table.Rows.Count != 0)
        {
            descriptDatalist();
        }
        else
        {
            DataList1.Visible = false;
            lblSemEnd.Text = "Você não possui nenhum endereço. Cadastre novos!";
        }
        //Response.Redirect("Ver Candidato.aspx?id=" + id);
    }
}