using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class PesquisaVendas : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");
    }
    protected void btnPesquisar_Click(object sender, EventArgs e)
    {
         descriptoGRID();      
    }
    public void descriptoGRID()
    {
        sqlVendasPorNome.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlVendasPorNome.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_venda", typeof(int));
        novaTB.Columns.Add("nome_cli", typeof(string));
        novaTB.Columns.Add("status", typeof(string));
        novaTB.Columns.Add("email_cli", typeof(string));
        novaTB.Columns.Add("tipo_pagto", typeof(string));
        novaTB.Columns.Add("total_venda", typeof(double));
        novaTB.DefaultView.RowFilter = "nome_cli like '" + txtPesquisa.Text + "%'";

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_venda"] = dv.Table.Rows[i]["id_venda"].ToString();
            linha["nome_cli"] = cripto.Decrypt(dv.Table.Rows[i]["nome_cli"].ToString());

            //STATUS 
            if (dv.Table.Rows[i]["status"].ToString() == "1")
            {
                linha["status"] = "Conta Inativa".ToString();
            }
            if (dv.Table.Rows[i]["status"].ToString() == "0")
            {
                linha["status"] = "Conta Ativa".ToString();
            }

            linha["email_cli"] = cripto.Decrypt(dv.Table.Rows[i]["email_cli"].ToString());
            linha["tipo_pagto"] = dv.Table.Rows[i]["tipo_pagto"].ToString();
            linha["total_venda"] = cripto.Decrypt(dv.Table.Rows[i]["total_venda"].ToString());

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