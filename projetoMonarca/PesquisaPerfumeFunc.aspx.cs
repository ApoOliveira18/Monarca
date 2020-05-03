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
        if (Session["logado2"] != "Entrar")
            Response.Redirect("LoginFunc.aspx");

        if (IsPostBack == false)
        {
            rbStatus.SelectedIndex = 0;
        }
    }
    protected void rbStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        Pesquisa();
    }
    protected void btnPesquisar_Click(object sender, EventArgs e)
    {
        Pesquisa();
    }
    public void Pesquisa()
    {
        if (rbStatus.SelectedIndex == 0)
        {
            Session["status"] = 0;
        }
        else
        {
            Session["status"] = 1;
        }

        descriptoGRID();
    }
    protected void gvExibir_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["codProduto"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[1].Text;
        Session["codLinha"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[5].Text;
        Session["codGenero"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[4].Text;
        Response.Redirect("EditarPerfumeFunc.aspx");
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
       // exibirCalculoFinalProduto();


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
            linha["qtd_disponivel"] = cripto.Decrypt(dv.Table.Rows[i]["qtd_disponivel"].ToString());




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

            // 3. adicionar a linha na novaTB
            novaTB.Rows.Add(linha);
        }

        gvExibir.DataSource = novaTB;
        gvExibir.DataBind();

        if (gvExibir.Rows.Count == 0)
        {
            lblResp.Text = "NENHUM RESULTADO ENCONTRADO.";
        }
        else
        {
            lblResp.Text = "";
        }

    }

}