using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;



public partial class css_CadastroADM : System.Web.UI.Page
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

        lblExigenciasSenha.Text = "Mínimo de 8 caracteres; diferencia maiúsculas de minúsculas";
    }

    protected void btnCadastrar_Click1(object sender, EventArgs e)
    {

        sqlVerificarExistenciaUsuario.SelectParameters["USUARIO"].DefaultValue = cripto.Encrypt(txtUsuario.Text);
        DataView dv = (DataView)sqlVerificarExistenciaUsuario.Select(DataSourceSelectArguments.Empty);
        if (dv.Table.Rows.Count != 0)
        {
            lblExistente.Text = "Usuário já cadastrado!";
            lblExistente2.Text = "";
            
        }

        else
        {
            sqlVerificarExistenciaEmail.SelectParameters["EMAIL"].DefaultValue = cripto.Encrypt(txtEmail.Text);
            DataView dv2 = (DataView)sqlVerificarExistenciaEmail.Select(DataSourceSelectArguments.Empty);
            if (dv2.Table.Rows.Count != 0)
            {
                lblExistente2.Text = "Email já cadastrado!";
                lblExistente.Text = "";
            
            }
            else
            {

                verificarForcaSenha();
                //SÓ EFETUA O CADASTRO PARA SENHAS MÉDIAS OU FORTES
                if (imgForcaSenha.ImageUrl == "~\\img\\medio.png" || imgForcaSenha.ImageUrl == "~\\img\\forte.png")
                {

                    sqlCadastroFuncionarios.InsertParameters["usuario"].DefaultValue = cripto.Encrypt(txtUsuario.Text);
                    sqlCadastroFuncionarios.InsertParameters["email"].DefaultValue = cripto.Encrypt(txtEmail.Text);
                    sqlCadastroFuncionarios.InsertParameters["senha"].DefaultValue = cripto.Encrypt(txtSenha.Text);
                    sqlCadastroFuncionarios.InsertParameters["perg"].DefaultValue = cripto.Encrypt(txtPergSecreta.Text);
                    sqlCadastroFuncionarios.InsertParameters["resp"].DefaultValue = cripto.Encrypt(txtRespSecreta.Text);


                    DateTime dtCad = DateTime.Today;
                    String dataCadastro = dtCad.ToString("yyyy/MM/dd");
                    sqlCadastroFuncionarios.InsertParameters["datacad"].DefaultValue = dataCadastro;
                    sqlCadastroFuncionarios.Insert();

                    //CRIAR SESSION 
                    sqlCriarSessionFuncCadastrado.SelectParameters["func"].DefaultValue = cripto.Encrypt(txtUsuario.Text);
                    DataView dv1 = (DataView)sqlCriarSessionFuncCadastrado.Select(DataSourceSelectArguments.Empty);
                    Session["func"] = dv1.Table.Rows[0]["login_func"].ToString();

                    //REGISTRO
                    sqlRegistro.InsertParameters["data"].DefaultValue = dataCadastro;
                    sqlRegistro.InsertParameters["registro"].DefaultValue = cripto.Encrypt("Cadastro Funcionário");
                    sqlRegistro.InsertParameters["func"].DefaultValue = cripto.Encrypt(txtUsuario.Text);

                    sqlRegistro.InsertParameters["adm"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["cliente"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["prod"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["ml"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["promo"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["linha"].DefaultValue = cripto.Encrypt("-");
                    sqlRegistro.InsertParameters["genero"].DefaultValue = cripto.Encrypt("-");
                    
                    sqlRegistro.Insert();
                    Response.Redirect("CadastroFuncionarioSucesso.aspx");
                }
                
            }
        }
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