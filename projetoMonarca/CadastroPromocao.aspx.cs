using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


public partial class CadastroPromocao : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")

            Response.Redirect("LoginADM.aspx");
            dadosPromocao.Style.Add("display", "none");

            if (!IsPostBack)
            {
                CarregaLinha();
            }
            if (!IsPostBack)
            {
                CarregaGenero();
            }
            if (!IsPostBack)
            {
                CarregaProduto();
            }

    }

    public void CarregaLinha()
    {
        DataView dv = (DataView)sqlLinha.Select(DataSourceSelectArguments.Empty);
        rbLinha.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            rbLinha.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["tipo_linha"].ToString()), dv.Table.Rows[i]["id_linha"].ToString()));
        }
    }
    public void CarregaGenero()
    {
        DataView dv = (DataView)sqlGenero.Select(DataSourceSelectArguments.Empty);
        rbGenero.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            rbGenero.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString()), dv.Table.Rows[i]["id_genero"].ToString()));
        }
    }
    public void CarregaProduto()
    {
        DataView dv = (DataView)sqlProduto.Select(DataSourceSelectArguments.Empty);
        rbProduto.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            rbProduto.Items.Add(new ListItem(cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString()), dv.Table.Rows[i]["id_prod"].ToString()));
        }
    }
    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
     
        if (txtTitulo.Text != "")
        {
            sqlVerificarExistente.SelectParameters["promo"].DefaultValue = cripto.Encrypt(txtTitulo.Text);
            DataView dv1 = (DataView)sqlVerificarExistente.Select(DataSourceSelectArguments.Empty);
           

            //CADASTRO DA PROMOÇÃO
            if (dv1.Table.Rows.Count == 0)
            {

                sqlInserirPromo.InsertParameters["titulo"].DefaultValue = cripto.Encrypt(txtTitulo.Text);
                sqlInserirPromo.InsertParameters["desc"].DefaultValue = cripto.Encrypt(txtDesconto.Text);
                
                
                sqlInserirPromo.Insert();

                //REGISTRO
                DateTime dtCad = DateTime.Today;
                String dataCadastro = dtCad.ToString("yyyy/MM/dd");
                sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro;
                sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Cadastro Promoção");
                sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");

                sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt(txtTitulo.Text);
                sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                sqlRegistro.Insert();

  
                sqlCriarSessionPromoCadastrada.SelectParameters["promo"].DefaultValue = cripto.Encrypt(txtTitulo.Text);
                DataView dv = (DataView)sqlCriarSessionPromoCadastrada.Select(DataSourceSelectArguments.Empty);
                

                Session["idPromo"] = dv.Table.Rows[0]["id_promo"].ToString();

                lblObr.Text = "";
                lblResp.Text = "Promoção Cadastrada com Sucesso!";
                btnCadastrar.Visible = false;
                txtDesconto.ReadOnly = true;
                txtTitulo.ReadOnly = true;
                lblExistente.Text = "";
                dadosPromocao.Style.Add("display", "");
            }

            else
            {
                lblExistente.Text = "Título de Promoção já Existente.";
            }
        }
        
    }
 
    protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {
            lblExistente.Text = "";
            txtDesconto.ReadOnly = true;
            txtTitulo.ReadOnly = true;
       
            if (rbLinha.SelectedIndex != null)
            {
                sqlLinhaEscolhida.Update();
                lblTeste.Text = "LINHA Editado com sucesso".ToString(); 
                rbLinha.ClearSelection();

            }
            if (rbGenero.SelectedIndex != null)
            {
                sqlGeneroEscolhido.Update();
                lblTeste.Text = "GENERO Editado com sucesso".ToString();
                rbGenero.ClearSelection();

            }
            
            if (rbProduto.SelectedIndex != null)
            {
                sqlProdutoEscolhido.Update();
                lblTeste.Text = "PRODUTO Editado com sucesso".ToString();
                rbProduto.ClearSelection();

            }


            exibirCalculoFinalProduto();

        }
        catch { }
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

    protected void rbLinha_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataView dv;
        dv = (DataView)sqlLinha.Select(DataSourceSelectArguments.Empty);
        Session["codLinha"] = dv.Table.Rows[0]["id_linha"];
    }
    protected void rbGenero_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataView dv;
        dv = (DataView)sqlGenero.Select(DataSourceSelectArguments.Empty);
        Session["codGenero"] = dv.Table.Rows[0]["id_genero"];
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataView dv;
        dv = (DataView)sqlProduto.Select(DataSourceSelectArguments.Empty);
        Session["codProduto"] = dv.Table.Rows[0]["id_prod"];
    }

    protected void btnLinha_Click(object sender, EventArgs e)
    {
        Session["NovaPromo"] = "Jácadastrada";
        Response.Redirect("CadastroLinha.aspx");
    }
    protected void btnProduto_Click(object sender, EventArgs e)
    {
        Session["NovaPromo"] = "Jácadastrada";
        Response.Redirect("CadastroPerfume.aspx");
    }
}