using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class CadastroML : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");
    }
    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
            DataView dv;

            sqlVerificarExistente.SelectParameters["ML"].DefaultValue = cripto.Encrypt(txtML.Text + "ml");
            //sqlVerificarExistente.SelectParameters["ML"].DefaultValue = txtML.Text + "ml";
            dv = (DataView)sqlVerificarExistente.Select(DataSourceSelectArguments.Empty);
         
            if (dv.Table.Rows.Count != 0)
            {
                lblExistente.Text = "Esse conteúdo já existe!";
                lblObr.Text = "";
            }
            else
            {
                
                if (txtAcres.Text == "")
                {
                    Session["ml"] = txtML.Text + "ml";


                    sqlCadastrarMLSemAdd.InsertParameters["ML"].DefaultValue = cripto.Encrypt(txtML.Text + "ml");
                    sqlCadastrarMLSemAdd.InsertParameters["adicional"].DefaultValue = cripto.Encrypt("0");
                    sqlCadastrarMLSemAdd.Insert();


                }
                else
                {
                    Session["ml"] = txtML.Text + "ml";
                    Session["Adicional"] = txtAcres.Text.Replace(',', '.');
                    sqlCadastrarML.InsertParameters["ML"].DefaultValue = cripto.Encrypt(txtML.Text + "ml");
                    sqlCadastrarML.InsertParameters["adicional"].DefaultValue = cripto.Encrypt(txtAcres.Text);
                                        
                    sqlCadastrarML.Insert();
                }




                //REGISTRO 
                DateTime dtCad = DateTime.Today;
                String dataCadastro = dtCad.ToString("yyyy/MM/dd");
                sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Cadastro ML");
                sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro;
                sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


                sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt(txtML.Text + "ml");
                sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                sqlRegistro.Insert();
                Response.Redirect("CadastroSucesso.aspx");
            }
        
    }
}