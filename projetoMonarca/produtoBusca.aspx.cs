using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class produto : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");

    int numeroSorteado, qtdProd, qtdNumerosIguais;
    Random sequenciaProd = new Random();
    int[] pilhaProd = new int[5];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ClienteLogado"] == "Entrar")
        {
            Session["LoginProduto"] = null;
        }

        if (!IsPostBack)
        {
            CarregaML();
        }

        if (!IsPostBack == true)
        {
            //ESCONDER DIV
           // produtosRelacionados.Style.Add("display", "none");

            compreMais.Style.Add("display", "none");

            s1.Style.Add("display", "none");
            s2.Style.Add("display", "none");
            s3.Style.Add("display", "none");
            s4.Style.Add("display", "none");


            


                DataView dvbusca = (DataView)sqlProdutoBusca.Select(DataSourceSelectArguments.Empty);

                if (dvbusca.Table.Rows.Count == 0)
                {
                    Response.Redirect("Store.aspx");
                }
                else
                {
                    Session["idProd"] = dvbusca.Table.Rows[0]["id_prod"].ToString(); // Para não exibir


                    Image1.ImageUrl = cripto.Decrypt(dvbusca.Table.Rows[0]["img_prod"].ToString());
                    lblNome2.Text = cripto.Decrypt(dvbusca.Table.Rows[0]["nome_prod"].ToString());
                    lblSlogan.Text = cripto.Decrypt(dvbusca.Table.Rows[0]["slogan_prod"].ToString());
                    lblDesc.Text = cripto.Decrypt(dvbusca.Table.Rows[0]["desc_prod"].ToString());
                    lblValor.Text = cripto.Decrypt(dvbusca.Table.Rows[0]["valor_prod_final"].ToString());
                    ddlML.Text = dvbusca.Table.Rows[0]["id_ml"].ToString();

                    parcela();
                    pesquisaPromo();
                   // relacionados();
                }
            
        }


    }

    public void relacionados()
    {
        //**Teste de exibir relacionados**//

        DataView dvLinha;

        dvLinha = (DataView)SqlRelacionados.Select(DataSourceSelectArguments.Empty);


        ImageButton1.ImageUrl = "~\\img\\trans.png";
        LinkButton1.Text = "";


        ImageButton2.ImageUrl = "~\\img\\trans.png";
        LinkButton2.Text = "";


        ImageButton3.ImageUrl = "~\\img\\trans.png";
        LinkButton3.Text = "";

        ImageButton4.ImageUrl = "~\\img\\trans.png";
        LinkButton4.Text = "";



        if (dvLinha.Table.Rows.Count != 0)
        {
            //produtosRelacionados.Style.Add("display", "");
            //APARECER DIV
            compreMais.Style.Add("display", "");

            // contar quantos perfumes foram cadastrados
            qtdProd = dvLinha.Table.Rows.Count;

            if (qtdProd >= 4)
            {
                // sortear cinco perfumes
                for (int i = 0; i < 4; )
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

            }

            // exibindo a noticia 1 - ITEM 0 na tabela memoria
            ImageButton1.ImageUrl = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[0]]["img_prod"].ToString());
            LinkButton1.Text = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[0]]["nome_prod"].ToString());
            Session["img1"] = dvLinha.Table.Rows[pilhaProd[0]]["id_prod"].ToString();
            Session["linha1"] = dvLinha.Table.Rows[pilhaProd[0]]["id_linha"].ToString();
            //APARECER DIV
            s1.Style.Add("display", "");

            if (dvLinha.Table.Rows.Count > 1)
            {
                ImageButton2.ImageUrl = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[1]]["img_prod"].ToString());
                LinkButton2.Text = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[1]]["nome_prod"].ToString());
                Session["img2"] = dvLinha.Table.Rows[pilhaProd[1]]["id_prod"].ToString();
                Session["linha2"] = dvLinha.Table.Rows[pilhaProd[1]]["id_linha"].ToString();

                //APARECER DIV
                s2.Style.Add("display", "");
            }

            if (dvLinha.Table.Rows.Count > 2)
            {
                ImageButton3.ImageUrl = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[2]]["img_prod"].ToString());
                LinkButton3.Text = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[2]]["nome_prod"].ToString());
                Session["img3"] = dvLinha.Table.Rows[pilhaProd[2]]["id_prod"].ToString();
                Session["linha3"] = dvLinha.Table.Rows[pilhaProd[2]]["id_linha"].ToString();

                //APARECER DIV
                s3.Style.Add("display", "");
            }

            if (dvLinha.Table.Rows.Count > 3)
            {
                ImageButton4.ImageUrl = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[3]]["img_prod"].ToString());
                LinkButton4.Text = cripto.Decrypt(dvLinha.Table.Rows[pilhaProd[3]]["nome_prod"].ToString());
                Session["img4"] = dvLinha.Table.Rows[pilhaProd[3]]["id_prod"].ToString();
                Session["linha4"] = dvLinha.Table.Rows[pilhaProd[3]]["id_linha"].ToString();
                //APARECER DIV
                s4.Style.Add("display", "");

            }
        }
    
    }
    public void pesquisaPromo()
    {
        //PESQUISA PROMOÇÃO EM VALOR
            DataView dvpreco = (DataView)sqlPesquisaPreco.Select(DataSourceSelectArguments.Empty);
            double precoUnid, precoFinalAdicional, precoAdicional, precoAtual;

            precoUnid = Convert.ToDouble(cripto.Decrypt(dvpreco.Table.Rows[0]["valorUnid_prod"].ToString()));
            precoAdicional = Convert.ToDouble(cripto.Decrypt(dvpreco.Table.Rows[0]["valor_acrescimo"].ToString()));
            precoAtual = Convert.ToDouble(cripto.Decrypt(dvpreco.Table.Rows[0]["valor_prod_final"].ToString()));

            precoFinalAdicional = precoAdicional + precoUnid;
            lblPrecoAntigo.Visible = false;

            if (precoFinalAdicional > precoAtual)
            {
                lblPrecoAntigo.Visible = true;
                lblPrecoAntigo.Text = "R$ " + precoFinalAdicional.ToString("#0.00");
            }
    }
    public void CarregaML()
    {
        DataView dv = (DataView)sqlML.Select(DataSourceSelectArguments.Empty);
        ddlML.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            ddlML.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString()), dv.Table.Rows[i]["id_ml"].ToString()));
        }
    }
    public void parcela()
    {
        double parcela;
        double preco;

        preco = Convert.ToDouble(lblValor.Text.Replace(",","."));
        parcela = preco / 1200;
        lblParcela.Text = "12 x R$ " + parcela.ToString("#0.00");


    }
    protected void btnComprar_Click1(object sender, EventArgs e)
    {

        if (Session["ClienteLogado"] == "Entrar")
        {

            //Inserir Item
            try //CONVERTER A QTD DO DDL (ESCOLHIDO!)
            {
                if (ddlQtd.SelectedIndex == 0)
                {
                    Session["QtdDESEJADA"] = 1;
                }
                if (ddlQtd.SelectedIndex == 1)
                {
                    Session["QtdDESEJADA"] = 2;
                }
                if (ddlQtd.SelectedIndex == 2)
                {
                    Session["QtdDESEJADA"] = 3;
                }
                if (ddlQtd.SelectedIndex == 3)
                {
                    Session["QtdDESEJADA"] = 4;
                }

            }
            catch { }

            DataView dvProd = (DataView)sqlProdutoBusca.Select(DataSourceSelectArguments.Empty);
            int qtdEstoque, qtdFinal, qtdDesejada;
            qtdDesejada = Convert.ToInt16(Session["QtdDESEJADA"].ToString());
            qtdEstoque = Convert.ToInt16(cripto.Decrypt(dvProd.Table.Rows[0]["qtd_disponivel"].ToString()));
            if (qtdDesejada <= qtdEstoque)
            {
                lblErro.Text = "";
                if (Session["novaCompra"] == "Sim")
                {
                    //Criar uma venda 
                    sqlInserirVenda.Insert();
                    //Modificar Session para não criar venda nova para cada produto escolhido
                    Session["novaCompra"] = "Não";
                    //buscar último id
                    DataView dv2 = (DataView)sqlBuscarVendaCriada.Select(DataSourceSelectArguments.Empty);
                    Session["idVendas"] = dv2.Table.Rows[0]["idVendas"].ToString();
                }
                else
                {
                    sqlInserirVenda.Insert();
                    DataView dv2 = (DataView)sqlBuscarVendaCriada.Select(DataSourceSelectArguments.Empty);
                    Session["idVendas"] = dv2.Table.Rows[0]["idVendas"].ToString();
                }

                //Calcular Total  
                double preco;
                preco = Convert.ToDouble(lblValor.Text);
                Session["totalItem"] = preco.ToString().Replace(',', '.');




                sqlInserirItemVenda.Insert();
                DataView dvItem;
                dvItem = (DataView)sqlInserirItemVenda.Select(DataSourceSelectArguments.Empty);
                Session["ProdutoEscolhido"] = dvItem.Table.Rows[0]["id_prod"].ToString();
                //Subtrair qtd da tabela Produto


                qtdFinal = qtdEstoque - qtdDesejada;

                sqlSubtrairPerfumeComprada.UpdateParameters["qtd"].DefaultValue = cripto.Encrypt(qtdFinal.ToString());
                sqlSubtrairPerfumeComprada.Update();
                Response.Redirect("Compra.aspx");
            }
            else
            {
                lblErro.Text = "Quantidade de Estoque Insuficiente";
            }
        }

        else
        {
            Session["ML"] = ddlML.SelectedValue;
            Session["QTD"] = ddlQtd.SelectedValue;
            Session["PRECO"] = lblValor.Text;
            Session["LoginProduto"] = "Sim";
            //Response.Redirect("produto-login-comprar.aspx");
            Response.Redirect("PerfilCliente_Entrar.aspx");
        }
        }
        
    

    
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            calcularTProduto();
        }
        catch { }
    }

    private void calcularTProduto()
    {
        double precoComAdicionalNOVO, precoFixo, adicional, adicionalFinal;
        double precoComAdicionalANTIGO, precoUnid;

        DataView dvML;
        dvML = (DataView)sqlMLescolhido.Select(DataSourceSelectArguments.Empty);
        adicional = Convert.ToDouble(cripto.Decrypt(dvML.Table.Rows[0]["adicional"].ToString()));

        DataView dvPreco;
        dvPreco = (DataView)sqlProdutoBusca.Select(DataSourceSelectArguments.Empty);
        precoFixo = Convert.ToDouble(cripto.Decrypt(dvPreco.Table.Rows[0]["valorUnid_prod"].ToString()));


        sqlBuscarDescontoDoProduto.SelectParameters["pesquisaProd"].DefaultValue = cripto.Encrypt(lblNome2.Text);
        DataView dvProduto = (DataView)sqlBuscarDescontoDoProduto.Select(DataSourceSelectArguments.Empty);
        precoUnid = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[0]["valorUnid_prod"].ToString().Replace('.', ',')));

        adicionalFinal = precoFixo * (adicional / 100);

        try //CONTA DE ACORDO COM A QTD DESEJADA
        {


            if (ddlQtd.SelectedIndex == 0) //1
            {
                precoComAdicionalNOVO = (adicionalFinal + precoFixo);
                precoComAdicionalANTIGO = adicional + precoUnid;
                Session["precoComAdicional"] = precoComAdicionalNOVO;
                lblPrecoAntigo.Text = "R$ " + precoComAdicionalNOVO.ToString("#0.00");

            }

            if (ddlQtd.SelectedIndex == 1) //2
            {
                precoComAdicionalNOVO = (adicionalFinal + precoFixo) * 2;
                precoComAdicionalANTIGO = (adicionalFinal + precoUnid) * 2;
                Session["precoComAdicional"] = precoComAdicionalNOVO;
                lblPrecoAntigo.Text = "R$ " + precoComAdicionalNOVO.ToString("#0.00");
            }

            if (ddlQtd.SelectedIndex == 2) //3
            {
                precoComAdicionalNOVO = (adicionalFinal + precoFixo) * 3;
                precoComAdicionalANTIGO = (adicionalFinal + precoUnid) * 3;
                Session["precoComAdicional"] = precoComAdicionalNOVO;
                lblPrecoAntigo.Text = "R$ " + precoComAdicionalNOVO.ToString("#0.00");
            }

            if (ddlQtd.SelectedIndex == 3) //4
            {
                precoComAdicionalNOVO = (adicionalFinal + precoFixo) * 4;
                precoComAdicionalANTIGO = (adicionalFinal + precoUnid) * 4;
                Session["precoComAdicional"] = precoComAdicionalNOVO;
                lblPrecoAntigo.Text = "R$ " + precoComAdicionalNOVO.ToString("#0.00");
            }



            Session["codLinhaRelacionada"] = dvProduto.Table.Rows[0]["id_linha"].ToString();
            Session["codGeneroRelacionado"] = dvProduto.Table.Rows[0]["id_genero"].ToString();

            DataView dvGenero = (DataView)sqlBuscarDescontoDoGenero.Select(DataSourceSelectArguments.Empty);
            DataView dvLinha = (DataView)sqlBuscarDescontoDaLinha.Select(DataSourceSelectArguments.Empty);


            double descontoLinha, descontoGenero, descontoProduto;
            double precoFinal;


            precoComAdicionalNOVO = Convert.ToDouble(Session["precoComAdicional"].ToString().Replace('.', ','));
            descontoLinha = Convert.ToDouble(cripto.Decrypt(dvLinha.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));
            descontoGenero = Convert.ToDouble(cripto.Decrypt(dvGenero.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));
            descontoProduto = Convert.ToDouble(cripto.Decrypt(dvProduto.Table.Rows[0]["desconto"].ToString().Replace('.', ',')));

            if (dvProduto.Table.Rows[0]["id_promo"].ToString() == "1")
            {
                if (dvLinha.Table.Rows[0]["id_promo"].ToString() == "1")
                {
                    //SEM PROMOÇÃO NENHUMA!            
                    if (dvGenero.Table.Rows[0]["id_promo"].ToString() == "1")
                    {
                        Session["precoFinal"] = precoComAdicionalNOVO.ToString("#0.00");
                        lblValor.Text = precoComAdicionalNOVO.ToString("#0.00");
                    }
                    //DESCONTO GENERO
                    else
                    {
                        precoFinal = precoComAdicionalNOVO - (precoComAdicionalNOVO * descontoGenero / 100);
                        Session["precoFinal"] = precoFinal.ToString("#0.00");
                        lblValor.Text = precoFinal.ToString("#0.00");
                    }
                }
                //DESCONTO LINHA
                else
                {
                    precoFinal = precoComAdicionalNOVO - (precoComAdicionalNOVO * descontoLinha / 100);
                    Session["precoFinal"] = precoFinal.ToString("#0.00");
                    lblValor.Text = precoFinal.ToString("#0.00");
                }
            }
            //DESCONTO DO PRODUTO
            else
            {
                precoFinal = precoComAdicionalNOVO - (precoComAdicionalNOVO * descontoProduto / 100);
                Session["precoFinal"] = precoFinal.ToString("#0.00");
                lblValor.Text = precoFinal.ToString("#0.00");
            }
        }
        catch { }
    }
    protected void ddlML_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack == true)
        {
            try //CONVERTER O ML DO DDL (ESCOLHIDO!)
            {
                if (ddlML.SelectedValue == "50ml")
                {
                    Session["MLEscolhido"] = "50ml";
                }

                if (ddlML.SelectedValue == "100ml")
                {
                    Session["MLEscolhido"] = "100ml";
                }

                if (ddlML.SelectedValue == "150ml")
                {
                    Session["MLEscolhido"] = "150ml";
                }

            }
            catch { }


            try
            {
                calcularTProduto();
                parcela();
                pesquisaPromo();
             }
            catch { }
        }
    }
    protected void ddlQtd_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (IsPostBack == true)
        {
            try
            {
                calcularTProduto();
                parcela();
                pesquisaPromo();
            }
            catch { }
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
}