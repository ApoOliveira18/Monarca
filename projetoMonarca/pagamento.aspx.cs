using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class pagamento : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack == false)
        {
            lblParcela.Text = "";
            cartaoCredito.Style.Add("display", "none");

            lblValorCompra.Text = Session["valorCompra"].ToString();
            lblValorFrete.Text = Session["valorFrete"].ToString();
            lblValorTotal.Text = Session["valorTotal"].ToString();

            parcela();
            CarregaParcelas();
            ddlParcela.SelectedIndex = 0;
        }

    }

    public void CarregaParcelas()
    {
        ddlParcela.Items.Clear();

        ddlParcela.Items.Add(new ListItem("1x de " + Session["valorParcela1"]));
            ddlParcela.Items.Add(new ListItem("2x de " + Session["valorParcela2"]));
            ddlParcela.Items.Add(new ListItem("3x de " + Session["valorParcela3"]));
            ddlParcela.Items.Add(new ListItem("4x de " + Session["valorParcela4"]));
            ddlParcela.Items.Add(new ListItem("5x de " + Session["valorParcela5"]));
            ddlParcela.Items.Add(new ListItem("6x de " + Session["valorParcela6"]));
            ddlParcela.Items.Add(new ListItem("7x de " + Session["valorParcela7"]));
            ddlParcela.Items.Add(new ListItem("8x de " + Session["valorParcela8"]));
            ddlParcela.Items.Add(new ListItem("9x de " + Session["valorParcela9"]));
            ddlParcela.Items.Add(new ListItem("10x de " + Session["valorParcela10"]));
            ddlParcela.Items.Add(new ListItem("11x de " + Session["valorParcela11"]));
            ddlParcela.Items.Add(new ListItem("12x de " + Session["valorParcela12"]));
        
    }
    protected void rbFormasPag_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbFormasPag.SelectedIndex == 0)
        {

        }
        if (rbFormasPag.SelectedIndex == 1)
        {
            cartaoCredito.Style.Add("display", "");

        }

        
    }
    protected void btnComprar_Click(object sender, EventArgs e)
    {
        Session["novaCompra"] = "Não";
        sqlItensComprados.Update();

        //DELETAR AS VENDAS NÃO CONCLUIDAS
       // sqlFinalizarVenda.Delete();

        //TERMINAR A VENDA
        sqlFinalizarVenda.InsertParameters["preco"].DefaultValue = cripto.Encrypt(lblValorTotal.Text);
        sqlFinalizarVenda.Insert();
        Response.Redirect("CompraFinalizada.aspx");
    }

    public void parcela()
    {
        double valorParcela;
        double preco;   
        
        preco = Convert.ToDouble(lblValorTotal.Text);
      
        valorParcela = preco / 1;
        Session["valorParcela1"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 2;
        Session["valorParcela2"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 3;
        Session["valorParcela3"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 4;
        Session["valorParcela4"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 5;
        Session["valorParcela5"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 6;
        Session["valorParcela6"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 7;
        Session["valorParcela7"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 8;
        Session["valorParcela8"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 9;
        Session["valorParcela9"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 10;
        Session["valorParcela10"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 11;
        Session["valorParcela11"] = valorParcela.ToString("#0.00");

        valorParcela = preco / 12;
        Session["valorParcela12"] = valorParcela.ToString("#0.00");

    }
    protected void ddlParcela_SelectedIndexChanged(object sender, EventArgs e)
    {
        qtdParcelas();
        cartaoCredito.Style.Add("display", "");
    }
    public void qtdParcelas()
    {
        try
        {

            if (ddlParcela.SelectedIndex == 0) //1
            {
                Session["parcela"] = 1;
                lblParcela.Text = "1x de " + Session["valorParcela1"];
            }
            if (ddlParcela.SelectedIndex == 1) //2
            {
                Session["parcela"] = 2;
                lblParcela.Text = "2x de " + Session["valorParcela2"];
            }
            if (ddlParcela.SelectedIndex == 2) //1
            {
                Session["parcela"] = 3;
                lblParcela.Text = "3x de " + Session["valorParcela3"];
            }
            if (ddlParcela.SelectedIndex == 3) //1
            {
                Session["parcela"] = 4;
                lblParcela.Text = "4x de " + Session["valorParcela3"];
            }
            if (ddlParcela.SelectedIndex == 4) //1
            {
                Session["parcela"] = 5;
                lblParcela.Text = "5x de " + Session["valorParcela4"];
            }
            if (ddlParcela.SelectedIndex == 5) //1
            {
                Session["parcela"] = 6;
                lblParcela.Text = "6x de " + Session["valorParcela5"];
            }
            if (ddlParcela.SelectedIndex == 6) //1
            {
                Session["parcela"] = 7;
                lblParcela.Text = "7x de " + Session["valorParcela6"];

            }
            if (ddlParcela.SelectedIndex == 7) //1
            {
                lblParcela.Text = "8x de " + Session["valorParcela7"];
                Session["parcela"] = 8;
            }
            if (ddlParcela.SelectedIndex == 8) //1
            {
                Session["parcela"] = 9;
                lblParcela.Text = "9x de " + Session["valorParcela8"];
            }
            if (ddlParcela.SelectedIndex == 9) //1
            {
                Session["parcela"] = 10;
                lblParcela.Text = "10x de " + Session["valorParcela9"];
            }
            if (ddlParcela.SelectedIndex == 10) //1
            {
                Session["parcela"] = 11;
                lblParcela.Text = "11x de " + Session["valorParcela11"];
            }
            if (ddlParcela.SelectedIndex == 11) //1
            {
                Session["parcela"] = 12;
                lblParcela.Text = "12x de " + Session["valorParcela12"];

            }
        }
        catch { }
    }
}