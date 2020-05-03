using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {


        if (IsPostBack == false)
        {
            if (Session["ProdutoEscolhido"] != null)
            {
 

                DataView dv = (DataView)sqlItensComprados.Select(DataSourceSelectArguments.Empty);
                if (dv.Table.Rows.Count != 0)
                {
                    descriptoGRID();
                    calcularTotal();
                 
                    //MEU ENDERECO CADASTRADO
                    PesquisaMeuEnd();
                    rbMeuEnd.SelectedIndex = 0;

                    //ENDERECO ADICIONAL
                    CarregaEnderecos();
                    calculoEstado();

                }
            }
            else
            {
                Response.Redirect("index.aspx");
            }


            
        }

    }
    public void PesquisaMeuEnd()
    {
        DataView dv = (DataView)sqlMeuEnd.Select(DataSourceSelectArguments.Empty);
        
        Session["cep"] = cripto.Decrypt(dv.Table.Rows[0]["CEP_cli"].ToString());
        PesquisaCEP();
        rbMeuEnd.Items.Add(new ListItem("Minha Cidade:  " + Session["cidade"].ToString()
            + ", " + Session["rua"].ToString()
            + ", nº " +dv.Table.Rows[0]["num_cli"].ToString()));

        ddlEstado.Text = Session["estado"].ToString();

    
    }

    public void CarregaEnderecos()
    {
        DataView dv = (DataView)sqlEndAdicionais.Select(DataSourceSelectArguments.Empty);
        rbEnd.Items.Clear();

        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            rbEnd.Items.Add(new ListItem("Para: " + cripto.Decrypt(dv.Table.Rows[i]["nome_end"].ToString()) + "  Cidade:  " + cripto.Decrypt(dv.Table.Rows[i]["cidade_end"].ToString()), dv.Table.Rows[i]["id_end"].ToString()));
        }
    }

    protected void rbEnd_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbEnd.SelectedIndex != -1)
        {
            rbMeuEnd.SelectedIndex = -1;
            DataView dv = (DataView)sqlEndEscolhido.Select(DataSourceSelectArguments.Empty);
            Session["cep"] = cripto.Decrypt(dv.Table.Rows[0]["cep_cli"].ToString());
            PesquisaCEP();
            //lblEstadoEntrega.Text = Session["estado"].ToString();
            ddlEstado.Text = Session["estado"].ToString();
            calculoEstado();
        }
    }

    protected void rbMeuEnd_SelectedIndexChanged(object sender, EventArgs e)
    {
        rbEnd.SelectedIndex = -1;
        DataView dv = (DataView)sqlMeuEnd.Select(DataSourceSelectArguments.Empty);

        Session["cep"] = cripto.Decrypt(dv.Table.Rows[0]["CEP_cli"].ToString());
        PesquisaCEP();
        ddlEstado.Text = Session["estado"].ToString();
        calculoEstado();
    }

    public void PesquisaCEP()
    {
        HttpWebRequest requisicao = (HttpWebRequest)WebRequest.Create("http://www.buscacep.correios.com.br/servicos/dnec/consultaLogradouroAction.do?Metodo=listaLogradouro&CEP=" + Session["cep"].ToString() + "&TipoConsulta=cep");
        HttpWebResponse resposta = (HttpWebResponse)requisicao.GetResponse();

        int cont;
        byte[] buffer = new byte[1000];
        StringBuilder sb = new StringBuilder();
        string temp;

        Stream stream = resposta.GetResponseStream();

        do
        {
            cont = stream.Read(buffer, 0, buffer.Length);
            temp = Encoding.Default.GetString(buffer, 0, cont).Trim();
            sb.Append(temp);

        } while (cont > 0);

        string pagina = sb.ToString();

        if (pagina.IndexOf("<font color=\"black\">CEP NAO ENCONTRADO</font>") >= 0)
        {
            // lblErro.Text = "CEP NÃO LOCALIZADO.";   

        }

        else
        {
            Session["rua"] = Regex.Match(pagina, "<td width=\"268\" style=\"padding: 2px\">(.*)</td>").Groups[1].Value;
            Session["bairro"] = Regex.Matches(pagina, "<td width=\"140\" style=\"padding: 2px\">(.*)</td>")[0].Groups[1].Value;
            Session["cidade"] = Regex.Matches(pagina, "<td width=\"140\" style=\"padding: 2px\">(.*)</td>")[1].Groups[1].Value;
            lblEstadoEntrega.Text = Regex.Match(pagina, "<td width=\"25\" style=\"padding: 2px\">(.*)</td>").Groups[1].Value;
            Session["estado"] = Regex.Match(pagina, "<td width=\"25\" style=\"padding: 2px\">(.*)</td>").Groups[1].Value;

           // lblErro.Text = "";
        }
    }
    private void calcularTotal()
    {
        DataView dv;

        dv = (DataView)sqlSomarItensdoCarrinho.Select(DataSourceSelectArguments.Empty);
        lblValorCompra.Text = dv.Table.Rows[0]["Total"].ToString();

        Session["valorCompra"] = lblValorCompra.Text;
       

    }

    protected void ddlEstado_SelectedIndexChanged1(object sender, EventArgs e)
    {
        calculoEstado();
        rbEnd.ClearSelection();
    }
    protected void btnComprar_Click(object sender, EventArgs e)
    {
        if (lblEstadoEntrega.Text == "")
        {
            //lblErro.Visible = true;

        }
        else
        {
//MUDAR 
            //Session["novaCompra"] = "Não";
            //sqlItensComprados.Update();
            Session["valorTotal"] =  lblValorTotal.Text;
            Response.Redirect("pagamento.aspx");
        }
    }
    public void descriptoGRID()
    {
        //sqlItensComprados.SelectParameters["nome"].DefaultValue = cripto.Encrypt(txtPesquisa.Text);
        DataView dv = (DataView)sqlItensComprados.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_itens", typeof(int));
        novaTB.Columns.Add("img_prod", typeof(string));
        novaTB.Columns.Add("nome_prod", typeof(string));
        novaTB.Columns.Add("desc_ml", typeof(string));
        novaTB.Columns.Add("tipo_genero", typeof(string));
        novaTB.Columns.Add("total_prod", typeof(double));

        // novaTB.DefaultView.RowFilter = "login_func like '" + txtPesquisa.Text + "%'";

        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_itens"] = dv.Table.Rows[i]["id_itens"].ToString();
            linha["img_prod"] = cripto.Decrypt(dv.Table.Rows[i]["img_prod"].ToString());
            linha["nome_prod"] = cripto.Decrypt(dv.Table.Rows[i]["nome_prod"].ToString());
            linha["desc_ml"] = cripto.Decrypt(dv.Table.Rows[i]["desc_ml"].ToString());
            linha["tipo_genero"] = cripto.Decrypt(dv.Table.Rows[i]["tipo_genero"].ToString());
            linha["total_prod"] = dv.Table.Rows[i]["total_prod"].ToString();

            // 3. adicionar a linha na novaTB
            novaTB.Rows.Add(linha);
        }

        GridView1.DataSource = novaTB;
        GridView1.DataBind();



    }

    protected void btnExcluir_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow linha in GridView1.Rows)
        {
            CheckBox op;
            op = (CheckBox)linha.FindControl("chkOP");

            if (op.Checked == true)
            {

                // Session["produtoExcluir"] = dv.Table.Rows[0]["id_itens"].ToString();
                sqlItensComprados.DeleteParameters["cod"].DefaultValue = linha.Cells[1].Text;
                sqlItensComprados.Delete();
            }
            sqlItensComprados.DataBind();
            sqlSomarItensdoCarrinho.DataBind();
            descriptoGRID();
            calcularTotal();

            DataView dv = (DataView)sqlItensComprados.Select(DataSourceSelectArguments.Empty);
            if (dv.Table.Rows.Count == 0)
            {
                Response.Redirect("index.aspx");
            }
        }
    }
    protected void linkEndereco_Click(object sender, EventArgs e)
    {
        Session["sacola"] = "sim";

        Response.Redirect("PerfilCliente_EndAdicional.aspx");
    }

    public void calculoEstado()
    {
        

        try
        {
            double valorProduto, totalCompra;
            valorProduto = Convert.ToDouble(lblValorCompra.Text.Replace('.', ','));

            if (valorProduto >= 500)
            {
                totalCompra = valorProduto + 0;

                lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                lblValorFrete.Text = "Gratuito";
                lblValorFrete2.Text = "Gratuito";
                lblValorTotal.Text = totalCompra.ToString("#0.00");


                if (ddlEstado.SelectedIndex == 25)
                {
                    lblEstadoEntrega.Text = "São Paulo";
                    lblPrazo.Text = "3 dias úteis";
                }

                //Rio de Janeiro
                if (ddlEstado.SelectedIndex == 19)
                {
                    lblEstadoEntrega.Text = "Rio de Janeiro";
                    lblPrazo.Text = "5 dias úteis";
                }

                //REGIÃO NORTE E NORDESTE
                //Acre
                if (ddlEstado.SelectedIndex == 1)
                {
                    lblEstadoEntrega.Text = "Acre";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Alagoas
                if (ddlEstado.SelectedIndex == 2)
                {
                    lblEstadoEntrega.Text = "Alagoas";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Amapá
                if (ddlEstado.SelectedIndex == 3)
                {
                    lblEstadoEntrega.Text = "Amapá";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Amazonas
                if (ddlEstado.SelectedIndex == 4)
                {
                    lblEstadoEntrega.Text = "Amazonas";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Bahia
                if (ddlEstado.SelectedIndex == 5)
                {
                    lblEstadoEntrega.Text = "Bahia";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Ceará
                if (ddlEstado.SelectedIndex == 6)
                {
                    lblEstadoEntrega.Text = "Ceará";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Maranhão
                if (ddlEstado.SelectedIndex == 10)
                {
                    lblEstadoEntrega.Text = "Maranhão";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Pará
                if (ddlEstado.SelectedIndex == 14)
                {
                    lblEstadoEntrega.Text = "Pará";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Paraíba
                if (ddlEstado.SelectedIndex == 15)
                {
                    lblEstadoEntrega.Text = "Paraíba";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Pernambuco
                if (ddlEstado.SelectedIndex == 17)
                {
                    lblEstadoEntrega.Text = "Pernambuco";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Piauí
                if (ddlEstado.SelectedIndex == 18)
                {
                    lblEstadoEntrega.Text = "Piauí";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Rio Grande do Norte
                if (ddlEstado.SelectedIndex == 20)
                {
                    lblEstadoEntrega.Text = "Rio Grande do Norte";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Rondônia
                if (ddlEstado.SelectedIndex == 22)
                {
                    lblEstadoEntrega.Text = "Rondônia";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Roraima
                if (ddlEstado.SelectedIndex == 23)
                {
                    lblEstadoEntrega.Text = "Roraima";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Sergipe
                if (ddlEstado.SelectedIndex == 26)
                {
                    lblEstadoEntrega.Text = "Sergipe";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Tocantins
                if (ddlEstado.SelectedIndex == 27)
                {
                    lblEstadoEntrega.Text = "Tocantins";
                    lblPrazo.Text = "10 dias úteis";
                }

                //OUTROS ESTADOS
                //Distrito Federal
                if (ddlEstado.SelectedIndex == 7)
                {
                    lblEstadoEntrega.Text = "Distrito Federal";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Espírito Santo
                if (ddlEstado.SelectedIndex == 8)
                {
                    lblEstadoEntrega.Text = "Espírito Santo";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Goiás
                if (ddlEstado.SelectedIndex == 9)
                {
                    lblEstadoEntrega.Text = "Goiás";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Mato Grosso
                if (ddlEstado.SelectedIndex == 11)
                {
                    lblEstadoEntrega.Text = "Mato Grosso";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Mato Grosso do Sul
                if (ddlEstado.SelectedIndex == 12)
                {
                    lblEstadoEntrega.Text = "Mato Grosso do Sul";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Minas Gerais
                if (ddlEstado.SelectedIndex == 13)
                {
                    lblEstadoEntrega.Text = "Minas Gerais";
                    lblPrazo.Text = "7 dias úteis";

                }

                //Paraná
                if (ddlEstado.SelectedIndex == 16)
                {
                    lblEstadoEntrega.Text = "Paraná";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Rio Grande do Sul
                if (ddlEstado.SelectedIndex == 21)
                {
                    lblEstadoEntrega.Text = "Rio Grande do Sul";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Santa Catarina
                if (ddlEstado.SelectedIndex == 24)
                {
                    lblEstadoEntrega.Text = "Santa Catarina";
                    lblPrazo.Text = "7 dias úteis";
                }
            }

            else
            {
                //São Paulo
                if (ddlEstado.SelectedIndex == 25)
                {

                    totalCompra = valorProduto + 5;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$5,00";
                    lblValorFrete2.Text = "R$5,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "São Paulo";
                    lblPrazo.Text = "3 dias úteis";
                }

                //Rio de Janeiro
                if (ddlEstado.SelectedIndex == 19)
                {
                    totalCompra = valorProduto + 7;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$7,00";
                    lblValorFrete2.Text = "R$7,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Rio de Janeiro";
                    lblPrazo.Text = "5 dias úteis";
                }

                //REGIÃO NORTE E NORDESTE
                //Acre
                if (ddlEstado.SelectedIndex == 1)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Acre";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Alagoas
                if (ddlEstado.SelectedIndex == 2)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Alagoas";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Amapá
                if (ddlEstado.SelectedIndex == 3)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Amapá";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Amazonas
                if (ddlEstado.SelectedIndex == 4)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Amazonas";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Bahia
                if (ddlEstado.SelectedIndex == 5)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Bahia";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Ceará
                if (ddlEstado.SelectedIndex == 6)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Ceará";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Maranhão
                if (ddlEstado.SelectedIndex == 10)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Maranhão";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Pará
                if (ddlEstado.SelectedIndex == 14)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Pará";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Paraíba
                if (ddlEstado.SelectedIndex == 15)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =
                         totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Paraíba";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Pernambuco
                if (ddlEstado.SelectedIndex == 17)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text = totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Pernambuco";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Piauí
                if (ddlEstado.SelectedIndex == 18)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Piauí";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Rio Grande do Norte
                if (ddlEstado.SelectedIndex == 20)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Rio Grande do Norte";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Rondônia
                if (ddlEstado.SelectedIndex == 22)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Rondônia";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Roraima
                if (ddlEstado.SelectedIndex == 23)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Roraima";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Sergipe
                if (ddlEstado.SelectedIndex == 26)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Sergipe";
                    lblPrazo.Text = "10 dias úteis";
                }

                //Tocantins
                if (ddlEstado.SelectedIndex == 27)
                {
                    totalCompra = valorProduto + 15;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$15,00";
                    lblValorFrete2.Text = "R$15,00";
                    lblValorTotal.Text = totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Tocantins";
                    lblPrazo.Text = "10 dias úteis";
                }

                //OUTROS ESTADOS
                //Distrito Federal
                if (ddlEstado.SelectedIndex == 7)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text = totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Distrito Federal";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Espírito Santo
                if (ddlEstado.SelectedIndex == 8)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Espírito Santo";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Goiás
                if (ddlEstado.SelectedIndex == 9)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Goiás";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Mato Grosso
                if (ddlEstado.SelectedIndex == 11)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Mato Grosso";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Mato Grosso do Sul
                if (ddlEstado.SelectedIndex == 12)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text = totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Mato Grosso do Sul";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Minas Gerais
                if (ddlEstado.SelectedIndex == 13)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text = lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text = totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Minas Gerais";
                    lblPrazo.Text = "7 dias úteis";

                }

                //Paraná
                if (ddlEstado.SelectedIndex == 16)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Paraná";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Rio Grande do Sul
                if (ddlEstado.SelectedIndex == 21)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00"; 
                    lblValorTotal.Text = totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Rio Grande do Sul";
                    lblPrazo.Text = "7 dias úteis";
                }

                //Santa Catarina
                if (ddlEstado.SelectedIndex == 24)
                {
                    totalCompra = valorProduto + 10;

                    lblValorCompra.Text =  lblValorCompra.Text.Replace('.', ',');
                    lblValorFrete.Text = "R$10,00";
                    lblValorFrete2.Text = "R$10,00";
                    lblValorTotal.Text =  totalCompra.ToString("#0.00");

                    lblEstadoEntrega.Text = "Santa Catarina";
                    lblPrazo.Text = "7 dias úteis";
                }

            }


            Session["valorFrete"] = lblValorFrete.Text;
            Session["valorTotal"] = lblValorTotal.Text;

        }

        catch { }
    }



  
}