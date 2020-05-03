using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PesquisaPerfume : System.Web.UI.Page
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
    protected void btnExcluir_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow linha in gvExibir.Rows)
        {
            CheckBox op;
            op = (CheckBox)linha.FindControl("chkOP");

            if (op.Checked == true)
            {
                //TORNAR INATIVO
                sqlPerfumes.UpdateParameters["cod"].DefaultValue = linha.Cells[2].Text;
                sqlPerfumes.Update();

                //REGISTRO 
                DateTime dtCad1 = DateTime.Today;
                String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
                sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Exclusão Perfume");
                sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
                sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


                sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt(linha.Cells[3].Text);
                sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                sqlRegistro.Insert();

                Response.Redirect("ExcluirSucesso.aspx");
            }
        }

        sqlPerfumes.DataBind();
    }
    protected void gvExibir_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["codProduto"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[2].Text;
        Session["codLinha"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[6].Text;
        Session["codGenero"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[5].Text;
        Response.Redirect("EditarPerfume.aspx");
    }

    public void descriptoGRID()
    {
        sqlPerfumes.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlPerfumes.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_prod", typeof(int));
        novaTB.Columns.Add("img_prod", typeof(string));
        novaTB.Columns.Add("nome_prod", typeof(string));
        novaTB.Columns.Add("tipo_genero", typeof(string));
        novaTB.Columns.Add("tipo_linha", typeof(string));
        novaTB.Columns.Add("desc_ml", typeof(string));
        novaTB.Columns.Add("valor_prod_final", typeof(double));
        novaTB.Columns.Add("qtd_disponivel", typeof(string));

        novaTB.DefaultView.RowFilter = "nome_prod like '" + txtPesquisa.Text + "%'";
       

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_prod"] = dv.Table.Rows[i]["id_prod"].ToString();
            Session["produto"] = dv.Table.Rows[i]["id_prod"].ToString();

            linha["img_prod"] = cripto.Decrypt(dv.Table.Rows[i]["img_prod"].ToString());
            linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());
            linha["tipo_genero"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString());
            linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
            linha["desc_ml"] = cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString());


            /////INICIO CALCULOS !!!
            DataView dvProduto = (DataView)sqlBuscarDescontoDoProduto.Select(DataSourceSelectArguments.Empty);

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
            
            ////////////////////FIM DA CONTA DO PRODUTO

            //EXIBIR VALOR PRODUTO!
            linha["valor_prod_final"] = Session["precoFinal"].ToString();
            linha["qtd_disponivel"] = cripto.Decrypt(dv.Table.Rows[i]["qtd_disponivel"].ToString());

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

    public void descriptoGRIDInativos()
    {
        sqlPerfumes.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlPerfumes.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_prod", typeof(int));
        novaTB.Columns.Add("img_prod", typeof(string));
        novaTB.Columns.Add("nome_prod", typeof(string));
        novaTB.Columns.Add("tipo_genero", typeof(string));
        novaTB.Columns.Add("tipo_linha", typeof(string));
        novaTB.Columns.Add("desc_ml", typeof(string));
        novaTB.Columns.Add("valor_prod_final", typeof(double));
        novaTB.Columns.Add("qtd_disponivel", typeof(string));

        novaTB.DefaultView.RowFilter = "nome_prod like '" + txtPesquisa.Text + "%'";
        exibirCalculoFinalProduto();

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_prod"] = dv.Table.Rows[i]["id_prod"].ToString();
            Session["produto"] = dv.Table.Rows[i]["id_prod"].ToString();
            
            linha["img_prod"] = cripto.Decrypt(dv.Table.Rows[i]["img_prod"].ToString());
            linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());
            linha["tipo_genero"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString());
            linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
            linha["desc_ml"] = cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString());

            /////INICIO CALCULOS !!!
            DataView dvProduto = (DataView)sqlBuscarDescontoDoProduto.Select(DataSourceSelectArguments.Empty);

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

            ////////////////////FIM DA CONTA DO PRODUTO

            //EXIBIR VALOR PRODUTO!
            linha["valor_prod_final"] = Session["precoFinal"].ToString();
            linha["qtd_disponivel"] = cripto.Decrypt(dv.Table.Rows[i]["qtd_disponivel"].ToString());

            // 3. adicionar a linha na novaTB
            novaTB.Rows.Add(linha);
        }

        gvExibirInativo.DataSource = novaTB;
        gvExibirInativo.DataBind();

        if (gvExibirInativo.Rows.Count == 0)
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
    //NAO É MAIS USADO
    public String exibirCalculoFinalProduto()
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

        novaTB.DefaultView.RowFilter = "nome_prod like '" + txtPesquisa.Text + "%'";

        for (int i = 0; i < dvProduto.Table.Rows.Count; i++)
        {

            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_prod"] = dvProduto.Table.Rows[i]["id_prod"].ToString();
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

            
        }
        return Session["precoFinal"].ToString();
    }
}