using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PesquisaLinha : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");
        
        if (IsPostBack == false)
        {
            rbStatus.SelectedIndex = 0;
        }
    }
    protected void btnPesquisar_Click(object sender, EventArgs e)
    {
        Pesquisa();
    }
    protected void rbStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        Pesquisa();
    }
    public void Pesquisa()
    {
        if (rbStatus.SelectedIndex == 0)
        {
            Session["status"] = 0;
            descriptoGRID();
            gvExibirInativo.Visible = false;
            gvExibir.Visible = true;
        }
        //INATIVOS NÃO PODE EXCLUIR MAIS!
        else
        {
            Session["status"] = 1;
            descriptoGRIDInativos();
            gvExibir.Visible = false;
            gvExibirInativo.Visible = true;
            btnExcluir.Visible = false;
        }

    }
    protected void btnExluir_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow linha in gvExibir.Rows)
        {
            CheckBox op;
            op = (CheckBox)linha.FindControl("chkOP");
      
            if (op.Checked == true)
            {
                if (linha.Cells[3].Text == "SEM LINHA")
                {
                    lblErro.Text = "Essa linha não pode ser EXCLUÍDA!";
              
                }
                else
                {
                   lblErro.Text = "";
                    //TORNAR PRODUTO REFERENTE A LINHA DESEJADA INATIVO 
                    sqlTornarProdutosInativos.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlTornarProdutosInativos.Update();

                    //TORNAR LINHA INATIVA 
                    sqlPesqLinha.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlPesqLinha.Update();

                    //REGISTRO 
                    DateTime dtCad1 = DateTime.Today;
                    String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
                    sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Exclusão Linha");
                    sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
                    sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt(linha.Cells[3].Text);


                    sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("Alteração automática");
                    sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                    sqlRegistro.Insert();

                    Response.Redirect("ExcluirSucesso.aspx"); 
                }
            }
        }

        sqlPesqLinha.DataBind();
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["codLinha"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[2].Text;
        Response.Redirect("EditarLinha.aspx");
    }
    public void descriptoGRID()
    {
        
        sqlPesqLinha.SelectParameters["pesq"].DefaultValue = cripto.Encrypt(txtPesq.Text);
        DataView dv = (DataView)sqlPesqLinha.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_linha", typeof(int));
        novaTB.Columns.Add("tipo_linha", typeof(string));
        novaTB.Columns.Add("titulo_promo", typeof(string));

        novaTB.DefaultView.RowFilter = "tipo_linha like '" + txtPesq.Text + "%'";

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_linha"] = dv.Table.Rows[i]["id_linha"].ToString();
            linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
            linha["titulo_promo"] = cripto.Decrypt(dv.Table.Rows[i]["titulo_promo"].ToString());

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

    public void descriptoGRIDInativos()
    {
        sqlPesqLinha.SelectParameters["pesq"].DefaultValue = cripto.Encrypt(txtPesq.Text);
        DataView dv = (DataView)sqlPesqLinha.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_linha", typeof(int));
        novaTB.Columns.Add("tipo_linha", typeof(string));
        novaTB.Columns.Add("titulo_promo", typeof(string));

        novaTB.DefaultView.RowFilter = "tipo_linha like '" + txtPesq.Text + "%'";

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_linha"] = dv.Table.Rows[i]["id_linha"].ToString();
            linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
            linha["titulo_promo"] = cripto.Decrypt(dv.Table.Rows[i]["titulo_promo"].ToString());

            // 3. adicionar a linha na novaTB
            novaTB.Rows.Add(linha);
        }

        gvExibirInativo.DataSource = novaTB;
        gvExibirInativo.DataBind();

        if (gvExibirInativo.Rows.Count == 0)
        {
            lblResp.Text = "NENHUM RESULTADO ENCONTRADO.";
            lblErro.Text = "";
        }
        else
        {
            lblResp.Text = "";
            lblErro.Text = "";
        }

    }
}