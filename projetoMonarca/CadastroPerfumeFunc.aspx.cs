using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class CadastroPerfumeFunc : System.Web.UI.Page
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
               
               showPromoções();    

            }

        }

    }

    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
        //CONFEREIR EXISTENCIA DO NOME DO PRODUTO
        if (txtNome.Text != "")
        {
            sqlVereficarExistente.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtNome.Text);
            DataView dv1 = (DataView)sqlVereficarExistente.Select(DataSourceSelectArguments.Empty);

            if (dv1.Table.Rows.Count == 0)
            {
                lblExistente.Text = "";
                sqlPerfume.InsertParameters["precoUnid"].DefaultValue = cripto.Encrypt(txtPreco.Text.Replace('.', ','));
                sqlPerfume.InsertParameters["precoFinal"].DefaultValue = cripto.Encrypt(txtPrecoFinal.Text.Replace('.', ','));
                sqlPerfume.InsertParameters["precoAcres"].DefaultValue = cripto.Encrypt(txtAcresc.Text.Replace('.', ','));

                //Inserção da Promoção GENERO E LINHA

                DataView dvLinha = (DataView)sqlLinhaEscolhida.Select(DataSourceSelectArguments.Empty);
                Session["promoLinha"] = dvLinha.Table.Rows[0]["id_promo"].ToString();

                DataView dvGenero = (DataView)sqlGeneroEscolhido.Select(DataSourceSelectArguments.Empty);
                Session["promoGenero"] = dvGenero.Table.Rows[0]["id_promo"].ToString();


                //Inserção de Imagem
                String nomeArq, urlBD;

                nomeArq = Path.GetFileName(fileFoto.PostedFile.FileName);

                if (nomeArq != "")
                {
                    fileFoto.PostedFile.SaveAs(Server.MapPath("\\Monarca\\img\\" + nomeArq));
                    urlBD = "~\\img\\" + nomeArq;
                }

                else
                {
                    urlBD = "~\\img\\sem-imagem.png";
                }

                sqlPerfume.InsertParameters["foto"].DefaultValue = cripto.Encrypt(urlBD);

                sqlPerfume.InsertParameters["nome"].DefaultValue = cripto.Encrypt(txtNome.Text);
                sqlPerfume.InsertParameters["desc"].DefaultValue = cripto.Encrypt(txtDesc.Text);
                sqlPerfume.InsertParameters["slogan"].DefaultValue = cripto.Encrypt(txtSlogan.Text);
                sqlPerfume.InsertParameters["qtd"].DefaultValue = cripto.Encrypt(txtEstoque.Text);


                //Executar
                sqlPerfume.Insert();


                //REGISTRO
                DateTime dtCad = DateTime.Today;
                String dataCadastro = dtCad.ToString("yyyy/MM/dd");
                sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro;
                sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Cadastro Perfume");
                sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt(txtNome.Text);
                sqlRegistro.Insert();


                Session["NovaPromo"] = "";
                Session["promo"] = null;
                Response.Redirect("CadastroPerfumeSucessoFunc.aspx");
            }
            else
            {
                lblExistente.Text = "Título de Produto já Existente.";
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

    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("IndexFunc.aspx");
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {

        calcularPrecoFinal();
    }
    protected void ddlPromo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack == true)
        {

            Session["NovaPromo"] = "sim";
            DataView dv;
            dv = (DataView)sqlPromoEscolhida.Select(DataSourceSelectArguments.Empty);
            txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());

            int promo;
            promo = Convert.ToInt32(dv.Table.Rows[0]["id_promo"]);
            Session["promo"] = promo;

            if (promo >= 1)
            {

                lblPromoGenero.Text = "";
                lblPromoLinha.Text = "";
                calculoDesconto();


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
                rdbML.ClearSelection();
            }
            else
            {
                lblErro.Text = "";
                //PRIMEIRO CALCULA O PRECO COM ACRESCIMO (ML)
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

                //DEPOIS CALCULA O PRECO COM O DESCONTO , SOBRE O VALOR COM ACRESCIMO
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
    protected void ddlLinha_SelectedIndexChanged(object sender, EventArgs e)
    {

        calculoDesconto();

    }
    protected void ddlGenero_SelectedIndexChanged(object sender, EventArgs e)
    {

        calculoDesconto();

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

            //2. LINHA 
            else
            {
                lblPromoGenero.Text = "";


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


    private void showPromoções()
    {
        Session["promo"] = 1;


        DataView dv;
        dv = (DataView)sqlPrimeiraSelecaoLinha.Select(DataSourceSelectArguments.Empty);

        int promo;
        promo = Convert.ToInt32(dv.Table.Rows[0]["id_promo"]);

        //3. GENERO
        if (promo == 1)
        {
            lblPromoLinha.Text = "SEM PROMOÇÃO";
            txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());



            DataView dv2;
            dv2 = (DataView)sqlPrimeiraSelecaoGenero.Select(DataSourceSelectArguments.Empty);
            int promoGenero;
            promoGenero = Convert.ToInt32(dv2.Table.Rows[0]["id_promo"]);


            //SELECIONE (SEM VALOR NENHUM)
            if (promoGenero == 1)
            {
                lblPromoGenero.Text = "SEM PROMOÇÃO";
                txtDesconto.Text = cripto.Decrypt(dv2.Table.Rows[0]["desconto"].ToString());
            }
            else
            {

                lblPromoGenero.Text = cripto.Decrypt(dv2.Table.Rows[0]["titulo_promo"].ToString());
                txtDesconto.Text = cripto.Decrypt(dv2.Table.Rows[0]["desconto"].ToString());

            }
        }
        //2.LINHA
        else
        {
            lblPromoGenero.Text = "";

            lblPromoLinha.Text = cripto.Decrypt(dv.Table.Rows[0]["titulo_promo"].ToString());
            txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());
        }
    }
}