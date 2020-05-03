using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class CadastroLinha : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["logado"] != "Entrar")
        {
            Response.Redirect("LoginADM.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                CarregaDDLPromo();
            }

            //APARECER DIV DO DDL PROMOÇÃO 
            dadosPromocao.Style.Add("display", "");
            //ESCONDER DIV DO DESCONTO
            descontoPromo.Style.Add("display", "none");

            if (Session["NovaPromo"] == "Jácadastrada")
            {
                ddlPromo.Text = Session["idPromo"].ToString();
                descontoPromo.Style.Add("display", "");
                DataView dv;
                dv = (DataView)sqlPromoSession.Select(DataSourceSelectArguments.Empty);
                txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());
                Session["NovaPromo"] = "";

            }
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

    protected void  btnCadastrar_Click(object sender, EventArgs e)
    {
        if (txtLinha.Text != "")
        {
            sqlVerificarExistente.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtLinha.Text);
            DataView dv1 = (DataView)sqlVerificarExistente.Select(DataSourceSelectArguments.Empty);

            if (dv1.Table.Rows.Count == 0)
            {

                sqlCadastroLinha.InsertParameters["linha"].DefaultValue = cripto.Encrypt(txtLinha.Text);  
                sqlCadastroLinha.Insert();
                dadosPromocao.Style.Add("display", "none");

                Session["NovaPromo"] = "não";
                btnCadastrar.Visible = false;
                btnProduto.Visible = true;
                txtLinha.ReadOnly = true;
                ddlPromo.EnableViewState = true;
                lblObr.Text = "";
                lblExistente.Text = "";
                lblResp.Text = "Linha Cadastrada com Sucesso! Adicione Novos Produtos a sua Linha!";

                //REGISTRO 
                DateTime dtCad = DateTime.Today;
                String dataCadastro = dtCad.ToString("yyyy/MM/dd");
                sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Cadastro Linha");
                sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro;
                sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt(txtLinha.Text);
               

                sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                sqlRegistro.Insert();

                       
                if (ddlPromo.SelectedIndex != 0)
                {


                    dadosPromocao.Style.Add("display", "none");
                    DataView dv2 = (DataView)sqlExibirCadastro.Select(DataSourceSelectArguments.Empty);
                    lblPromo.Text = "Promoção: " + cripto.Decrypt(dv2.Table.Rows[0]["titulo_promo"].ToString());
                    descontoPromo.Style.Add("display", "");
                    

                }
                else
                {
                    lblPromo.Text = "";
                }
                
                
                
                //Response.Redirect("CadastroLinhaSucesso.aspx");
            }
            else
            {
                lblExistente.Text = "Título de Promoção já Existente.";
            }
        }           
    }
    protected void ddlPromo_SelectedIndexChanged(object sender, EventArgs e)
    {        
        Session["NovaPromo"] = "sim";
        DataView dv;
        dv = (DataView)sqlPromoEscolhida.Select(DataSourceSelectArguments.Empty);
        txtDesconto.Text = cripto.Decrypt(dv.Table.Rows[0]["desconto"].ToString());
        //Session["promo"] = ddlPromo.Text;
        descontoPromo.Style.Add("display", "");        
    }
    protected void btnProduto_Click(object sender, EventArgs e)
    {
        sqlCriarSessionParaLinhaCadastrada.SelectParameters["linha"].DefaultValue = cripto.Encrypt(txtLinha.Text);
        DataView dv = (DataView)sqlCriarSessionParaLinhaCadastrada.Select(DataSourceSelectArguments.Empty);
        Session["idLinha"] = dv.Table.Rows[0]["id_linha"].ToString();
        Session["promo"] = null;
        Session["NovaLinha"] = "Jácadastrada";
        Response.Redirect("CadastroPerfume.aspx");
    }
}
