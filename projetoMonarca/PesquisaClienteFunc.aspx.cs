using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PesquisaCliente : System.Web.UI.Page
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
        Session["codCliente"] = gvExibir.Rows[gvExibir.SelectedIndex].Cells[1].Text;
        Response.Redirect("EditarClienteFunc.aspx");
    }

    public void descriptoGRID()
    {
        sqlClienteNome.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlClienteNome.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_cli", typeof(int));
        novaTB.Columns.Add("nome_cli", typeof(string));
        novaTB.Columns.Add("email_cli", typeof(string));
        novaTB.Columns.Add("cpf_cli", typeof(string));
        novaTB.Columns.Add("dtNasc_cli", typeof(string));
        novaTB.Columns.Add("tel_cli", typeof(string));
        novaTB.Columns.Add("cep_cli", typeof(string));
        novaTB.Columns.Add("data_conta", typeof(string));

        novaTB.DefaultView.RowFilter = "nome_cli like '" + txtPesquisa.Text + "%'";
        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_cli"] = dv.Table.Rows[i]["id_cli"].ToString();
            linha["nome_cli"] = cripto.Decrypt(dv.Table.Rows[i]["nome_cli"].ToString());
            linha["email_cli"] = cripto.Decrypt(dv.Table.Rows[i]["email_cli"].ToString());
            linha["cpf_cli"] = cripto.Decrypt(dv.Table.Rows[i]["cpf_cli"].ToString());

            DateTime dt = Convert.ToDateTime(cripto.Decrypt(dv.Table.Rows[i]["dtNasc_cli"].ToString()));
            String dataCerta = dt.ToString("dd/MM/yyyy");
            linha["dtNasc_cli"] = dataCerta.ToString();

            linha["tel_cli"] = cripto.Decrypt(dv.Table.Rows[i]["tel_cli"].ToString());
            linha["cep_cli"] = cripto.Decrypt(dv.Table.Rows[i]["cep_cli"].ToString());

            DateTime dtCadastro = Convert.ToDateTime(dv.Table.Rows[i]["data_conta"].ToString());
            String dtCadastroCerto = dtCadastro.ToString("dd/MM/yyyy");
            linha["data_conta"] = dtCadastroCerto;



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