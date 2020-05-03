using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class IndexADM : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");
        else
        {
          //  descriptoGRID();
            validadeRegistros();
            validadeRegistrosFunc();
            validadeRegistrosLogin();
           // exibirCalculoFinalProduto();
        }
    }

    public void validadeRegistros()
    {
        DataView dv = (DataView)sqlPesquisaRegistrosADM.Select(DataSourceSelectArguments.Empty);

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            Session["idRegistro"] = dv.Table.Rows[i]["id_registros"].ToString();
            DateTime dt = Convert.ToDateTime(dv.Table.Rows[i]["data_registro"].ToString());
            DateTime dtMax = dt.AddMonths(+6);

            //EXCLUIR REGISTROS
            DateTime hoje = DateTime.Now;
            if (hoje >= dtMax)
            {
                sqlPesquisaRegistrosADM.Delete();
            }
        }
        Session["idRegistro"] = null;
    }
    public void validadeRegistrosFunc()
    {
        DataView dv = (DataView)sqlPesquisaRegistroFunc.Select(DataSourceSelectArguments.Empty);

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            Session["idRegistroFUNC"] = dv.Table.Rows[i]["id_registrosFunc"].ToString();
            DateTime dt = Convert.ToDateTime(dv.Table.Rows[i]["data_registro"].ToString());
            DateTime dtMax = dt.AddMonths(+6);

            //EXCLUIR REGISTROS
            DateTime hoje = DateTime.Now;
            if (hoje >= dtMax)
            {
                sqlPesquisaRegistroFunc.Delete();
            }
        }
        Session["idRegistroFUNC"] = null;
    }
    public void validadeRegistrosLogin()
    {
        DataView dv = (DataView)sqlPesquisaRegistrosLogin.Select(DataSourceSelectArguments.Empty);

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            Session["idRegistroLOGIN"] = dv.Table.Rows[i]["id_registrosLogin"].ToString();
            DateTime dt = Convert.ToDateTime(dv.Table.Rows[i]["data_registro"].ToString());
            DateTime dtMax = dt.AddMonths(+6);

            //EXCLUIR REGISTROS
            DateTime hoje = DateTime.Now;
            if (hoje >= dtMax)
            {
                sqlPesquisaRegistrosLogin.Delete();
            }
        }
        Session["idRegistro"] = null;
    }


     public void exibirCalculoFinalProduto()
    {

        //-SQL's : sqlBuscarDescontoDoProduto, sqlBuscarDescontoDoGenero & sqlBuscarDescontoDaLinha//
        //ALTERAR A PESQUISAR PRODUTO DE ACORDO COM A PAGINA
        //sqlBuscarDescontoDoProduto.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
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
    }
     public void descriptoGRID()
     {
         DataView dv = (DataView)sqlBuscaTopClientes.Select(DataSourceSelectArguments.Empty);
         DataTable novaTB = new DataTable();

         //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
         novaTB.Columns.Add("id_venda", typeof(int));
         novaTB.Columns.Add("nome_cli", typeof(string));
         novaTB.Columns.Add("total_venda", typeof(string));


         // varrendo as linhas da tabela criptografadas
         // 1 a 1 para descriptografar
         for (int i = 0; i < dv.Table.Rows.Count; i++)
         {
             // 1. criar a linha
             DataRow linha = novaTB.NewRow();

             // 2. descriptografar
             linha["id_venda"] = dv.Table.Rows[i]["id_venda"].ToString();
             linha["nome_cli"] = cripto.Decrypt(dv.Table.Rows[i]["nome_cli"].ToString());

             if (dv.Table.Rows[i]["total_venda"].ToString() == "0")
             {
                 linha["total_venda"] = "R$ " + dv.Table.Rows[i]["total_venda"].ToString();
             }
             else
             {
                 linha["total_venda"] = "R$ " + cripto.Decrypt(dv.Table.Rows[i]["total_venda"].ToString());
             }

             // 3. adicionar a linha na novaTB
             novaTB.Rows.Add(linha);
         }

         // atribuindo ao GRID o nova tabela com os 
         // dados descriptografadas
         //gvTopClientes.DataSource = novaTB;

         //// REFRESH no GRID
         //gvTopClientes.DataBind();

     }
     protected void LinkButton1_Click(object sender, EventArgs e)
     {
         Response.Redirect("registrosADM.aspx");
     }
}