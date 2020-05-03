using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ClienteLogado"] != "Entrar")
        {
            Response.Redirect("PerfilCliente_Entrar.aspx");
        }


        if (!IsPostBack)
        {
            senha.Style.Add("display", "none");
        }

        lblExigenciasSenha.Text = "Mínimo de 8 caracteres; diferencia maiúsculas de minúsculas";
    }

    protected void btnSair_Click(object sender, EventArgs e)
    {
        Response.Redirect("index.aspx");
    }

    protected void btnSalvar_Click(object sender, EventArgs e)
    {
        txtSenhaAtual.Attributes.Add("value", txtSenhaAtual.Text);

        DataView dv = (DataView)sqlCompararSenhaAntiga.Select(DataSourceSelectArguments.Empty);

        string senhaAntiga;
        senhaAntiga = cripto.Decrypt(dv.Table.Rows[0]["senha_cli"].ToString());
        //1 - VERIFICAR SE A SENHA ANTIGA ESTÁ CERTA
        if (senhaAntiga == txtSenhaAtual.Text)
            {
                verificarForcaSenha();
                cadastrar();
            }

        else
        {
            lblErro.Text = "SENHA ATUAL NÃO CORRESPONDE.";
        }

    }

    public void cadastrar()
    {
        if (imgForcaSenha.ImageUrl == "~\\img\\medio.png" || imgForcaSenha.ImageUrl == "~\\img\\forte.png")
        {
            if (txtConfSenha.Text == txtNovaSenha.Text)
            {
                //1 - CADASTRAR A SENHA NOVA
                DateTime dtAlt = DateTime.Now;
                String dataSenha = dtAlt.ToString("yyyy/MM/dd");

                sqlNovosDados.UpdateParameters["data_alt"].DefaultValue = dataSenha;
                sqlNovosDados.UpdateParameters["novaSenha"].DefaultValue = cripto.Encrypt(txtNovaSenha.Text);
                sqlNovosDados.Update();

                //2 - CONFIRMAR
                Response.Redirect("PerfilCliente_MeusDados.aspx");
            }
           
        }

    }
    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("PerfilCliente_MeusDados.aspx");
    }
    protected void btnVerificarForcaSenha_Click(object sender, EventArgs e)
    {
        verificarForcaSenha();
    }

    public void verificarForcaSenha()
    {
        lblExigenciasSenha.Text = "";
        lblErro.Text = "";

        txtNovaSenha.Attributes.Add("value", txtNovaSenha.Text);

        //MEDIDOR DE SEGURANÇA DA SENHA
        int qtdLetras, qtdLetMai = 0, qtdLetMin = 0, qtdNum = 0, qtdCar = 0;
        qtdLetras = txtNovaSenha.Text.Length;

        if (qtdLetras < 8)
        {
            imgForcaSenha.Visible = false;
            lblSenhaCurta.Text = "As senhas devem ter no mínimo 8 caracteres e pelo menos duas das seguintes opções: letras maiúsculas, letras minúsculas, números e símbolos.";
            txtNovaSenha.Text = "";
            txtConfSenha.Text = "";
        }

        else
        {
            senha.Style.Add("display", "");
            imgForcaSenha.Visible = false;

            for (int i = 0; i < qtdLetras; i++) //começa em zero, vai até a qtd. de caract., andando de 1 em 1
            {
                if (char.IsLower(txtNovaSenha.Text[i]))
                {
                    qtdLetMin++;
                }

                else
                {
                    if (char.IsUpper(txtNovaSenha.Text[i]))
                    {
                        qtdLetMai++;
                    }

                    else
                    {
                        if (char.IsNumber(txtNovaSenha.Text[i]))
                        {
                            qtdNum++;
                        }

                        else
                        {
                            if (!char.IsWhiteSpace(txtNovaSenha.Text[i]))
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
