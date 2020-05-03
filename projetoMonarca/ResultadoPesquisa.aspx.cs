using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MySql.Data.MySqlClient;

public partial class ResultadoPesquisa : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");

    String conexaoMySQL = "";
    MySqlConnection conectar = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        //conexaoMySQL = "server=127.0.0.1;User Id=root;password=ALUNOS;database=monarca;";

       // if (!IsPostBack)
        //{    
            //Paginacao("");
       // }
       // descriptoAlunos();
    }

    public void descriptoAlunos()
    {
        sqlPesquisaProduto.SelectParameters["pesquisa"].DefaultValue = Session["pesquisa"].ToString();
        DataView dv = (DataView)sqlPesquisaProduto.Select(DataSourceSelectArguments.Empty);

        DataTable novaTB = new DataTable();

        //DESCRIPTOGRAFAR
        novaTB.Columns.Add("id_prod", typeof(string));
        novaTB.Columns.Add("img_prod", typeof(string));
        novaTB.Columns.Add("nome_prod", typeof(string));
        novaTB.Columns.Add("tipo_genero", typeof(string));
        novaTB.Columns.Add("tipo_linha", typeof(string));
        novaTB.Columns.Add("valor_prod_final", typeof(string));
        novaTB.DefaultView.RowFilter = "nome_prod like '" + Session["pesquisa"].ToString() + "%'";


        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {

            DataRow linha = novaTB.NewRow();
            linha["id_prod"] = dv.Table.Rows[i]["id_prod"].ToString();
            linha["img_prod"] = cripto.Decrypt(dv.Table.Rows[i]["img_prod"].ToString());
            linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());
            linha["tipo_genero"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString());
            linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
            linha["valor_prod_final"] = "R$ " + cripto.Decrypt(dv.Table.Rows[i]["valor_prod_final"].ToString());
            novaTB.Rows.Add(linha);           
        }


        DataList1.DataSource = novaTB;
        DataList1.DataBind();
        lblQtdResultados.Text = novaTB.DefaultView.Count.ToString();
       
    }
    //protected void Paginacao(string tipo)
    //{
    //    int tamanhoPagina = 3;
    //    int registroInicio = 0;

    //    if (ViewState["registroInicio"] != null)
    //    {
    //        registroInicio = (int)ViewState["registroInicio"];
    //    }
    //    if (tipo == "Proximo")
    //    {
    //        registroInicio += tamanhoPagina;
    //    }
    //    else if (tipo == "Anterior" && registroInicio > 0)
    //    {
    //        registroInicio -= tamanhoPagina;
    //    }
  
        
    //    string sql = "select * from produto INNER JOIN linha ON produto.id_linha = linha.id_linha INNER JOIN genero ON produto.id_genero = genero.id_genero";
    //    sqlPesquisaProduto.SelectParameters["pesquisa"].DefaultValue = Session["pesquisa"].ToString();
    //    DataView dv = (DataView)sqlPesquisaProduto.Select(DataSourceSelectArguments.Empty);

    //    DataTable novaTB = new DataTable();

    //    //DESCRIPTOGRAFAR
    //    novaTB.Columns.Add("img_prod", typeof(string));
    //    novaTB.Columns.Add("nome_prod", typeof(string));
    //    novaTB.Columns.Add("tipo_genero", typeof(string));
    //    novaTB.Columns.Add("tipo_linha", typeof(string));
    //    novaTB.DefaultView.RowFilter = "nome_prod like '" + Session["pesquisa"].ToString() + "%'";

    //    for (int i = 0; i < dv.Table.Rows.Count; i++)
    //    {

    //        DataRow linha = novaTB.NewRow();
    //        linha["img_prod"] = cripto.Decrypt(dv.Table.Rows[i]["img_prod"].ToString());
    //        linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());
    //        linha["tipo_genero"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString());
    //        linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
    //        novaTB.Rows.Add(linha);
    //    }


    //    conectar = new MySqlConnection(conexaoMySQL);
    //    MySqlCommand cmd = new MySqlCommand(sql, conectar);
    //    conectar.Open();

    //    MySqlDataAdapter da = new MySqlDataAdapter(sql, conectar);
    //    da.SelectCommand = cmd;
    //    DataTable dt = new DataTable();
    //    //Preenchendo o DataTable com a quantidade de registro que se pretende mostrar.
    //    da.Fill(registroInicio, tamanhoPagina, dt);
        
    //    //Tratando o fim da navegação
    //    if (tipo == "Proximo" && dt.Rows.Count == 0 && registroInicio > 0)
    //    {
    //        registroInicio -= tamanhoPagina;
    //        da.Fill(registroInicio, tamanhoPagina, dt);
    //    }

        
    //    DataList1.DataSource = dt;
    //    DataList1.DataBind();
    //    conectar.Close();

    //    // salvando a posição atual do registro
    //    ViewState.Add("registroInicio", registroInicio);
    //}
    //protected void btnProximo_Click(object sender, EventArgs e)
    //{
    //    Paginacao("Proximo");
    //}
    //protected void btnAnterior_Click(object sender, EventArgs e)
    //{
    //    Paginacao("Anterior");
    //}
}