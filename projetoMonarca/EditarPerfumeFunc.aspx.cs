using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class EditarPerfume : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado2"] != "Entrar")
            Response.Redirect("LoginFunc.aspx");
        else
        {

            if (!IsPostBack)
            {
                CarregaDDLGenero();

                CarregaML();

                CarregaDDLPromo();

                CarregaDDLLinha();
            }

            if (IsPostBack == false)
            {

                DataView dv = (DataView)sqlPerfumeCadastrado.Select(DataSourceSelectArguments.Empty);
                exibirCalculoFinalProduto();
                descriptoGRID();

                //mostrar dados do perfume no TextBox
                txtNome.Text = cripto.Decrypt(dv.Table.Rows[0]["nome_prod"].ToString());
                txtPreco.Text = cripto.Decrypt(dv.Table.Rows[0]["valorUnid_prod"].ToString().Replace('.', ','));
                txtSlogan.Text = cripto.Decrypt(dv.Table.Rows[0]["slogan_prod"].ToString());
                txtDesc.Text = cripto.Decrypt(dv.Table.Rows[0]["desc_prod"].ToString());
                //txtAcresc.Text = cripto.Decrypt(dv.Table.Rows[0]["valor_acrescimo"].ToString().Replace('.', ','));
                txtAcresc.Text = Session["precoAdicional"].ToString();

                //exibir acrescimo
                double acresc, porcentagem;
                acresc = Convert.ToDouble(cripto.Decrypt(dv.Table.Rows[0]["adicional"].ToString()));
                porcentagem = acresc / 100;
                lblAcres.Text = "Acréscimo de " + porcentagem.ToString() + "%";
                ///////

                txtPrecoFinal.Text = Session["precoFinal"].ToString();
                ddlGenero.Text = dv.Table.Rows[0]["id_genero"].ToString();
                ddlLinha.Text = dv.Table.Rows[0]["id_linha"].ToString();
                rdbML.Text = dv.Table.Rows[0]["id_ml"].ToString();
                txtEstoque.Text = cripto.Decrypt(dv.Table.Rows[0]["qtd_disponivel"].ToString());

            }
        }
    }
    public void CarregaML()
    {
        DataView dv = (DataView)sqlML.Select(DataSourceSelectArguments.Empty);
        rdbML.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            rdbML.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString()), dv.Table.Rows[i]["id_ml"].ToString()));
        }
    }
    public void CarregaDDLPromo()
    {
        DataView dv = (DataView)sqlExibirPromo.Select(DataSourceSelectArguments.Empty);
        ddlPromocao.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            ddlPromocao.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["titulo_promo"].ToString()), dv.Table.Rows[i]["id_promo"].ToString()));
        }
    }
    public void CarregaDDLLinha()
    {
        DataView dv = (DataView)sqlLinha.Select(DataSourceSelectArguments.Empty);
        ddlLinha.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            ddlLinha.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString()), dv.Table.Rows[i]["id_linha"].ToString()));
        }
    }
    public void CarregaDDLGenero()
    {
        DataView dv = (DataView)sqlGenero.Select(DataSourceSelectArguments.Empty);
        ddlGenero.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            ddlGenero.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString()), dv.Table.Rows[i]["id_genero"].ToString()));
        }
    }
    public void descriptoGRID()
    {
        DataView dv = (DataView)sqlPerfumeCadastrado.Select(DataSourceSelectArguments.Empty);
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


        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_prod"] = dv.Table.Rows[i]["id_prod"].ToString();
            linha["img_prod"] = cripto.Decrypt(dv.Table.Rows[i]["img_prod"].ToString());
            linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());
            linha["tipo_genero"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString());
            linha["tipo_linha"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString());
            linha["desc_ml"] = cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString());
            linha["valor_prod_final"] = Session["precoFinal"].ToString();
            linha["qtd_disponivel"] = cripto.Decrypt(dv.Table.Rows[i]["qtd_disponivel"].ToString());

            // 3. adicionar a linha na novaTB
            novaTB.Rows.Add(linha);
        }

        gvExibir.DataSource = novaTB;
        gvExibir.DataBind();

    }
    protected void btnEditar_Click(object sender, EventArgs e)
    {
        //1 - CADASTRAR UM NOVO PERFUME (PREÇO + FOTO + GERAL)
        sqlAlterarDadosAntigos.UpdateParameters["precoUnid"].DefaultValue = cripto.Encrypt(txtPreco.Text.Replace('.', ','));
        sqlAlterarDadosAntigos.UpdateParameters["precoFinal"].DefaultValue = cripto.Encrypt(txtPrecoFinal.Text.Replace('.', ','));
        sqlAlterarDadosAntigos.UpdateParameters["precoAcres"].DefaultValue = cripto.Encrypt(txtAcresc.Text.Replace('.', ','));


        sqlAlterarDadosAntigos.UpdateParameters["nome"].DefaultValue = cripto.Encrypt(txtNome.Text);
        sqlAlterarDadosAntigos.UpdateParameters["slogan"].DefaultValue = cripto.Encrypt(txtSlogan.Text);
        sqlAlterarDadosAntigos.UpdateParameters["descricao"].DefaultValue = cripto.Encrypt(txtDesc.Text);
        sqlAlterarDadosAntigos.UpdateParameters["qtd"].DefaultValue = cripto.Encrypt(txtEstoque.Text);

        String nomeArq, urlBD;
        nomeArq = Path.GetFileName(fileFoto.PostedFile.FileName);

        if (nomeArq != "")
        {
            fileFoto.PostedFile.SaveAs(Server.MapPath("\\images\\" + nomeArq));
            urlBD = "~\\images\\" + nomeArq;
        }

        else
        {
            urlBD = "~\\img\\sem-imagem.png";
        }

        sqlAlterarDadosAntigos.UpdateParameters["foto"].DefaultValue = cripto.Encrypt(urlBD);
        sqlAlterarDadosAntigos.Update();
        /////////////////////////////////////////////////////
        Response.Redirect("EditarSucessoFunc.aspx");
    }

    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("IndexADM.aspx");
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        calcularPrecoFinal();
    }
    protected void ddlLinha_SelectedIndexChanged(object sender, EventArgs e)
    {
        calculoDesconto();
    }
    protected void ddlGenero_SelectedIndexChanged(object sender, EventArgs e)
    {
        calculoDesconto();
    }
    protected void ddlPromo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack == true)
        {
            DataView dv;
            dv = (DataView)sqlPromoEscolhida.Select(DataSourceSelectArguments.Empty);
            txtDesconto.Text = dv.Table.Rows[0]["desconto"].ToString();

            int promo;
            promo = Convert.ToInt32(dv.Table.Rows[0]["id_promo"]);
            //Session["promo"] = promo;

            if (promo >= 1)
            {

                lblPromoGenero.Text = "";
                lblPromoLinha.Text = "";
                //calculoDesconto();


                if (txtPreco.Text != "")
                {
                    calculoDesconto();

                    if (rdbML.SelectedIndex != null)
                    {
                        calcularPrecoFinal();
                    }
                }
            }
        }
    }

    private void calculoDesconto()
    {
        //1. PRODUTO
        if (ddlPromocao.SelectedIndex != 0)
        {
            DataView dv;
            dv = (DataView)sqlPromoEscolhida.Select(DataSourceSelectArguments.Empty);
            txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());



            double desconto, precoFinalDesconto;
            desconto = Convert.ToDouble(txtDesconto.Text);

            if (txtPreco.Text != "")
            {
                double preco;
                preco = Convert.ToDouble(txtPreco.Text);

                precoFinalDesconto = preco - (preco * (desconto / 100));
                txtPrecoFinal.Text = precoFinalDesconto.ToString("#0.00");
            }

        }
        else
        {
            //2. LINHA 
            if (ddlLinha.SelectedIndex != null)
            {

                DataView dv;
                dv = (DataView)sqlLinhaEscolhida.Select(DataSourceSelectArguments.Empty);
                int promo;
                promo = Convert.ToInt32(dv.Table.Rows[0]["id_promo"]);

                //3. GENERO
                if (promo == 1)
                {
                    lblPromoLinha.Text = "SEM PROMOÇÃO";
                    txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());



                    DataView dv2;
                    dv2 = (DataView)sqlGeneroEscolhido.Select(DataSourceSelectArguments.Empty);
                    int promoGenero;
                    promoGenero = Convert.ToInt32(dv2.Table.Rows[0]["id_promo"]);


                    //SELECIONE (SEM VALOR NENHUM)
                    if (promoGenero == 1)
                    {
                        lblPromoGenero.Text = "SEM PROMOÇÃO";
                        txtDesconto.Text = cripto.Decrypt(dv2.Table.Rows[0]["desconto"].ToString());

                        if (txtPreco.Text != "")
                        {
                            calcularPrecoFinal();
                        }
                    }
                    else
                    {
                        //Session["promo"] = promoGenero;
                        lblPromoGenero.Text = cripto.Decrypt(dv2.Table.Rows[0]["titulo_promo"].ToString());
                        txtDesconto.Text = cripto.Decrypt(dv2.Table.Rows[0]["desconto"].ToString());

                        double desconto, precoFinalDesconto;
                        desconto = Convert.ToDouble(txtDesconto.Text);

                        if (txtPreco.Text != "")
                        {
                            double preco;
                            preco = Convert.ToDouble(txtPreco.Text);

                            precoFinalDesconto = preco - (preco * (desconto / 100));
                            txtPrecoFinal.Text = precoFinalDesconto.ToString("#0.00");
                        }
                    }
                }
                else
                {
                    lblPromoGenero.Text = "";

                    // Session["promo"] = promo;
                    lblPromoLinha.Text = cripto.Decrypt(dv.Table.Rows[0]["titulo_promo"].ToString());
                    txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());

                    double desconto, precoFinalDesconto;
                    desconto = Convert.ToDouble(txtDesconto.Text);

                    if (txtPreco.Text != "")
                    {
                        double preco;
                        preco = Convert.ToDouble(txtPreco.Text);

                        precoFinalDesconto = preco - (preco * (desconto / 100));
                        txtPrecoFinal.Text = precoFinalDesconto.ToString("#0.00");
                    }
                }

            }
        }
    }

    private void calcularPrecoFinal()
    {
        if (IsPostBack == true)
        {
            lblErro.Text = "*";
            if (txtPreco.Text == "")
            {
                lblErro.Text = "*";
                txtPrecoFinal.Text = "";
                txtAcresc.Text = "";
            }
            else
            {
                lblErro.Text = "";

                DataView dv;
                dv = (DataView)sqlMLEscolhido.Select(DataSourceSelectArguments.Empty);

                double preco, acresc, precoFinal, acrescFinal, porcentagem;


                preco = Convert.ToDouble(txtPreco.Text);
                acresc = Convert.ToDouble(cripto.Decrypt(dv.Table.Rows[0]["adicional"].ToString()));
                porcentagem = acresc / 100;
                acrescFinal = preco * porcentagem;

                precoFinal = acrescFinal + preco;
                txtPrecoFinal.Text = precoFinal.ToString("#0.00");
                txtAcresc.Text = acrescFinal.ToString("#0.00");
                lblAcres.Text = "Acréscimo de " + porcentagem.ToString() + "%";


                if (txtDesconto.Text != "")
                {
                    double desconto, precoFinalDesconto;
                    desconto = Convert.ToDouble(txtDesconto.Text);


                    precoFinalDesconto = precoFinal - (precoFinal * (desconto / 100));
                    txtPrecoFinal.Text = precoFinalDesconto.ToString("#0.00");
                }

            }
        }
    }

    public void exibirCalculoFinalProduto()
    {

        //-SQL's : sqlBuscarDescontoDoProduto, sqlBuscarDescontoDoGenero & sqlBuscarDescontoDaLinha//
        //ALTERAR A PESQUISAR PRODUTO DE ACORDO COM A PAGINA
        DataView dvProduto = (DataView)sqlBuscarDescontoDoProduto.Select(DataSourceSelectArguments.Empty);
        Session["codLinhaRelacionada"] = dvProduto.Table.Rows[0]["id_linha"].ToString();
        Session["codGeneroRelacionado"] = dvProduto.Table.Rows[0]["id_genero"].ToString();

        DataView dvGenero = (DataView)sqlBuscarDescontoDoGenero.Select(DataSourceSelectArguments.Empty);
        DataView dvLinha = (DataView)sqlBuscarDescontoDaLinha.Select(DataSourceSelectArguments.Empty);

        double precoUnid, adicional, precoAdicional;
        double descontoLinha, descontoGenero, descontoProduto;
        double precoComAdicional, precoFinal;

        precoUnid = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[0]["valorUnid_prod"].ToString().Replace('.', ',')));

        descontoLinha = Convert.ToDouble(cripto.Decrypt(dvLinha.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));
        descontoGenero = Convert.ToDouble(cripto.Decrypt(dvGenero.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));
        descontoProduto = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));
        adicional = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[0]["adicional"].ToString()));


        //CONTA DO VALOR ACRESCIMO /- EM RELAÇÃO ML      
        precoAdicional = precoUnid * (adicional / 100);
        precoComAdicional = precoAdicional + precoUnid;
        Session["precoAdicional"] = precoAdicional.ToString("#0.00");

        //CONTA DA PROMOÇÃO /- VALOR COM ADICIONAL
        if (dvProduto.Table.Rows[0]["id_promo"].ToString() == "1")
        {
            if (dvLinha.Table.Rows[0]["id_promo"].ToString() == "1")
            {
                lblPromoLinha.Text = "SEM PROMOÇÃO";

                //SEM PROMOÇÃO NENHUMA!            
                if (dvGenero.Table.Rows[0]["id_promo"].ToString() == "1")
                {
                    precoFinal = precoUnid + precoAdicional;
                    Session["precoFinal"] = precoFinal.ToString("#0.00");
                    lblPromoGenero.Text = "SEM PROMOÇÃO";
                    txtDesconto.Text = "0";
                }
                //DESCONTO GENERO
                else
                {
                    precoFinal = precoComAdicional - (precoComAdicional * descontoGenero / 100);
                    Session["precoFinal"] = precoFinal.ToString("#0.00");
                    lblPromoGenero.Text = cripto.Decrypt(dvGenero.Table.Rows[0]["titulo_promo"].ToString());
                    txtDesconto.Text = cripto.Decrypt(dvGenero.Table.Rows[0]["desconto"].ToString());

                }
            }
            //DESCONTO LINHA
            else
            {
                precoFinal = precoComAdicional - (precoComAdicional * descontoLinha / 100);
                Session["precoFinal"] = precoFinal.ToString("#0.00");
                lblPromoLinha.Text = cripto.Decrypt(dvLinha.Table.Rows[0]["titulo_promo"].ToString());
                txtDesconto.Text = cripto.Decrypt(dvLinha.Table.Rows[0]["desconto"].ToString());
            }
        }
        //DESCONTO DO PRODUTO
        else
        {
            ddlPromocao.Text = dvProduto.Table.Rows[0]["id_promo"].ToString();
            precoFinal = precoComAdicional - (precoComAdicional * descontoProduto / 100);
            Session["precoFinal"] = precoFinal.ToString("#0.00");
            txtDesconto.Text = cripto.Decrypt(dvProduto.Table.Rows[0]["desconto"].ToString());
        }
    }
}