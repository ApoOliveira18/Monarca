using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class registrosADM : System.Web.UI.Page
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

        novaTB.Columns.Add("id_registros", typeof(int));
        novaTB.Columns.Add("id_adm", typeof(int));
        novaTB.Columns.Add("registro", typeof(string));
        novaTB.Columns.Add("data_registro", typeof(string));
        novaTB.Columns.Add("login_adm", typeof(string));
        novaTB.Columns.Add("login_cliente", typeof(string));
        novaTB.Columns.Add("login_func", typeof(string));
        novaTB.Columns.Add("nome_prod", typeof(string));
        novaTB.Columns.Add("desc_ml", typeof(string));
        novaTB.Columns.Add("tipo_promo", typeof(string));
        novaTB.Columns.Add("tipo_linha", typeof(string));
        novaTB.Columns.Add("tipo_genero", typeof(string));

        ///////
       // novaTB.DefaultView.RowFilter = "nome_aluno like '" + txtFiltro.Text + "%'";

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {


                DataRow linha = novaTB.NewRow();

                // 2. descriptografar
                linha["id_registros"] = dv.Table.Rows[i]["id_registros"].ToString();
                linha["id_adm"] = dv.Table.Rows[i]["id_adm"].ToString();
                linha["registro"] = cripto.Decrypt(dv.Table.Rows[i]["registro"].ToString());

                DateTime dtCadastro = Convert.ToDateTime(dv.Table.Rows[i]["data_registro"].ToString());
                String dtCadastroCerto = dtCadastro.ToString("dd/MM/yyyy");
                linha["data_registro"] = dtCadastroCerto;

                linha["login_adm"] = cripto.Decrypt(dv.Table.Rows[i]["login_adm"].ToString());
                linha["login_cliente"] = cripto.Decrypt(dv.Table.Rows[i]["login_cliente"].ToString());
                linha["login_func"] = cripto.Decrypt(dv.Table.Rows[i]["login_func"].ToString());
                linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());
                linha["desc_ml"] = cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString());
                linha["tipo_promo"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_promo"].ToString());
                linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
                linha["tipo_genero"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString());


            novaTB.Rows.Add(linha);
        }


        GridView1.DataSource = novaTB;
        GridView1.DataBind();
    }
}