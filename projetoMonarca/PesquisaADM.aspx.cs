

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

                    if (linha.Cells[2].Text == "1")
                    {
                        lblErro.Text = "O Administrador desejado não pode ser Exluído!";
                    }
                    else
                    {

                    sqlAdministradores.DeleteParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlAdministradores.Delete();

                    //REGISTRO 
                    DateTime dtCad1 = DateTime.Today;
                    String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
                    sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Exclusão ADM");
                    sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
                    sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


                    sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt(linha.Cells[3].Text);
                    sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                    sqlRegistro.Insert();

                    Response.Redirect("ExcluirSucesso.aspx");
                }
            
            }
            sqlAdministradores.DataBind();
        }
        
    }
    protected void gvExibir_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["codADM"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[2].Text;
        Response.Redirect("EditarADM.aspx");
    }

    public void descriptoGRID()
    {

        sqlAdministradores.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlAdministradores.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_adm", typeof(int));
        novaTB.Columns.Add("login_adm", typeof(string));
        novaTB.Columns.Add("email_adm", typeof(string));
        novaTB.Columns.Add("data_conta", typeof(string));

        novaTB.DefaultView.RowFilter = "login_adm like '" + txtPesquisa.Text + "%'";

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_adm"] = dv.Table.Rows[i]["id_adm"].ToString();
            linha["login_adm"] = cripto.Decrypt(dv.Table.Rows[i]["login_adm"].ToString());
            linha["email_adm"] = cripto.Decrypt(dv.Table.Rows[i]["email_adm"].ToString());

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
            lblErro.Text = "";
        }
        else
        {
            btnExcluir.Visible = true;
            lblResp.Text = "";
            lblErro.Text = "";
        }
       

    }
}