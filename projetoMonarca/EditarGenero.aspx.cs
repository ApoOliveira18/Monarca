using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class EditarGenero : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");

        if (!IsPostBack)
        {
            CarregaDDLFem();
            CarregaDDLMasc();
        }

        if (IsPostBack == false)
        {
            telaInicial();
        }
    }
    public void telaInicial()
    {
        //ESCONDER DIV
        FemPromo.Style.Add("display", "none");
        MascPromo.Style.Add("display", "none");

        FemExibir.Style.Add("display", "");
        MascExibir.Style.Add("display", "");

        DataView dvFem = (DataView)sqlFemPromoCadastrada.Select(DataSourceSelectArguments.Empty);
        DataView dvMasc = (DataView)sqlMascPromoCadastrada.Select(DataSourceSelectArguments.Empty);

        lblFemPromo.Text = cripto.Decrypt(dvFem.Table.Rows[0]["titulo_promo"].ToString());
        lblFemDesc.Text = cripto.Decrypt(dvFem.Table.Rows[0]["desconto"].ToString()) + "%";


        lblMascPromo.Text = cripto.Decrypt(dvMasc.Table.Rows[0]["titulo_promo"].ToString());
        lblMascDesc.Text = cripto.Decrypt(dvMasc.Table.Rows[0]["desconto"].ToString()) + "%";
    }

    public void CarregaDDLFem()
    {
        DataView dv = (DataView)sqlPromocao.Select(DataSourceSelectArguments.Empty);
        ddlFeminino.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            ddlFeminino.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["titulo_promo"].ToString()), dv.Table.Rows[i]["id_promo"].ToString()));
        }
    }
    public void CarregaDDLMasc()
    {
        DataView dv = (DataView)sqlPromocao.Select(DataSourceSelectArguments.Empty);
        ddlMasculino.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            ddlMasculino.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["titulo_promo"].ToString()), dv.Table.Rows[i]["id_promo"].ToString()));
        }
    }
    protected void btnAlterarFem_Click(object sender, EventArgs e)
    {

        FemPromo.Style.Add("display", "");
        FemExibir.Style.Add("display", "none");

        DataView dvFem = (DataView)sqlFemPromoCadastrada.Select(DataSourceSelectArguments.Empty);
        ddlFeminino.Text = dvFem.Table.Rows[0]["id_promo"].ToString();
        lblPromo1.Text = cripto.Decrypt(dvFem.Table.Rows[0]["desconto"].ToString()) + "%";
        Session["codGenero"] = dvFem.Table.Rows[0]["id_genero"].ToString();
    }
    protected void btnAlterarMasc_Click(object sender, EventArgs e)
    {
        MascPromo.Style.Add("display", "");
        MascExibir.Style.Add("display", "none");

        DataView dvMasc = (DataView)sqlMascPromoCadastrada.Select(DataSourceSelectArguments.Empty);
        lblPromo2.Text = cripto.Decrypt(dvMasc.Table.Rows[0]["desconto"].ToString()) + "%";
        ddlMasculino.Text = dvMasc.Table.Rows[0]["id_promo"].ToString();
        Session["codGenero"] = dvMasc.Table.Rows[0]["id_genero"].ToString();
    }
    protected void ddlFeminino_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataView dvPromo = (DataView)sqlPromoEscolhidaFem.Select(DataSourceSelectArguments.Empty);
        lblPromo1.Text = cripto.Decrypt(dvPromo.Table.Rows[0]["desconto"].ToString()) + "%";      
    }
    protected void ddlMasculino_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataView dvPromo = (DataView)sqlPromoEscolhidaMasc.Select(DataSourceSelectArguments.Empty);
        lblPromo2.Text = cripto.Decrypt(dvPromo.Table.Rows[0]["desconto"].ToString()) + "%";
    }


    protected void btnConcluirFem_Click(object sender, EventArgs e)
    {
        
        sqlFemPromoCadastrada.Update();
        exibirCalculoFinalProduto();

        telaInicial();
        Session["codGenero"] = null;


        //REGISTRO 
        DateTime dtCad1 = DateTime.Today;
        String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
        sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Edição Gênero");
        sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
        sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


        sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("Feminino");

        sqlRegistro.Insert();

    }
    protected void btnConcluirMasc_Click(object sender, EventArgs e)
    {
        sqlMascPromoCadastrada.Update();
        exibirCalculoFinalProduto();
        telaInicial();
        Session["codGenero"] = null;



        //REGISTRO 
        DateTime dtCad1 = DateTime.Today;
        String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
        sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Edição Gênero");
        sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
        sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


        sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
        sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("Masculino");

        sqlRegistro.Insert();
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
}