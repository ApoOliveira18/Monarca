using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class registrosFunc : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");
        descripto();
    }
    public void descripto()
    {
        DataView dv = (DataView)sqlRegistros.Select(DataSourceSelectArguments.Empty);

        DataTable novaTB = new DataTable();

        novaTB.Columns.Add("id_registrosFunc", typeof(int));
        novaTB.Columns.Add("id_func", typeof(int));
        novaTB.Columns.Add("registro", typeof(string));
        novaTB.Columns.Add("data_registro", typeof(string));
        novaTB.Columns.Add("nome_prod", typeof(string));

        ///////
        // novaTB.DefaultView.RowFilter = "nome_aluno like '" + txtFiltro.Text + "%'";

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {


            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_registrosFunc"] = dv.Table.Rows[i]["id_registrosFunc"].ToString();
            linha["id_func"] = dv.Table.Rows[i]["id_func"].ToString();
            linha["registro"] = cripto.Decrypt(dv.Table.Rows[i]["registro"].ToString());

            DateTime dtCadastro = Convert.ToDateTime(dv.Table.Rows[i]["data_registro"].ToString());
            String dtCadastroCerto = dtCadastro.ToString("dd/MM/yyyy");
            linha["data_registro"] = dtCadastroCerto;
            linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());


            novaTB.Rows.Add(linha);
        }


        GridView1.DataSource = novaTB;
        GridView1.DataBind();
    }
}