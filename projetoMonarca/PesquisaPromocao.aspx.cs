using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PesquisaPromocao : System.Web.UI.Page
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

                if (linha.Cells[3].Text == "Selecione")
                {
                    lblErro.Text = "A Promoção desejada não pode ser Excluída!";

                }
                else
                {

                    //RETIRAR PROMO DO PRODUTO
                    sqlExcluirPromoDoProd.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlExcluirPromoDoProd.Update();

                    
                   //RETIRAR PROMO DA LINHA
                    sqlExcluirPromoDaLinha.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlExcluirPromoDaLinha.Update();
                    
                    //RETIRAR PROMO DO GENERO 
                    sqlExcluirPromoDoGenero.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlExcluirPromoDoGenero.Update();

                    //eEXCLUIR PROMOÇÃO!
                    sqlExibirInformacaoPromo.DeleteParameters["cod"].DefaultValue = linha.Cells[2].Text;
                    sqlExibirInformacaoPromo.Delete();


                    //ALTERAR PRECO DO PRODUTO
                    Session["codPromo"] = linha.Cells[2].Text;
                    exibirCalculoFinalProduto();

                    //REGISTRO 
                    DateTime dtCad1 = DateTime.Today;
                    String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
                    sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Exclusão Promoção");
                    sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
                    sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("Alteração automática");


                    sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("Alteração automática");
                    sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt(linha.Cells[3].Text);
                    sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("Alteração automática");

                    sqlRegistro.Insert();

                    Response.Redirect("ExcluirSucesso.aspx");
                }
            }
        }

        sqlExibirInformacaoPromo.DataBind();
    }
    protected void gvExibir_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["codPromo"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[2].Text;
        Response.Redirect("EditarPromocao.aspx");
    }


    public void exibirCalculoFinalProduto()
    {

        //-SQL's : sqlBuscarDescontoDoProduto, sqlBuscarDescontoDoGenero & sqlBuscarDescontoDaLinha//
        //ALTERAR A PESQUISAR PRODUTO DE ACORDO COM A PAGINA

        //PESQUISAR TODOS POR LIKE 
        DataView dvProduto = (DataView)sqlBuscarDescontoDoProduto.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        novaTB.Columns.Add("id_prod", typeof(int));
        novaTB.Columns.Add("id_ml", typeof(int));
        novaTB.Columns.Add("id_promo", typeof(int));
        novaTB.Columns.Add("id_linha", typeof(int));
        novaTB.Columns.Add("id_genero", typeof(int));

        novaTB.Columns.Add("nome_prod", typeof(string));
        novaTB.Columns.Add("titulo_promo", typeof(string));
        novaTB.Columns.Add("desconto", typeof(string));
        novaTB.Columns.Add("adicional", typeof(double));
        novaTB.Columns.Add("valor_prod_final", typeof(double));
        novaTB.Columns.Add("valorUnid_prod", typeof(double));
        novaTB.Columns.Add("valor_acrescimo", typeof(double));

        // novaTB.DefaultView.RowFilter = "nome_prod like '" + txtPesquisa.Text + "%'";

        for (int i = 0; i < dvProduto.Table.Rows.Count; i++)
        {

            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_prod"] = dvProduto.Table.Rows[i]["id_prod"].ToString();
            Session["codProdEditar"] = dvProduto.Table.Rows[i]["id_prod"].ToString();

            linha["id_ml"] = dvProduto.Table.Rows[i]["id_ml"].ToString();
            linha["id_promo"] = dvProduto.Table.Rows[i]["id_promo"].ToString();
            linha["id_linha"] = dvProduto.Table.Rows[i]["id_linha"].ToString();
            linha["id_genero"] = dvProduto.Table.Rows[i]["id_genero"].ToString();

            Session["codLinhaRelacionada"] = dvProduto.Table.Rows[i]["id_linha"].ToString();
            Session["codGeneroRelacionado"] = dvProduto.Table.Rows[i]["id_genero"].ToString();

            DataView dvGenero = (DataView)sqlBuscarDescontoDoGenero.Select(DataSourceSelectArguments.Empty);
            DataView dvLinha = (DataView)sqlBuscarDescontoDaLinha.Select(DataSourceSelectArguments.Empty);

            double precoUnid, adicional, precoAdicional;
            double descontoLinha, descontoGenero, descontoProduto;
            double precoComAdicional, precoFinal;

            precoUnid = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[i]["valorUnid_prod"].ToString().Replace('.', ',')));
            descontoProduto = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[i]["desconto"].ToString().Replace('.', ',')));
            adicional = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[i]["adicional"].ToString()));

            descontoLinha = Convert.ToDouble(cripto.Decrypt(dvLinha.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));
            descontoGenero = Convert.ToDouble(cripto.Decrypt(dvGenero.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));



            //CONTA DO VALOR ACRESCIMO /- EM RELAÇÃO ML      
            precoAdicional = precoUnid * (adicional / 100);
            precoComAdicional = precoAdicional + precoUnid;
            Session["precoAdicional"] = precoAdicional.ToString("#0.00");

            //CONTA DA PROMOÇÃO /- VALOR COM ADICIONAL
            if (dvProduto.Table.Rows[i]["id_promo"].ToString() == "1")
            {
                if (dvLinha.Table.Rows[0]["id_promo"].ToString() == "1")
                {
                    //SEM PROMOÇÃO NENHUMA!            
                    if (dvGenero.Table.Rows[0]["id_promo"].ToString() == "1")
                    {
                        precoFinal = precoUnid + precoAdicional;
                        Session["precoFinal"] = precoFinal.ToString("#0.00");
                    }
                    //DESCONTO GENERO
                    else
                    {
                        precoFinal = precoComAdicional - (precoComAdicional * descontoGenero / 100);
                        Session["precoFinal"] = precoFinal.ToString("#0.00");
                    }
                }
                //DESCONTO LINHA
                else
                {
                    precoFinal = precoComAdicional - (precoComAdicional * descontoLinha / 100);
                    Session["precoFinal"] = precoFinal.ToString("#0.00");
                }
            }
            //DESCONTO DO PRODUTO
            else
            {
                precoFinal = precoComAdicional - (precoComAdicional * descontoProduto / 100);
                Session["precoFinal"] = precoFinal.ToString("#0.00");
            }

            sqlAlterarPrecoProd.UpdateParameters["preco"].DefaultValue = cripto.Encrypt(Session["precoFinal"].ToString().Replace('.', ','));
            sqlAlterarPrecoProd.Update();
        }
        // return Session["precoFinal"].ToString();
    }

    public void descriptoGRID()
    {
        sqlExibirInformacaoPromo.SelectParameters["promo"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlExibirInformacaoPromo.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_promo", typeof(int));
        novaTB.Columns.Add("titulo_promo", typeof(string));
        novaTB.Columns.Add("desconto", typeof(string));
        novaTB.DefaultView.RowFilter = "titulo_promo like '" + txtPesquisa.Text + "%'";

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_promo"] = dv.Table.Rows[i]["id_promo"].ToString();
            linha["titulo_promo"] = cripto.Decrypt(dv.Table.Rows[i]["titulo_promo"].ToString());
            linha["desconto"] = cripto.Decrypt(dv.Table.Rows[i]["desconto"].ToString());

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