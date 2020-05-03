using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Store : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");


    int numeroSorteado, qtdProd, qtdNumerosIguais;
    Random sequenciaProd = new Random();
    int[] pilhaProd = new int[5];


    double precoUnid, precoFinalAdicional, precoAdicional, precoAtual;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            carregarProd();
        }

           if (!IsPostBack)
           {
               CarregaRBLinha();
           }

    }
    public void CarregaRBLinha()
    {
        DataView dv = (DataView)sqlExibirLinha.Select(DataSourceSelectArguments.Empty);
        rbLinha.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            rbLinha.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString()), dv.Table.Rows[i]["id_linha"].ToString()));
        }
    }

    protected void carregarProd()
    {

        rbGenero.ClearSelection();
        rbLinha.ClearSelection();
        
            DataView dv = (DataView)sqlStore.Select(DataSourceSelectArguments.Empty);
            

            ImageButton1.ImageUrl = "~\\img\\trans.png";
            LinkButton1.Text = "";
            lblPreco1.Text = "";
            lblGenero1.Text = "";
            lblLinha1.Text = "";
            divProd1.Attributes["class"] = "fundo-trans";   //divProd [class] é pra ativar o fundo branco na vitrine
            divProd11.Attributes["class"] = "fundo-trans";

            ImageButton2.ImageUrl = "~\\img\\trans.png";
            LinkButton2.Text = "";
            lblPreco2.Text = "";
            lblGenero2.Text = "";
            lblLinha2.Text = "";
            divProd2.Attributes["class"] = "fundo-trans";
            divProd22.Attributes["class"] = "fundo-trans";

            ImageButton3.ImageUrl = "~\\img\\trans.png";
            LinkButton3.Text = "";
            lblPreco3.Text = "";
            lblGenero3.Text = "";
            lblLinha3.Text = "";
            divProd3.Attributes["class"] = "fundo-trans";
            divProd33.Attributes["class"] = "fundo-trans";

            ImageButton4.ImageUrl = "~\\img\\trans.png";
            LinkButton4.Text = "";
            lblPreco4.Text = "";
            lblGenero4.Text = "";
            lblLinha4.Text = "";
            divProd4.Attributes["class"] = "fundo-trans";
            divProd44.Attributes["class"] = "fundo-trans";

            ImageButton5.ImageUrl = "~\\img\\trans.png";
            LinkButton5.Text = "";
            lblPreco5.Text = "";
            lblGenero5.Text = "";
            lblLinha5.Text = "";
            divProd5.Attributes["class"] = "fundo-trans";
            divProd55.Attributes["class"] = "fundo-trans";

            lbDesmarcar.Visible = false;



            if (dv.Table.Rows.Count != 0)
            {
                // contar quantos perfumes foram cadastrados
                qtdProd = dv.Table.Rows.Count;

                if (qtdProd >= 5)
                {
                    // sortear cinco perfumes
                    for (int i = 0; i < 5; )
                    {
                        qtdNumerosIguais = 0;

                        numeroSorteado = sequenciaProd.Next(qtdProd);

                       

                        for (int j = 0; j < i; j++)
                        {
                            if (numeroSorteado == pilhaProd[j])
                                qtdNumerosIguais++;
                        }

                        if (qtdNumerosIguais == 0)
                        {
                            pilhaProd[i] = numeroSorteado;
                            i++;
                        }
                    }
                }

                else
                {
                    pilhaProd[0] = 0;
                    pilhaProd[1] = 1;
                    pilhaProd[2] = 2;
                    pilhaProd[3] = 3;
                    pilhaProd[4] = 4;

                }

                ImageButton1.Visible = true;
                LinkButton1.Visible = true;
                lblPreco1.Visible = true;
                lblLinha1.Visible = true;
                lblGenero1.Visible = true;

                // exibindo a noticia 1 - ITEM 0 na tabela memoria
                Session["img1"] = dv.Table.Rows[pilhaProd[0]]["id_prod"].ToString();
                Session["linha1"] = dv.Table.Rows[pilhaProd[0]]["id_linha"].ToString();

               
                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dv.Table.Rows[pilhaProd[0]]["id_prod"].ToString();
                DataView dvpreco = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo1.Visible = true;
                    lblPrecoAntigo1.Text = "R$ " + precoFinalAdicional.ToString("#0.00");

                }
                

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                LinkButton1.Text = cripto.Decrypt(dv.Table.Rows[pilhaProd[0]]["nome_prod"].ToString());
                lblLinha1.Text = cripto.Decrypt(dv.Table.Rows[0]["tipo_linha"].ToString());
                lblGenero1.Text = cripto.Decrypt(dv.Table.Rows[0]["tipo_genero"].ToString());
                lblPreco1.Text = "R$ " + cripto.Decrypt(dv.Table.Rows[pilhaProd[0]]["valor_prod_final"].ToString());
                ImageButton1.ImageUrl = cripto.Decrypt(dv.Table.Rows[pilhaProd[0]]["img_prod"].ToString());
                
                divProd1.Attributes["class"] = "img-prod";
                divProd11.Attributes["class"] = "preco-prod";

                if (dv.Table.Rows.Count > 1)
                {

                    ImageButton2.Visible = true;
                    LinkButton2.Visible = true;
                    lblPreco2.Visible = true;
                    lblLinha2.Visible = true;
                    lblGenero2.Visible = true;

                    ImageButton2.ImageUrl = cripto.Decrypt(dv.Table.Rows[pilhaProd[1]]["img_prod"].ToString());
                    LinkButton2.Text = cripto.Decrypt(dv.Table.Rows[pilhaProd[1]]["nome_prod"].ToString());
                    Session["img2"] = dv.Table.Rows[pilhaProd[1]]["id_prod"].ToString();
                    Session["linha2"] = dv.Table.Rows[pilhaProd[1]]["id_linha"].ToString();
                    lblPreco2.Text = "R$ " + cripto.Decrypt(dv.Table.Rows[pilhaProd[1]]["valor_prod_final"].ToString());

                    //PESQUISA PROMOÇÃO EM VALOR
                    Session["pesquisaPreco"] = dv.Table.Rows[pilhaProd[1]]["id_prod"].ToString();
                    DataView dvpreco2 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                    precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valorUnid_prod"].ToString()));
                    precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_acrescimo"].ToString()));
                    precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_prod_final"].ToString()));

                    precoFinalAdicional = precoAdicional + precoUnid;

                    if (precoFinalAdicional > precoAtual)
                    {
                        lblPrecoAntigo2.Visible = true;
                        lblPrecoAntigo2.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                    }
                    
                    //DESCRIPTOGRAFAR /-GENERO -LINHA 
                    lblLinha2.Text = cripto.Decrypt(dv.Table.Rows[1]["tipo_linha"].ToString());
                    lblGenero2.Text = cripto.Decrypt(dv.Table.Rows[1]["tipo_genero"].ToString());

                    divProd2.Attributes["class"] = "img-prod";
                    divProd22.Attributes["class"] = "preco-prod";
                }

                if (dv.Table.Rows.Count > 2)
                {
                    ImageButton3.Visible = true;
                    LinkButton3.Visible = true;
                    lblPreco3.Visible = true;
                    lblLinha3.Visible = true;
                    lblGenero3.Visible = true;

                    ImageButton3.ImageUrl = cripto.Decrypt(dv.Table.Rows[pilhaProd[2]]["img_prod"].ToString());
                    LinkButton3.Text =cripto.Decrypt( dv.Table.Rows[pilhaProd[2]]["nome_prod"].ToString());
                    Session["img3"] = dv.Table.Rows[pilhaProd[2]]["id_prod"].ToString();
                    Session["linha3"] = dv.Table.Rows[pilhaProd[2]]["id_linha"].ToString();
                    lblPreco3.Text = "R$" +  cripto.Decrypt(dv.Table.Rows[pilhaProd[2]]["valor_prod_final"].ToString());

                    //DESCRIPTOGRAFAR /-GENERO -LINHA 
                    lblLinha3.Text = cripto.Decrypt(dv.Table.Rows[2]["tipo_linha"].ToString());
                    lblGenero3.Text = cripto.Decrypt(dv.Table.Rows[2]["tipo_genero"].ToString());

                    //PESQUISA PROMOÇÃO EM VALOR
                    Session["pesquisaPreco"] = dv.Table.Rows[pilhaProd[2]]["id_prod"].ToString();
                    DataView dvpreco3 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                    precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valorUnid_prod"].ToString()));
                    precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_acrescimo"].ToString()));
                    precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_prod_final"].ToString()));

                    precoFinalAdicional = precoAdicional + precoUnid;

                    if (precoFinalAdicional > precoAtual)
                    {
                        lblPrecoAntigo3.Visible = true;
                        lblPrecoAntigo3.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                    }

                    divProd3.Attributes["class"] = "img-prod";
                    divProd33.Attributes["class"] = "preco-prod";
                }

                if (dv.Table.Rows.Count > 3)
                {

                    ImageButton4.Visible = true;
                    LinkButton4.Visible = true;
                    lblPreco4.Visible = true;
                    lblLinha4.Visible = true;
                    lblGenero4.Visible = true;

                    ImageButton4.ImageUrl = cripto.Decrypt(dv.Table.Rows[pilhaProd[3]]["img_prod"].ToString());
                    LinkButton4.Text = cripto.Decrypt(dv.Table.Rows[pilhaProd[3]]["nome_prod"].ToString());
                    Session["img4"] = dv.Table.Rows[pilhaProd[3]]["id_prod"].ToString();
                    Session["linha4"] = dv.Table.Rows[pilhaProd[3]]["id_linha"].ToString();
                    lblPreco4.Text = "R$" +  cripto.Decrypt(dv.Table.Rows[pilhaProd[3]]["valor_prod_final"].ToString());

                    //PESQUISA PROMOÇÃO EM VALOR
                    Session["pesquisaPreco"] = dv.Table.Rows[pilhaProd[1]]["id_prod"].ToString();
                    DataView dvpreco4 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                    precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valorUnid_prod"].ToString()));
                    precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_acrescimo"].ToString()));
                    precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_prod_final"].ToString()));

                    precoFinalAdicional = precoAdicional + precoUnid;

                    if (precoFinalAdicional > precoAtual)
                    {
                        lblPrecoAntigo4.Visible = true;
                        lblPrecoAntigo4.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                    }

                    //DESCRIPTOGRAFAR /-GENERO -LINHA 
                    lblLinha4.Text = cripto.Decrypt(dv.Table.Rows[3]["tipo_linha"].ToString());
                    lblGenero4.Text = cripto.Decrypt(dv.Table.Rows[3]["tipo_genero"].ToString());

                    divProd4.Attributes["class"] = "img-prod";
                    divProd44.Attributes["class"] = "preco-prod";
                }

                if (dv.Table.Rows.Count > 4)
                {
                    ImageButton5.Visible = true;
                    LinkButton5.Visible = true;
                    lblPreco5.Visible = true;
                    lblLinha5.Visible = true;
                    lblGenero5.Visible = true;

                    ImageButton5.ImageUrl = cripto.Decrypt(dv.Table.Rows[pilhaProd[4]]["img_prod"].ToString());
                    LinkButton5.Text = cripto.Decrypt(dv.Table.Rows[pilhaProd[4]]["nome_prod"].ToString());
                    Session["img5"] = dv.Table.Rows[pilhaProd[4]]["id_prod"].ToString();
                    Session["linha5"] = dv.Table.Rows[pilhaProd[4]]["id_linha"].ToString();
                    lblPreco5.Text = "R$" +  cripto.Decrypt(dv.Table.Rows[pilhaProd[4]]["valor_prod_final"].ToString());

                    //PESQUISA PROMOÇÃO EM VALOR
                    Session["pesquisaPreco"] = dv.Table.Rows[pilhaProd[4]]["id_prod"].ToString();
                    DataView dvpreco5 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                    precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valorUnid_prod"].ToString()));
                    precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_acrescimo"].ToString()));
                    precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_prod_final"].ToString()));

                    precoFinalAdicional = precoAdicional + precoUnid;

                    if (precoFinalAdicional > precoAtual)
                    {
                        lblPrecoAntigo5.Visible = true;
                        lblPrecoAntigo5.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                    }

                    //DESCRIPTOGRAFAR /-GENERO -LINHA 
                    lblLinha5.Text = cripto.Decrypt(dv.Table.Rows[4]["tipo_linha"].ToString());
                    lblGenero5.Text = cripto.Decrypt(dv.Table.Rows[4]["tipo_genero"].ToString());

                    divProd5.Attributes["class"] = "img-prod";
                    divProd55.Attributes["class"] = "preco-prod";
                }

            }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Session["imgEscolhida"] = Session["img1"];
        Session["linhaEscolhida"] = Session["linha1"];
        Response.Redirect("produto.aspx");
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session["imgEscolhida"] = Session["img1"];
        Session["linhaEscolhida"] = Session["linha1"];
        Response.Redirect("produto.aspx");
    }

    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        Session["imgEscolhida"] = Session["img2"];
        Session["linhaEscolhida"] = Session["linha2"];
        Response.Redirect("produto.aspx");
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Session["imgEscolhida"] = Session["img2"];
        Session["linhaEscolhida"] = Session["linha2"];
        Response.Redirect("produto.aspx");
    }

    protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
    {
        Session["imgEscolhida"] = Session["img3"];
        Session["linhaEscolhida"] = Session["linha3"];
        Response.Redirect("produto.aspx");
    }

    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        Session["imgEscolhida"] = Session["img3"];
        Session["linhaEscolhida"] = Session["linha3"];
        Response.Redirect("produto.aspx");
    }

    protected void ImageButton4_Click(object sender, ImageClickEventArgs e)
    {
        Session["imgEscolhida"] = Session["img4"];
        Session["linhaEscolhida"] = Session["linha4"];
        Response.Redirect("produto.aspx");
    }

    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        Session["imgEscolhida"] = Session["img4"];
        Session["linhaEscolhida"] = Session["linha4"];
        Response.Redirect("produto.aspx");
    }

    protected void ImageButton5_Click(object sender, ImageClickEventArgs e)
    {
        Session["imgEscolhida"] = Session["img5"];
        Session["linhaEscolhida"] = Session["linha5"];
        Response.Redirect("produto.aspx");
    }

    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        Session["imgEscolhida"] = Session["img5"];
        Session["linhaEscolhida"] = Session["linha5"];
        Response.Redirect("produto.aspx");
    }

    protected void carreagarGenero(DataView dv)
    {

        lblPrecoAntigo1.Visible = false;
        ImageButton1.Visible = false;
        LinkButton1.Visible = false;
        lblPreco1.Visible = false;
        lblLinha1.Visible = false;
        lblGenero1.Visible = false;
        divProd1.Attributes["class"] = "fundo-trans";
        divProd11.Attributes["class"] = "fundo-trans";


        lblPrecoAntigo2.Visible = false;
        ImageButton2.Visible = false;
        LinkButton2.Visible = false;
        lblPreco2.Visible = false;
        lblLinha2.Visible = false;
        lblGenero2.Visible = false;
        divProd2.Attributes["class"] = "fundo-trans";
        divProd22.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo3.Visible = false;
        ImageButton3.Visible = false;
        LinkButton3.Visible = false;
        lblPreco3.Visible = false;
        lblLinha3.Visible = false;
        lblGenero3.Visible = false;
        divProd3.Attributes["class"] = "fundo-trans";
        divProd33.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo4.Visible = false;
        ImageButton4.Visible = false;
        LinkButton4.Visible = false;
        lblPreco4.Visible = false;
        lblLinha4.Visible = false;
        lblGenero4.Visible = false;
        divProd4.Attributes["class"] = "fundo-trans";
        divProd44.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo5.Visible = false;
        ImageButton5.Visible = false;
        LinkButton5.Visible = false;
        lblPreco5.Visible = false;
        lblLinha5.Visible = false;
        lblGenero5.Visible = false;
        divProd5.Attributes["class"] = "fundo-trans";
        divProd55.Attributes["class"] = "fundo-trans";


        int linhas = dv.Table.Rows.Count;


        if (linhas != 0)
        {
            ImageButton1.Visible = true;
            LinkButton1.Visible = true;
            lblPreco1.Visible = true;
            lblLinha1.Visible = true;
            lblGenero1.Visible = true;


            //DESCRIPTOGRAFAR /-GENERO -LINHA 
            lblLinha1.Text = cripto.Decrypt(dv.Table.Rows[0]["tipo_linha"].ToString());
            lblGenero1.Text = cripto.Decrypt(dv.Table.Rows[0]["tipo_genero"].ToString());

            ImageButton1.ImageUrl = cripto.Decrypt(dv.Table.Rows[0]["img_prod"].ToString());
            LinkButton1.Text = cripto.Decrypt(dv.Table.Rows[0]["nome_prod"].ToString());
            Session["img1"] = dv.Table.Rows[0]["id_prod"].ToString();
            Session["linha1"] = dv.Table.Rows[0]["id_linha"].ToString();
            
            lblPreco1.Text = "R$" + cripto.Decrypt(dv.Table.Rows[0]["valor_prod_final"].ToString());

            //PESQUISA PROMOÇÃO EM VALOR
            Session["pesquisaPreco"] = dv.Table.Rows[0]["id_prod"].ToString();
            DataView dvpreco1 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
            precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valorUnid_prod"].ToString()));
            precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_acrescimo"].ToString()));
            precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_prod_final"].ToString()));

            precoFinalAdicional = precoAdicional + precoUnid;

            if (precoFinalAdicional > precoAtual)
            {
                lblPrecoAntigo1.Visible = true;
                lblPrecoAntigo1.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
            }

            divProd1.Attributes["class"] = "img-prod";
            divProd11.Attributes["class"] = "preco-prod";

            if (linhas > 1)
            {
                ImageButton2.Visible = true;
                LinkButton2.Visible = true;
                lblPreco2.Visible = true;
                lblLinha2.Visible = true;
                lblGenero2.Visible = true;


                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha2.Text = cripto.Decrypt(dv.Table.Rows[1]["tipo_linha"].ToString());
                lblGenero2.Text = cripto.Decrypt(dv.Table.Rows[1]["tipo_genero"].ToString());

                ImageButton2.ImageUrl = cripto.Decrypt(dv.Table.Rows[1]["img_prod"].ToString());
                LinkButton2.Text = cripto.Decrypt(dv.Table.Rows[1]["nome_prod"].ToString());
                Session["img2"] = dv.Table.Rows[1]["id_prod"].ToString();
                Session["linha2"] = dv.Table.Rows[1]["id_linha"].ToString();
                lblPreco2.Text = "R$" + cripto.Decrypt(dv.Table.Rows[1]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dv.Table.Rows[1]["id_prod"].ToString();
                DataView dvpreco2 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo2.Visible = true;
                    lblPrecoAntigo2.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                divProd2.Attributes["class"] = "img-prod";
                divProd22.Attributes["class"] = "preco-prod";

                if (linhas > 2)
                {
                    ImageButton3.Visible = true;
                    LinkButton3.Visible = true;
                    lblPreco3.Visible = true;
                    lblLinha3.Visible = true;
                    lblGenero3.Visible = true;

                    //DESCRIPTOGRAFAR /-GENERO -LINHA 
                    lblLinha3.Text = cripto.Decrypt(dv.Table.Rows[2]["tipo_linha"].ToString());
                    lblGenero3.Text = cripto.Decrypt(dv.Table.Rows[2]["tipo_genero"].ToString());

                    ImageButton3.ImageUrl = cripto.Decrypt(dv.Table.Rows[2]["img_prod"].ToString());
                    LinkButton3.Text = cripto.Decrypt(dv.Table.Rows[2]["nome_prod"].ToString());
                    Session["img3"] = dv.Table.Rows[2]["id_prod"].ToString();
                    Session["linha3"] = dv.Table.Rows[2]["id_linha"].ToString();
                    lblPreco3.Text = "R$" + cripto.Decrypt(dv.Table.Rows[2]["valor_prod_final"].ToString());


                    //PESQUISA PROMOÇÃO EM VALOR
                    Session["pesquisaPreco"] = dv.Table.Rows[2]["id_prod"].ToString();
                    DataView dvpreco3 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                    precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valorUnid_prod"].ToString()));
                    precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_acrescimo"].ToString()));
                    precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_prod_final"].ToString()));

                    precoFinalAdicional = precoAdicional + precoUnid;

                    if (precoFinalAdicional > precoAtual)
                    {
                        lblPrecoAntigo3.Visible = true;
                        lblPrecoAntigo3.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                    }

                    divProd3.Attributes["class"] = "img-prod";
                    divProd33.Attributes["class"] = "preco-prod";

                    if (linhas > 3)
                    {
                        ImageButton4.Visible = true;
                        LinkButton4.Visible = true;
                        lblPreco4.Visible = true;
                        lblLinha4.Visible = true;
                        lblGenero4.Visible = true;

                        //DESCRIPTOGRAFAR /-GENERO -LINHA 
                        lblLinha4.Text = cripto.Decrypt(dv.Table.Rows[3]["tipo_linha"].ToString());
                        lblGenero4.Text = cripto.Decrypt(dv.Table.Rows[3]["tipo_genero"].ToString());

                        ImageButton4.ImageUrl = cripto.Decrypt(dv.Table.Rows[3]["img_prod"].ToString());
                        LinkButton4.Text = cripto.Decrypt(dv.Table.Rows[3]["nome_prod"].ToString());
                        Session["img4"] = dv.Table.Rows[3]["id_prod"].ToString();
                        Session["linha4"] = dv.Table.Rows[3]["id_linha"].ToString();
                        lblPreco4.Text = "R$" + cripto.Decrypt(dv.Table.Rows[3]["valor_prod_final"].ToString());


                        //PESQUISA PROMOÇÃO EM VALOR
                        Session["pesquisaPreco"] = dv.Table.Rows[3]["id_prod"].ToString();
                        DataView dvpreco4 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                        precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valorUnid_prod"].ToString()));
                        precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_acrescimo"].ToString()));
                        precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_prod_final"].ToString()));

                        precoFinalAdicional = precoAdicional + precoUnid;

                        if (precoFinalAdicional > precoAtual)
                        {
                            lblPrecoAntigo4.Visible = true;
                            lblPrecoAntigo4.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                        }

                        divProd4.Attributes["class"] = "img-prod";
                        divProd44.Attributes["class"] = "preco-prod";

                        if (linhas > 4)
                        {
                            ImageButton5.Visible = true;
                            LinkButton5.Visible = true;
                            lblPreco5.Visible = true;
                            lblLinha5.Visible = true;
                            lblGenero5.Visible = true;

                            //DESCRIPTOGRAFAR /-GENERO -LINHA 
                            lblLinha5.Text = cripto.Decrypt(dv.Table.Rows[4]["tipo_linha"].ToString());
                            lblGenero5.Text = cripto.Decrypt(dv.Table.Rows[4]["tipo_genero"].ToString());

                            ImageButton5.ImageUrl = cripto.Decrypt(dv.Table.Rows[4]["img_prod"].ToString());
                            LinkButton5.Text = cripto.Decrypt(dv.Table.Rows[4]["nome_prod"].ToString());
                            Session["img5"] = dv.Table.Rows[4]["id_prod"].ToString();
                            Session["linha5"] = dv.Table.Rows[4]["id_linha"].ToString();
                            lblPreco5.Text = "R$" + cripto.Decrypt(dv.Table.Rows[4]["valor_prod_final"].ToString());



                            //PESQUISA PROMOÇÃO EM VALOR
                            Session["pesquisaPreco"] = dv.Table.Rows[4]["id_prod"].ToString();
                            DataView dvpreco5 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                            precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valorUnid_prod"].ToString()));
                            precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_acrescimo"].ToString()));
                            precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_prod_final"].ToString()));

                            precoFinalAdicional = precoAdicional + precoUnid;

                            if (precoFinalAdicional > precoAtual)
                            {
                                lblPrecoAntigo5.Visible = true;
                                lblPrecoAntigo5.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                            }

                            divProd5.Attributes["class"] = "img-prod";
                            divProd55.Attributes["class"] = "preco-prod";
                        }
                    }
                }
            }
        }

    }

    protected void rbGenero_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["img1"] = null;
        Session["img2"] = null;
        Session["img3"] = null;
        Session["img4"] = null;
        Session["img5"] = null;

        Session["linha1"] = null;
        Session["linha2"] = null;
        Session["linha3"] = null;
        Session["linha4"] = null;
        Session["linha5"] = null;

        // A PRIMEIRA APARECE COMO SEM IMAGEM
        divProd11.Attributes["class"] = "fundo-trans";
        lblPrecoAntigo1.Visible = false;

        lblPrecoAntigo2.Visible = false;
        ImageButton2.Visible = false;
        LinkButton2.Visible = false;
        lblPreco2.Visible = false;
        lblLinha2.Visible = false;
        lblGenero2.Visible = false;
        divProd2.Attributes["class"] = "fundo-trans";
        divProd22.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo3.Visible = false;
        ImageButton3.Visible = false;
        LinkButton3.Visible = false;
        lblPreco3.Visible = false;
        lblLinha3.Visible = false;
        lblGenero3.Visible = false;
        divProd3.Attributes["class"] = "fundo-trans";
        divProd33.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo4.Visible = false;
        ImageButton4.Visible = false;
        LinkButton4.Visible = false;
        lblPreco4.Visible = false;
        lblLinha4.Visible = false;
        lblGenero4.Visible = false;
        divProd4.Attributes["class"] = "fundo-trans";
        divProd44.Attributes["class"] = "fundo-trans";
        
        lblPrecoAntigo5.Visible = false;
        ImageButton5.Visible = false;
        LinkButton5.Visible = false;
        lblPreco5.Visible = false;
        lblLinha5.Visible = false;
        lblGenero5.Visible = false;
        divProd5.Attributes["class"] = "fundo-trans";
        divProd55.Attributes["class"] = "fundo-trans";

        lbDesmarcar.Visible = true;
       // Session["lbDesG"] = "sim";

        

        if (IsPostBack == true)
        {
            //SEM IMAGEM
            ImageButton1.Visible = true;
            divProd1.Attributes["class"] = "img-prod";
            ImageButton1.ImageUrl = "~\\img\\sem-imagem.png";
            LinkButton1.Text = "";
            lblPreco1.Text = "";
            lblLinha1.Text = "";
            lblGenero1.Text = "";

            try
            {
                 //FEMININOS
                if (rbGenero.SelectedIndex == 0)
                {
                    if (rbLinha.SelectedIndex == -1)
                    {
                        Session["sexo"] = "1";
                        DataView dv = (DataView)sqlGenero.Select(DataSourceSelectArguments.Empty);
                        carreagarGenero(dv);
                        
                    }
                    else
                    {
                        DataView dvFeminino;
                        dvFeminino = (DataView)sqlPerfumePorLinhaEFeminino.Select(DataSourceSelectArguments.Empty);
                        carregarLinhaEFeminino(dvFeminino);
                        
                    }
                }

                //MASCULINOS
                if (rbGenero.SelectedIndex == 1)
                {
                    if (rbLinha.SelectedIndex == -1)
                    {
                        Session["sexo"] = "2";
                        DataView dv = (DataView)sqlGenero.Select(DataSourceSelectArguments.Empty);
                        carreagarGenero(dv);
                    }
                    else
                    {

                        DataView dvMasc;
                        dvMasc = (DataView)sqlPerfumePorLinhaEMasculino.Select(DataSourceSelectArguments.Empty);
                        carregarLinhaEMasculino(dvMasc);
                    }
                }

            }
            catch { }

        }

    }





    protected void rbLinha_SelectedIndexChanged(object sender, EventArgs e)
    {
        //limpando as Session´s para buscar os produtos do BD
        Session["img1"] = null;
        Session["img2"] = null;
        Session["img3"] = null;
        Session["img4"] = null;
        Session["img5"] = null;


        Session["linha1"] = null;
        Session["linha2"] = null;
        Session["linha3"] = null;
        Session["linha4"] = null;
        Session["linha5"] = null;


        // A PRIMEIRA APARECE COMO SEM IMAGEM
        divProd11.Attributes["class"] = "fundo-trans";
        lblPrecoAntigo1.Visible = false;


        lblPrecoAntigo2.Visible = false;
        ImageButton2.Visible = false;
        LinkButton2.Visible = false;
        lblPreco2.Visible = false;
        lblLinha2.Visible = false;
        lblGenero2.Visible = false;
        divProd2.Attributes["class"] = "fundo-trans";
        divProd22.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo3.Visible = false;
        ImageButton3.Visible = false;
        LinkButton3.Visible = false;
        lblPreco3.Visible = false;
        lblLinha3.Visible = false;
        lblGenero3.Visible = false;
        divProd3.Attributes["class"] = "fundo-trans";
        divProd33.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo4.Visible = false;
        ImageButton4.Visible = false;
        LinkButton4.Visible = false;
        lblPreco4.Visible = false;
        lblLinha4.Visible = false;
        lblGenero4.Visible = false;
        divProd4.Attributes["class"] = "fundo-trans";
        divProd44.Attributes["class"] = "fundo-trans";

        lblPrecoAntigo5.Visible = false;
        ImageButton5.Visible = false;
        LinkButton5.Visible = false;
        lblPreco5.Visible = false;
        lblLinha5.Visible = false;
        lblGenero5.Visible = false;
        divProd5.Attributes["class"] = "fundo-trans";
        divProd55.Attributes["class"] = "fundo-trans";

        lbDesmarcar.Visible = true;
        Session["lbDesL"] = "sim";

        

        if (IsPostBack == true)
        {
            //SEM IMAGEM
            ImageButton1.Visible = true;
            divProd1.Attributes["class"] = "img-prod";
            ImageButton1.ImageUrl = "~\\img\\sem-imagem.png";
            LinkButton1.Text = "";
            lblPreco1.Text = "";
            lblLinha1.Text = "";
            lblGenero1.Text = "";



            if (rbGenero.SelectedIndex == 0 || rbGenero.SelectedIndex == 1)
            {

                //CARREGAR FEMININOS
                if (rbGenero.SelectedIndex == 0)
                {
                    DataView dvFeminino;
                    dvFeminino = (DataView)sqlPerfumePorLinhaEFeminino.Select(DataSourceSelectArguments.Empty);

                    carregarLinhaEFeminino(dvFeminino);
                }

               //CARREGAR MASCULINOS!
                else
                {
                    DataView dvMasc;
                    dvMasc = (DataView)sqlPerfumePorLinhaEMasculino.Select(DataSourceSelectArguments.Empty);

                    carregarLinhaEMasculino(dvMasc);
                }
            }

            //CARREGAR TODOS DE ACORDO COM A LINHA!!
            else
            {
                DataView dv2 = (DataView)sqlPerfumePorLinha.Select(DataSourceSelectArguments.Empty);

                carregarPorLinha(dv2);
            }

        }
    }

    protected void carregarLinhaEFeminino(DataView dvFeminino)
    {
        // exibindo imagens de "vazio"
        if (dvFeminino.Table.Rows.Count != 0)
        {
            // exibindo o perfume 1 - ITEM 0 na tabela memoria
            ImageButton1.ImageUrl = cripto.Decrypt(dvFeminino.Table.Rows[0]["img_prod"].ToString());
            LinkButton1.Text = cripto.Decrypt(dvFeminino.Table.Rows[0]["nome_prod"].ToString());
            Session["img1"] = dvFeminino.Table.Rows[0]["id_prod"].ToString();
            Session["linha1"] = dvFeminino.Table.Rows[0]["id_linha"].ToString();
            lblPreco1.Text = "R$" + cripto.Decrypt(dvFeminino.Table.Rows[0]["valor_prod_final"].ToString());


            //PESQUISA PROMOÇÃO EM VALOR
            Session["pesquisaPreco"] = dvFeminino.Table.Rows[0]["id_prod"].ToString();
            DataView dvpreco1 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
            precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valorUnid_prod"].ToString()));
            precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_acrescimo"].ToString()));
            precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_prod_final"].ToString()));

            precoFinalAdicional = precoAdicional + precoUnid;

            lblPrecoAntigo1.Visible = true;
            if (precoFinalAdicional > precoAtual)
            {
                lblPrecoAntigo1.Visible = true;
                lblPrecoAntigo1.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
            }

            //DESCRIPTOGRAFAR /-GENERO -LINHA 
            lblLinha1.Text = cripto.Decrypt(dvFeminino.Table.Rows[0]["tipo_linha"].ToString());
            lblGenero1.Text = cripto.Decrypt(dvFeminino.Table.Rows[0]["tipo_genero"].ToString());
            

            ImageButton1.Visible = true;
            LinkButton1.Visible = true;
            lblPreco1.Visible = true;
            lblLinha1.Visible = true;
            lblGenero1.Visible = true;

            divProd1.Attributes["class"] = "img-prod";
            divProd11.Attributes["class"] = "preco-prod";

            if (dvFeminino.Table.Rows.Count > 1)
            {
                ImageButton2.ImageUrl = cripto.Decrypt(dvFeminino.Table.Rows[1]["img_prod"].ToString());
                LinkButton2.Text = cripto.Decrypt(dvFeminino.Table.Rows[1]["nome_prod"].ToString());
                Session["img2"] = dvFeminino.Table.Rows[1]["id_prod"].ToString();
                Session["linha2"] = dvFeminino.Table.Rows[1]["id_linha"].ToString();
                lblPreco2.Text = "R$" + cripto.Decrypt(dvFeminino.Table.Rows[1]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvFeminino.Table.Rows[1]["id_prod"].ToString();
                DataView dvpreco2 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo2.Visible = true;
                    lblPrecoAntigo2.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }


                
                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha2.Text = cripto.Decrypt(dvFeminino.Table.Rows[1]["tipo_linha"].ToString());
                lblGenero2.Text = cripto.Decrypt(dvFeminino.Table.Rows[1]["tipo_genero"].ToString());
            

                ImageButton2.Visible = true;
                LinkButton2.Visible = true;
                lblPreco2.Visible = true;
                lblLinha2.Visible = true;
                lblGenero2.Visible = true;

                divProd2.Attributes["class"] = "img-prod";
                divProd22.Attributes["class"] = "preco-prod";
            }

            if (dvFeminino.Table.Rows.Count > 2)
            {
                ImageButton3.ImageUrl = cripto.Decrypt(dvFeminino.Table.Rows[2]["img_prod"].ToString());
                LinkButton3.Text = cripto.Decrypt(dvFeminino.Table.Rows[2]["nome_prod"].ToString());
                Session["img3"] = dvFeminino.Table.Rows[2]["id_prod"].ToString();
                Session["linha3"] = dvFeminino.Table.Rows[2]["id_linha"].ToString();
                lblPreco3.Text = "R$" + cripto.Decrypt(dvFeminino.Table.Rows[2]["valor_prod_final"].ToString());


                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvFeminino.Table.Rows[2]["id_prod"].ToString();
                DataView dvpreco3 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo3.Visible = true;
                    lblPrecoAntigo3.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha3.Text = cripto.Decrypt(dvFeminino.Table.Rows[2]["tipo_linha"].ToString());
                lblGenero3.Text = cripto.Decrypt(dvFeminino.Table.Rows[2]["tipo_genero"].ToString());
            

                ImageButton3.Visible = true;
                LinkButton3.Visible = true;
                lblPreco3.Visible = true;
                lblLinha3.Visible = true;
                lblGenero3.Visible = true;

                divProd3.Attributes["class"] = "img-prod";
                divProd33.Attributes["class"] = "preco-prod";
            }

            if (dvFeminino.Table.Rows.Count > 3)
            {
                ImageButton4.ImageUrl = cripto.Decrypt(dvFeminino.Table.Rows[3]["img_prod"].ToString());
                LinkButton4.Text = cripto.Decrypt(dvFeminino.Table.Rows[3]["nome_prod"].ToString());
                Session["img4"] = dvFeminino.Table.Rows[3]["id_prod"].ToString();
                Session["linha4"] = dvFeminino.Table.Rows[3]["id_linha"].ToString();
                lblPreco4.Text = "R$" + cripto.Decrypt(dvFeminino.Table.Rows[3]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvFeminino.Table.Rows[3]["id_prod"].ToString();
                DataView dvpreco4 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo4.Visible = true;
                    lblPrecoAntigo4.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }


                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha4.Text = cripto.Decrypt(dvFeminino.Table.Rows[3]["tipo_linha"].ToString());
                lblGenero4.Text = cripto.Decrypt(dvFeminino.Table.Rows[3]["tipo_genero"].ToString());
            

                ImageButton4.Visible = true;
                LinkButton4.Visible = true;
                lblPreco4.Visible = true;
                lblLinha4.Visible = true;
                lblGenero4.Visible = true;

                divProd4.Attributes["class"] = "img-prod";
                divProd44.Attributes["class"] = "preco-prod";
            }

            if (dvFeminino.Table.Rows.Count > 4)
            {
                ImageButton5.ImageUrl = cripto.Decrypt(dvFeminino.Table.Rows[4]["img_prod"].ToString());
                LinkButton5.Text = cripto.Decrypt(dvFeminino.Table.Rows[4]["nome_prod"].ToString());
                Session["img5"] = dvFeminino.Table.Rows[4]["id_prod"].ToString();
                Session["linha5"] = dvFeminino.Table.Rows[4]["id_linha"].ToString();
                lblPreco5.Text = "R$" + cripto.Decrypt(dvFeminino.Table.Rows[4]["valor_prod_final"].ToString());


                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvFeminino.Table.Rows[4]["id_prod"].ToString();
                DataView dvpreco5 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo5.Visible = true;
                    lblPrecoAntigo5.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha5.Text = cripto.Decrypt(dvFeminino.Table.Rows[4]["tipo_linha"].ToString());
                lblGenero5.Text = cripto.Decrypt(dvFeminino.Table.Rows[4]["tipo_genero"].ToString());
            

                ImageButton5.Visible = true;
                LinkButton5.Visible = true;
                lblPreco5.Visible = true;
                lblLinha5.Visible = true;
                lblGenero5.Visible = true;
                divProd5.Attributes["class"] = "img-prod";
                divProd55.Attributes["class"] = "preco-prod";
            }
        }
    }

    protected void carregarLinhaEMasculino(DataView dvMasc)
    {
        // exibindo imagens de "vazio"
        if (dvMasc.Table.Rows.Count != 0)
        {
            // exibindo o perfume 1 - ITEM 0 na tabela memoria
            ImageButton1.ImageUrl = cripto.Decrypt(dvMasc.Table.Rows[0]["img_prod"].ToString());
            LinkButton1.Text = cripto.Decrypt(dvMasc.Table.Rows[0]["nome_prod"].ToString());
            Session["img1"] = dvMasc.Table.Rows[0]["id_prod"].ToString();
            Session["linha1"] = dvMasc.Table.Rows[0]["id_linha"].ToString();
            lblPreco1.Text = "R$" + cripto.Decrypt(dvMasc.Table.Rows[0]["valor_prod_final"].ToString());

            //PESQUISA PROMOÇÃO EM VALOR
            Session["pesquisaPreco"] = dvMasc.Table.Rows[0]["id_prod"].ToString();
            DataView dvpreco1 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
            precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valorUnid_prod"].ToString()));
            precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_acrescimo"].ToString()));
            precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_prod_final"].ToString()));

            precoFinalAdicional = precoAdicional + precoUnid;

            lblPrecoAntigo1.Visible = false;
            if (precoFinalAdicional > precoAtual)
            {
                lblPrecoAntigo1.Visible = true;
                lblPrecoAntigo1.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
            }

            //DESCRIPTOGRAFAR /-GENERO -LINHA 
            lblLinha1.Text = cripto.Decrypt(dvMasc.Table.Rows[0]["tipo_linha"].ToString());
            lblGenero1.Text = cripto.Decrypt(dvMasc.Table.Rows[0]["tipo_genero"].ToString());
            

            ImageButton1.Visible = true;
            LinkButton1.Visible = true;
            lblPreco1.Visible = true;
            lblLinha1.Visible = true;
            lblGenero1.Visible = true;

            divProd1.Attributes["class"] = "img-prod";
            divProd11.Attributes["class"] = "preco-prod";

            if (dvMasc.Table.Rows.Count > 1)
            {
                ImageButton2.ImageUrl = cripto.Decrypt(dvMasc.Table.Rows[1]["img_prod"].ToString());
                LinkButton2.Text = cripto.Decrypt(dvMasc.Table.Rows[1]["nome_prod"].ToString());
                Session["img2"] = dvMasc.Table.Rows[1]["id_prod"].ToString();
                Session["linha2"] = dvMasc.Table.Rows[1]["id_linha"].ToString();
                lblPreco2.Text = "R$" + cripto.Decrypt(dvMasc.Table.Rows[1]["valor_prod_final"].ToString());


                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvMasc.Table.Rows[1]["id_prod"].ToString();
                DataView dvpreco2 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;
                
                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo2.Visible = true;
                    lblPrecoAntigo2.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha2.Text = cripto.Decrypt(dvMasc.Table.Rows[1]["tipo_linha"].ToString());
                lblGenero2.Text = cripto.Decrypt(dvMasc.Table.Rows[1]["tipo_genero"].ToString());
               
                ImageButton2.Visible = true;
                LinkButton2.Visible = true;
                lblPreco2.Visible = true;
                lblLinha2.Visible = true;
                lblGenero2.Visible = true;

                divProd2.Attributes["class"] = "img-prod";
                divProd22.Attributes["class"] = "preco-prod";
            }

            if (dvMasc.Table.Rows.Count > 2)
            {
                ImageButton3.ImageUrl = cripto.Decrypt(dvMasc.Table.Rows[2]["img_prod"].ToString());
                LinkButton3.Text = cripto.Decrypt(dvMasc.Table.Rows[2]["nome_prod"].ToString());
                Session["img3"] = dvMasc.Table.Rows[2]["id_prod"].ToString();
                Session["linha3"] = dvMasc.Table.Rows[2]["id_linha"].ToString();
                lblPreco3.Text = "R$" + cripto.Decrypt(dvMasc.Table.Rows[2]["valor_prod_final"].ToString());


                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvMasc.Table.Rows[2]["id_prod"].ToString();
                DataView dvpreco3 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo3.Visible = true;
                    lblPrecoAntigo3.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha3.Text = cripto.Decrypt(dvMasc.Table.Rows[2]["tipo_linha"].ToString());
                lblGenero3.Text = cripto.Decrypt(dvMasc.Table.Rows[2]["tipo_genero"].ToString());
             

                ImageButton3.Visible = true;
                LinkButton3.Visible = true;
                lblPreco3.Visible = true;
                lblLinha3.Visible = true;
                lblGenero3.Visible = true;

                divProd3.Attributes["class"] = "img-prod";
                divProd33.Attributes["class"] = "preco-prod";
            }

            if (dvMasc.Table.Rows.Count > 3)
            {
                ImageButton4.ImageUrl = cripto.Decrypt(dvMasc.Table.Rows[3]["img_prod"].ToString());
                LinkButton4.Text = cripto.Decrypt(dvMasc.Table.Rows[3]["nome_prod"].ToString());
                Session["img4"] = dvMasc.Table.Rows[3]["id_prod"].ToString();
                Session["linha4"] = dvMasc.Table.Rows[3]["id_linha"].ToString();
                lblPreco4.Text = "R$" + cripto.Decrypt(dvMasc.Table.Rows[3]["valor_prod_final"].ToString());


                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvMasc.Table.Rows[3]["id_prod"].ToString();
                DataView dvpreco4 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo4.Visible = true;
                    lblPrecoAntigo4.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha4.Text = cripto.Decrypt(dvMasc.Table.Rows[3]["tipo_linha"].ToString());
                lblGenero4.Text = cripto.Decrypt(dvMasc.Table.Rows[3]["tipo_genero"].ToString());
             

                ImageButton4.Visible = true;
                LinkButton4.Visible = true;
                lblPreco4.Visible = true;
                lblLinha4.Visible = true;
                lblGenero4.Visible = true;

                divProd4.Attributes["class"] = "img-prod";
                divProd44.Attributes["class"] = "preco-prod";
            }

            if (dvMasc.Table.Rows.Count > 4)
            {
                ImageButton5.ImageUrl = cripto.Decrypt(dvMasc.Table.Rows[4]["img_prod"].ToString());
                LinkButton5.Text = cripto.Decrypt(dvMasc.Table.Rows[4]["nome_prod"].ToString());
                Session["img5"] = dvMasc.Table.Rows[4]["id_prod"].ToString();
                Session["linha5"] = dvMasc.Table.Rows[4]["id_linha"].ToString();
                lblPreco5.Text = "R$" + cripto.Decrypt(dvMasc.Table.Rows[4]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dvMasc.Table.Rows[4]["id_prod"].ToString();
                DataView dvpreco5 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;

                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo5.Visible = true;
                    lblPrecoAntigo5.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha5.Text = cripto.Decrypt(dvMasc.Table.Rows[4]["tipo_linha"].ToString());
                lblGenero5.Text = cripto.Decrypt(dvMasc.Table.Rows[4]["tipo_genero"].ToString());
             

                ImageButton5.Visible = true;
                LinkButton5.Visible = true;
                lblPreco5.Visible = true;
                lblLinha5.Visible = true;
                lblGenero5.Visible = true;

                divProd5.Attributes["class"] = "img-prod";
                divProd55.Attributes["class"] = "preco-prod";
            }
        }
    }

    protected void carregarPorLinha(DataView dv2)
    {
        if (dv2.Table.Rows.Count != 0)
        {
            // exibindo o perfume 1 - ITEM 0 na tabela memoria
            ImageButton1.ImageUrl = cripto.Decrypt(dv2.Table.Rows[0]["img_prod"].ToString());
            LinkButton1.Text = cripto.Decrypt(dv2.Table.Rows[0]["nome_prod"].ToString());
            Session["img1"] = dv2.Table.Rows[0]["id_prod"].ToString();
            Session["linha1"] = dv2.Table.Rows[0]["id_linha"].ToString();
            lblPreco1.Text = "R$" + cripto.Decrypt(dv2.Table.Rows[0]["valor_prod_final"].ToString());

            //PESQUISA PROMOÇÃO EM VALOR
            Session["pesquisaPreco"] = dv2.Table.Rows[0]["id_prod"].ToString();
            DataView dvpreco1 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
            precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valorUnid_prod"].ToString()));
            precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_acrescimo"].ToString()));
            precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco1.Table.Rows[0]["valor_prod_final"].ToString()));

            precoFinalAdicional = precoAdicional + precoUnid;

            if (precoFinalAdicional > precoAtual)
            {
                lblPrecoAntigo1.Visible = true;
                lblPrecoAntigo1.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
            }


            //DESCRIPTOGRAFAR /-GENERO -LINHA 
            lblLinha1.Text = cripto.Decrypt(dv2.Table.Rows[0]["tipo_linha"].ToString());
            lblGenero1.Text = cripto.Decrypt(dv2.Table.Rows[0]["tipo_genero"].ToString());
             

            ImageButton1.Visible = true;
            LinkButton1.Visible = true;
            lblPreco1.Visible = true;
            lblLinha1.Visible = true;
            lblGenero1.Visible = true;

            divProd1.Attributes["class"] = "img-prod";
            divProd11.Attributes["class"] = "preco-prod";


            if (dv2.Table.Rows.Count > 1)
            {
                ImageButton2.ImageUrl = cripto.Decrypt(dv2.Table.Rows[1]["img_prod"].ToString());
                LinkButton2.Text = cripto.Decrypt(dv2.Table.Rows[1]["nome_prod"].ToString());
                Session["img2"] = dv2.Table.Rows[1]["id_prod"].ToString();
                Session["linha2"] = dv2.Table.Rows[1]["id_linha"].ToString();
                lblPreco2.Text = "R$" + cripto.Decrypt(dv2.Table.Rows[1]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dv2.Table.Rows[1]["id_prod"].ToString();
                DataView dvpreco2 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco2.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;
                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo2.Visible = true;
                    lblPrecoAntigo2.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha2.Text = cripto.Decrypt(dv2.Table.Rows[1]["tipo_linha"].ToString());
                lblGenero2.Text = cripto.Decrypt(dv2.Table.Rows[1]["tipo_genero"].ToString());
       
                ImageButton2.Visible = true;
                LinkButton2.Visible = true;
                lblPreco2.Visible = true;
                lblLinha2.Visible = true;
                lblGenero2.Visible = true;

                divProd2.Attributes["class"] = "img-prod";
                divProd22.Attributes["class"] = "preco-prod";
            }

            if (dv2.Table.Rows.Count > 2)
            {
                ImageButton3.ImageUrl = cripto.Decrypt(dv2.Table.Rows[2]["img_prod"].ToString());
                LinkButton3.Text = cripto.Decrypt(dv2.Table.Rows[2]["nome_prod"].ToString());
                Session["img3"] = dv2.Table.Rows[2]["id_prod"].ToString();
                Session["linha3"] = dv2.Table.Rows[2]["id_linha"].ToString();
                lblPreco3.Text = "R$" + cripto.Decrypt(dv2.Table.Rows[2]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dv2.Table.Rows[2]["id_prod"].ToString();
                DataView dvpreco3 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco3.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;
                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo3.Visible = true;
                    lblPrecoAntigo3.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha3.Text = cripto.Decrypt(dv2.Table.Rows[2]["tipo_linha"].ToString());
                lblGenero3.Text = cripto.Decrypt(dv2.Table.Rows[2]["tipo_genero"].ToString());
       

                ImageButton3.Visible = true;
                LinkButton3.Visible = true;
                lblPreco3.Visible = true;
                lblLinha3.Visible = true;
                lblGenero3.Visible = true;

                divProd3.Attributes["class"] = "img-prod";
                divProd33.Attributes["class"] = "preco-prod";
            }

            if (dv2.Table.Rows.Count > 3)
            {
                ImageButton4.ImageUrl = cripto.Decrypt(dv2.Table.Rows[3]["img_prod"].ToString());
                LinkButton4.Text = cripto.Decrypt(dv2.Table.Rows[3]["nome_prod"].ToString());
                Session["img4"] = dv2.Table.Rows[3]["id_prod"].ToString();
                Session["linha4"] = dv2.Table.Rows[3]["id_linha"].ToString();
                lblPreco4.Text = "R$" + cripto.Decrypt(dv2.Table.Rows[3]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dv2.Table.Rows[3]["id_prod"].ToString();
                DataView dvpreco4 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco4.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;
                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo4.Visible = true;
                    lblPrecoAntigo4.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha4.Text = cripto.Decrypt(dv2.Table.Rows[3]["tipo_linha"].ToString());
                lblGenero4.Text = cripto.Decrypt(dv2.Table.Rows[3]["tipo_genero"].ToString());
       

                ImageButton4.Visible = true;
                LinkButton4.Visible = true;
                lblPreco4.Visible = true;
                lblLinha4.Visible = true;
                lblGenero4.Visible = true;

                divProd4.Attributes["class"] = "img-prod";
                divProd44.Attributes["class"] = "preco-prod";
            }

            if (dv2.Table.Rows.Count > 4)
            {
                ImageButton5.ImageUrl = cripto.Decrypt(dv2.Table.Rows[4]["img_prod"].ToString());
                LinkButton5.Text = cripto.Decrypt(dv2.Table.Rows[4]["nome_prod"].ToString());
                Session["img5"] = dv2.Table.Rows[4]["id_prod"].ToString();
                Session["linha5"] = dv2.Table.Rows[4]["id_linha"].ToString();
                lblPreco5.Text = "R$" + cripto.Decrypt(dv2.Table.Rows[4]["valor_prod_final"].ToString());

                //PESQUISA PROMOÇÃO EM VALOR
                Session["pesquisaPreco"] = dv2.Table.Rows[4]["id_prod"].ToString();
                DataView dvpreco5 = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
                precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valorUnid_prod"].ToString()));
                precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_acrescimo"].ToString()));
                precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco5.Table.Rows[0]["valor_prod_final"].ToString()));

                precoFinalAdicional = precoAdicional + precoUnid;
                if (precoFinalAdicional > precoAtual)
                {
                    lblPrecoAntigo5.Visible = true;
                    lblPrecoAntigo5.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
                }

                //DESCRIPTOGRAFAR /-GENERO -LINHA 
                lblLinha5.Text = cripto.Decrypt(dv2.Table.Rows[4]["tipo_linha"].ToString());
                lblGenero5.Text = cripto.Decrypt(dv2.Table.Rows[4]["tipo_genero"].ToString());
       
                ImageButton5.Visible = true;
                LinkButton5.Visible = true;
                lblPreco5.Visible = true;
                lblLinha5.Visible = true;
                lblGenero5.Visible = true;

                divProd5.Attributes["class"] = "img-prod";
                divProd55.Attributes["class"] = "preco-prod";
            }
        }
    }

    protected void lbDesmarcar_Click(object sender, EventArgs e)
    {      
        carregarProd();
    }
}
