using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PesquisaML : System.Web.UI.Page
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
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["codML"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[2].Text;
        Response.Redirect("EditarML.aspx");
    }
    protected void btnExluir_Click(object sender, EventArgs e)
    {
             
        
        foreach (GridViewRow linha in gvExibir.Rows)
        {
            CheckBox op;
            op = (CheckBox)linha.FindControl("chkOP");

            if (op.Checked == true)
            {
                if (linha.Cells[2].Text == "1")
                {
                    lblErro.Text = "O Ml desejado não pode ser Excluído!";

                }
                else
                {
                    //ALTERAR O PRODUTO DO ML DESEJADO 
                    int acresc;
                    acresc = 0;
                    sqlExcluirProdutoDoML.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlExcluirProdutoDoML.UpdateParameters["acresc"].DefaultValue = cripto.Encrypt(acresc.ToString());
                    
                    Session["codML"] = linha.Cells[2].Text;
                    DataView dv = (DataView)sqlBuscarPrecoProdutoAntigo.Select(DataSourceSelectArguments.Empty);

                    for (int i = 0; i < dv.Table.Rows.Count; i++)
                    {
                        double precoAntigo, adicionalAntigo;
                        double precoSemAdiconal;

                        precoAntigo = Convert.ToDouble(cripto.Decrypt(dv.Table.Rows[i]["valor_prod_final"].ToString()));
                        adicionalAntigo = Convert.ToDouble(cripto.Decrypt(dv.Table.Rows[i]["valor_acrescimo"].ToString()));
                        precoSemAdiconal = precoAntigo - adicionalAntigo;

                        sqlExcluirProdutoDoML.UpdateParameters["preco"].DefaultValue = cripto.Encrypt(precoSemAdiconal.ToString("#0.00"));
                        sqlExcluirProdutoDoML.Update();
                    }

                    
                    //EXCLUIR ML


                    sqlPesqML.DeleteParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlPesqML.Delete();

                    
                    //REGISTRO 
                    DateTime dtCad1 = DateTime.Today;
                    String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
                    sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Exclusão ML");
                    sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
                    sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


                    sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("Alteração automática");
                    sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt(linha.Cells[3].Text);
                    sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                    sqlRegistro.Insert();

                    Response.Redirect("ExcluirSucesso.aspx");
                }
            }
        }

        sqlPesqML.DataBind();
    }

  
    public void descriptoGRID()
    {
        sqlPesqML.SelectParameters["pesq"].DefaultValue = cripto.Encrypt(txtPesq.Text + "ml");
        DataView dv = (DataView)sqlPesqML.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_ml", typeof(int));
        novaTB.Columns.Add("desc_ml", typeof(string));
        novaTB.Columns.Add("adicional", typeof(double));

        novaTB.DefaultView.RowFilter = "desc_ml like '" + txtPesq.Text + "%'";

      
            lblResp.Text = "";
            // varrendo as linhas da tabela criptografadas
            // 1 a 1 para descriptografar
            for (int i = 0; i < dv.Table.Rows.Count; i++)
            {
                // 1. criar a linha
                DataRow linha = novaTB.NewRow();

                // 2. descriptografar
                linha["id_ml"] = dv.Table.Rows[i]["id_ml"].ToString();
                linha["desc_ml"] = cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString());
                linha["adicional"] = cripto.Decrypt(dv.Table.Rows[i]["adicional"].ToString());

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

