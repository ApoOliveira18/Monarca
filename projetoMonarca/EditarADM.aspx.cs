using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class EditarADM : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["logado"] != "Entrar")
            Response.Redirect("LoginADM.aspx");

        if (!IsPostBack)
        {
            senha.Style.Add("display", "none");
        }

        if (IsPostBack == false)
        {
             
             DataView dv = (DataView)sqlADMCadastrado.Select(DataSourceSelectArguments.Empty);
             descriptoGRID();
            //mostrar dados do cliente no TextBox
            txtUsuario.Text = cripto.Decrypt(dv.Table.Rows[0]["login_adm"].ToString());
            txtEmail.Text = cripto.Decrypt(dv.Table.Rows[0]["email_adm"].ToString());

            Session["senhaAntiga"] = cripto.Decrypt(dv.Table.Rows[0]["senha_adm"].ToString());
            Session["dataCad"] = dv.Table.Rows[0]["data_conta"].ToString();
        }

    }
    protected void btnEditar_Click(object sender, EventArgs e)
    {
         verificarForcaSenha();
         //SÓ EFETUA O CADASTRO PARA SENHAS MÉDIAS OU FORTES
         if (imgForcaSenha.ImageUrl == "~\\img\\medio.png" || imgForcaSenha.ImageUrl == "~\\img\\forte.png")
         {

        //1 - CADASTRAR O ADM NOVO
            if (txtSenha.Text == txtConfSenha.Text)
            {
                if (txtSenha.Text != Session["senhaAntiga"].ToString())
                {
                    DateTime dtCad = DateTime.Today;
                    String dataCadastro = dtCad.ToString("yyyy/MM/dd");
                    sqlNovosDados.UpdateParameters["datacad"].DefaultValue = (dataCadastro);
                }
                else
                {
                    sqlNovosDados.UpdateParameters["datacad"].DefaultValue = Session["dataCad"].ToString();
                }
                sqlNovosDados.UpdateParameters["usuario"].DefaultValue = cripto.Encrypt(txtUsuario.Text);
                sqlNovosDados.UpdateParameters["email"].DefaultValue = cripto.Encrypt(txtEmail.Text);
                sqlNovosDados.UpdateParameters["senha"].DefaultValue = cripto.Encrypt(txtSenha.Text);
                sqlNovosDados.Update();


                //REGISTRO 
                DateTime dtCad1 = DateTime.Today;
                String dataCadastro1 = dtCad1.ToString("yyyy/MM/dd");
                sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Edição ADM");
                sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro1;
                sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");


                sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt(txtUsuario.Text);
                sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt("-");
                sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");

                sqlRegistro.Insert();

                // - CONFIRMAR
                Response.Redirect("EditarSucesso.aspx");
            }            
             
         }
    }
    public void descriptoGRID()
    {
        DataView dv = (DataView)sqlADMCadastrado.Select(DataSourceSelectArguments.Empty);
        DataTable novaTB = new DataTable();

        //CRIANDO AS COLUNAS UMA A UMA PARA INFORMAR QUAL O TIPO DE CADA INFORMAÇÃO APÓS A CRIPTOGRAFIA
        novaTB.Columns.Add("id_adm", typeof(int));
        novaTB.Columns.Add("login_adm", typeof(string));
        novaTB.Columns.Add("email_adm", typeof(string));
        novaTB.Columns.Add("data_conta", typeof(string));


        // varrendo as linhas da tabela criptografadas
        // 1 a 1 para descriptografar
        for (int i = 0; i < dv.Table.Rows.Count; i++)
        {
            // 1. criar a linha
            DataRow linha = novaTB.NewRow();

            // 2. descriptografar
            linha["id_adm"] = dv.Table.Rows[i]["id_adm"].ToString();
            linha["login_adm"] = cripto.Decrypt(dv.Table.Rows[i]["login_adm"].ToString());
            linha["email_adm"] = cripto.Decrypt(dv.Table.Rows[i]["email_adm"].ToString());

            DateTime dtCadastro = Convert.ToDateTime(dv.Table.Rows[i]["data_conta"].ToString());
            String dtCadastroCerto = dtCadastro.ToString("dd/MM/yyyy");
            linha["data_conta"] = dtCadastroCerto;

            // 3. adicionar a linha na novaTB
            novaTB.Rows.Add(linha);
        }

        gvExibir.DataSource = novaTB;
        gvExibir.DataBind();

    }
    
    public void verificarForcaSenha()
    {
        lblExigenciasSenha.Text = "";


        txtSenha.Attributes.Add("value", txtSenha.Text);

        //MEDIDOR DE SEGURANÇA DA SENHA
        int qtdLetras, qtdLetMai = 0, qtdLetMin = 0, qtdNum = 0, qtdCar = 0;
        qtdLetras = txtSenha.Text.Length;

        if (qtdLetras < 8)
        {
            imgForcaSenha.Visible = false;
            lblSenhaCurta.Text = "As senhas devem ter no mínimo 8 caracteres e pelo menos duas das seguintes opções: letras maiúsculas, letras minúsculas, números e símbolos.";
            txtSenha.Text = "";
            txtConfSenha.Text = "";
        }

        else
        {
            senha.Style.Add("display", "");
            imgForcaSenha.Visible = false;

            for (int i = 0; i < qtdLetras; i++) //começa em zero, vai até a qtd. de caract., andando de 1 em 1
            {
                if (char.IsLower(txtSenha.Text[i]))
                {
                    qtdLetMin++;
                }

                else
                {
                    if (char.IsUpper(txtSenha.Text[i]))
                    {
                        qtdLetMai++;
                    }

                    else
                    {
                        if (char.IsNumber(txtSenha.Text[i]))
                        {
                            qtdNum++;
                        }

                        else
                        {
                            if (!char.IsWhiteSpace(txtSenha.Text[i]))
                            {
                                qtdCar++;
                            }
                        }
                    }
                }
            }

            //começa a medir aqui
            if (qtdCar != 0 && qtdLetMai != 0 && qtdLetMin != 0 && qtdNum != 0)
            {
                imgForcaSenha.Visible = true;
                imgForcaSenha.ImageUrl = "~\\img\\forte.png";
                lblSenhaCurta.Text = "";
            }

            else
            {
                if (qtdCar != 0) //caractere especial
                {
                    if (qtdLetMai != 0 && qtdLetMin != 0) //maiúscula e minúscula
                    {
                        imgForcaSenha.Visible = true;
                        imgForcaSenha.ImageUrl = "~\\img\\medio.png";
                        lblSenhaCurta.Text = "";
                    }

                    else
                    {

                        if (qtdLetMai != 0 && qtdNum != 0) //maiúscula e número
                        {
                            imgForcaSenha.Visible = true;
                            imgForcaSenha.ImageUrl = "~\\img\\medio.png";
                            lblSenhaCurta.Text = "";
                        }

                        else
                        {
                            if (qtdLetMin != 0 && qtdNum != 0) //minúscula e número
                            {
                                imgForcaSenha.Visible = true;
                                imgForcaSenha.ImageUrl = "~\\img\\medio.png";
                                lblSenhaCurta.Text = "";
                            }

                            else
                            {
                                imgForcaSenha.Visible = true;
                                imgForcaSenha.ImageUrl = "~\\img\\fraco.png";
                                lblSenhaCurta.Text = "Inclua letras maiúsculas e minúsculas, números e símbolos";
                            }
                        }
                    }
                }

                else
                {
                    if (qtdLetMai != 0) //letras maiúsculas
                    {
                        if (qtdLetMin != 0 && qtdNum != 0) //minúsculas e números
                        {
                            imgForcaSenha.Visible = true;
                            imgForcaSenha.ImageUrl = "~\\img\\medio.png";
                            lblSenhaCurta.Text = "";
                        }

                        else
                        {
                            imgForcaSenha.Visible = true;
                            imgForcaSenha.ImageUrl = "~\\img\\fraco.png";
                            lblSenhaCurta.Text = "Inclua letras maiúsculas e minúsculas, números e símbolos";
                        }
                    }

                    else
                    {
                        imgForcaSenha.Visible = true;
                        imgForcaSenha.ImageUrl = "~\\img\\fraco.png";
                        lblSenhaCurta.Text = "Inclua letras maiúsculas e minúsculas, números e símbolos";
                    }
                }
            }
        }
    }
}