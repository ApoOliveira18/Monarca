﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class EditarLinha : System.Web.UI.Page
{

    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");

        if (!IsPostBack)
        {
            CarregaDDLPromo();
        }

        if (IsPostBack == false)
        {
            DataView dv;
            dv = (DataView)sqlLinhaCadastrada.Select(DataSourceSelectArguments.Empty);
            descriptoGRID();

            //mostrar dados cadastrados
            txtLinha.Text = cripto.Decrypt(dv.Table.Rows[0]["tipo_linha"].ToString());
            ddlPromo.Text = dv.Table.Rows[0]["id_promo"].ToString();

            descontoPromo.Style.Add("display", "none");


            if (dv.Table.Rows[0]["id_promo"].ToString() != "1")
            {
                descontoPromo.Style.Add("display", "");
                txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());
            }
        }
    }
    protected void btnEditar_Click(object sender, EventArgs e)
    {
    
        sqlAlterarLinha.UpdateParameters["linha"].DefaultValue = cripto.Encrypt(txtLinha.Text); 
        sqlAlterarLinha.Update();       

        exibirCalculoFinalProduto();        
        Session["codLinha"] = null;

        //REGISTRO 
        DateTime dtCad1 = DateTime.Today;
        String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
        sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Edição Linha");
        sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
        sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt(txtLinha.Text);


        sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

        sqlRegistro.Insert();

        Response.Redirect("EditarSucesso.aspx");
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

       // novaTB.DefaultView.RowFilter = "id_linha=" + Session["codLinha"].ToString();

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

    protected void ddlPromo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack == true)
        {

            descontoPromo.Style.Add("display", "");
            DataView dv2 = (DataView)sqlPromoEscolhida.Select(DataSourceSelectArguments.Empty);
            txtDesconto.Text = cripto.Decrypt(dv2.Table.Rows[0]["desconto"].ToString());

        }
    }

    public void CarregaDDLPromo()
    {
        DataView dv = (DataView)sqlExibirPromo.Select(DataSourceSelectArguments.Empty);
        ddlPromo.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            ddlPromo.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["titulo_promo"].ToString()), dv.Table.Rows[i]["id_promo"].ToString()));
        }
    }

    public void descriptoGRID()
    {
        DataView dv = (DataView)sqlLinhaCadastrada.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_linha", typeof(int));
        novaTB.Columns.Add("tipo_linha", typeof(string));
        novaTB.Columns.Add("titulo_promo", typeof(string));

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

    }
   }