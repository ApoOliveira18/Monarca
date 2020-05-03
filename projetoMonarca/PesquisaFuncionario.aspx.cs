using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PesquisaADM : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");
    }
    protected void btnPesquisar_Click(object sender, EventArgs e)
    {
          descriptoGRID();         
    }
    protected void btnExcluir_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow linha in gvExibir.Rows)
        {
            CheckBox op;
            op = (CheckBox)linha.FindControl("chkOP");

            if (op.Checked == true)
            {
                sqlFuncionarios.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                sqlFuncionarios.Update();


                //REGISTRO 
                DateTime dtCad1 = DateTime.Today;
                String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
                sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Exclusão Funcionário");
                sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
                sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


                sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt(linha.Cells[3].Text);
                sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                sqlRegistro.Insert();

                Response.Redirect("ExcluirSucesso.aspx");
            }
        }

        sqlFuncionarios.DataBind();
    }
    protected void gvExibir_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["codFunc"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[2].Text;
        Response.Redirect("EditarFuncionario.aspx");
    }
    public void descriptoGRID()
    {
        sqlFuncionarios.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlFuncionarios.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_func", typeof(int));
        novaTB.Columns.Add("login_func", typeof(string));
        novaTB.Columns.Add("email_func", typeof(string));
        novaTB.Columns.Add("data_conta", typeof(string));

        novaTB.DefaultView.RowFilter = "login_func like '" + txtPesquisa.Text + "%'";

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_func"] = dv.Table.Rows[i]["id_func"].ToString();
            linha["login_func"] = cripto.Decrypt(dv.Table.Rows[i]["login_func"].ToString());
            linha["email_func"] = cripto.Decrypt(dv.Table.Rows[i]["email_func"].ToString());

            DateTime dtCadastro = Convert.ToDateTime(dv.Table.Rows[i]["data_conta"].ToString());
            String dtCadastroCerto = dtCadastro.ToString("dd/MM/yyyy");
            linha["data_conta"] = dtCadastroCerto;
           
            // 3. adicionar a linha na novaTB
            novaTB.Rows.Add(linha);
        }

        gvExibir.DataSource = novaTB;
        gvExibir.DataBind();

        if (gvExibir.Rows.Count == 0)
        {
            lblResp.Text = "NENHUM RESULTADO ENCONTRADO.";
            btnExcluir.Visible = false;
        }
        else
        {
            btnExcluir.Visible = true;
            lblResp.Text = "";
        }

    }
}