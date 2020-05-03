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

using System.Net.Mail; // importe o namespace .Net.Mail
using System.Net.Mime;

public partial class _Default : System.Web.UI.Page
{
    Criptografia cripto = new Criptografia("@@Monarca123");

    protected void Page_Load(object sender, EventArgs e)
    {
        lblConfere.Text = "";
        lblConfere.Visible = false;

        lblExigenciasSenha.Text = "Mínimo de 8 caracteres com letras maiúsculas e minúsculas";
        if(!IsPostBack)
        {
            senha.Style.Add("display", "none");
        }

        if (Session["NomeCli"] != null) {
            txtNome.Text = Session["NomeCli"].ToString();
        }

        if (Session["EmailCli"] != null)
        {
            txtEmail.Text = Session["EmailCli"].ToString();
        }


    }

    protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSexo.SelectedIndex == 1)
        {
            Session["sexo"] = cripto.Encrypt("Masculino");
        }

        if (ddlSexo.SelectedIndex == 2)
        {
           Session["sexo"] = cripto.Encrypt("Feminino");
        }
    }

    protected void ddlEstCiv_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlEstCiv.SelectedIndex == 1)
        {
            Session["estciv"] = cripto.Encrypt("Casado");
        }

        if (ddlEstCiv.SelectedIndex == 2)
        {
            Session["estciv"] = cripto.Encrypt("Solteiro");
        }

        if (ddlEstCiv.SelectedIndex == 3)
        {
            Session["estciv"] = cripto.Encrypt("Divorciado");
        }

        if (ddlEstCiv.SelectedIndex == 4)
        {
            Session["estciv"] = cripto.Encrypt("Viúvo");
        }
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        HttpWebRequest requisicao = (HttpWebRequest)WebRequest.Create("http://www.buscacep.correios.com.br/servicos/dnec/consultaLogradouroAction.do?Metodo=listaLogradouro&CEP=" + txtCEP.Text + "&TipoConsulta=cep");
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

            lblErro.Text = "CEP NÃO LOCALIZADO.";
            txtRua.Text = "";
            txtBairro.Text = "";
            txtCidade.Text = "";
            txtEstado.Text = "";
        }

        else
        {
            txtRua.Text = Regex.Match(pagina, "<td width=\"268\" style=\"padding: 2px\">(.*)</td>").Groups[1].Value;
            txtBairro.Text = Regex.Matches(pagina, "<td width=\"140\" style=\"padding: 2px\">(.*)</td>")[0].Groups[1].Value;
            txtCidade.Text = Regex.Matches(pagina, "<td width=\"140\" style=\"padding: 2px\">(.*)</td>")[1].Groups[1].Value;
            txtEstado.Text = Regex.Match(pagina, "<td width=\"25\" style=\"padding: 2px\">(.*)</td>").Groups[1].Value;

            lblErro.Text = "";
        }
    }

    protected void btnCadastrar_Click(object sender, EventArgs e)
    {
        try
        {
            sqlVerificarUsuarioEscolhido.SelectParameters["usu_escolhido"].DefaultValue = cripto.Encrypt(txtUsuario.Text);
            DataView dv = (DataView)sqlVerificarUsuarioEscolhido.Select(DataSourceSelectArguments.Empty); //usuário (1)

            sqlVerificarEmailEscolhido.SelectParameters["email_escolhido"].DefaultValue = cripto.Encrypt(txtEmail.Text);           
            DataView dv2 = (DataView)sqlVerificarEmailEscolhido.Select(DataSourceSelectArguments.Empty); //e-mail (2)

            sqlVerificarCPFInserido.SelectParameters["cpf_inserido"].DefaultValue = cripto.Encrypt(txtCPF.Text);
            DataView dv3 = (DataView)sqlVerificarCPFInserido.Select(DataSourceSelectArguments.Empty); //CPF (3)

            Session["RGVerificado"] = null;
            if (txtRG.Text != "")
            {
                sqlVerificarRGInserido.SelectParameters["rg_inserido"].DefaultValue = cripto.Encrypt(txtRG.Text);
                DataView dv4 = (DataView)sqlVerificarRGInserido.Select(DataSourceSelectArguments.Empty); //RG (4)

                if (dv4.Table.Rows.Count == 0)
                {
                    sqlCadastro.InsertParameters["rg"].DefaultValue = cripto.Encrypt(txtRG.Text);
                }

                else
                {
                    Session["RGVerificado"] = "JáExiste";
                }
            }

            else
            {
                sqlCadastro.InsertParameters["rg"].DefaultValue = "";
            }


            //EFETUAR CADASTRO
            if (dv.Table.Rows.Count == 0 && dv2.Table.Rows.Count == 0 && dv3.Table.Rows.Count == 0 && Session["RGVerificado"] == null) //tudo certo pro cadastro
            {
                lblUsuarioJaExiste.Text = "";
                lblEmailJaCadastrado.Text = "";
                lblCPFUsado.Text = "";
                lblRGUsado.Text = "";
                
                //CONFIRMA IDADE 
                DateTime dt = Convert.ToDateTime(txtDataNascimento.Text);
                String dataCorreta = dt.ToString("yyyy/MM/dd");

                DateTime dtCad = DateTime.Today;
                String dataCadastro = dtCad.ToString("yyyy/MM/dd");

                DateTime dtNascimentoMax = DateTime.Now.AddYears(-18);

                if (dt < dtNascimentoMax)
                {
                    verificarForcaSenha();
                    cadastrar();
                }

                else
                {
                    lblMaiores18.Text = "Somente maiores de 18 anos podem se cadastrar no site.";
                }
                
            }

            else //tem coisa errada
            {
                lblConfere.Text = "Algo não confere para o sucesso do Cadastro. Verifique abaixo, por favor";
                lblConfere.Visible = true;
                if (dv.Table.Rows.Count != 0) //usuário (1) já existe
                {
                    lblUsuarioJaExiste.Text = "Este nome de usuário já existe. Por favor, escolha outro.";
                }

                else
                {
                    lblUsuarioJaExiste.Text = "";
                }

                if (dv2.Table.Rows.Count != 0) //e-mail (2) já existe
                {
                    lblEmailJaCadastrado.Text = "Já existe um cadastro com este e-mail. Deseja recuperar sua senha?";
                    lbEsqueceuSuaSenha.Visible = true;
                }

                else
                {
                    lblEmailJaCadastrado.Text = "";
                    lbEsqueceuSuaSenha.Visible = false;
                }

                if (dv3.Table.Rows.Count != 0) //CPF (3) já existe
                {
                    lblCPFUsado.Text = "Este CPF já está sendo usado.";
                }

                else
                {
                    lblCPFUsado.Text = "";
                }

                if (Session["RGVerificado"] == "JáExiste") //RG (4) já existe
                {
                    lblRGUsado.Text = "Este RG já está sendo usado.";
                }

                else
                {
                    lblRGUsado.Text = "";
                }
            }
        }
        catch 
            //(FormatException)
        {
           // lblMaiores18.Text = "Somente maiores de 18 anos podem se cadastrar no site.";
        }
    }
    public void cadastrar() {

        if (imgForcaSenha.ImageUrl == "~\\img\\medio.png" || imgForcaSenha.ImageUrl == "~\\img\\forte.png")
        {
            lbEsqueceuSuaSenha.Visible = false;
            lblConfere.Text = "";
            lblConfere.Visible = false;

            DateTime dt = Convert.ToDateTime(txtDataNascimento.Text);
            String dataCorreta = dt.ToString("yyyy/MM/dd");

            DateTime dtCad = DateTime.Today;
            String dataCadastro = dtCad.ToString("yyyy/MM/dd");

                lblMaiores18.Text = "";

                sqlCadastro.InsertParameters["datanasc"].DefaultValue = cripto.Encrypt(dataCorreta);
                // sqlCadastro.InsertParameters["datanasc"].DefaultValue = dataCorreta;
                sqlCadastro.InsertParameters["datacad"].DefaultValue = (dataCadastro);

                sqlCadastro.InsertParameters["nome"].DefaultValue = cripto.Encrypt(txtNome.Text);
                sqlCadastro.InsertParameters["usuario"].DefaultValue = cripto.Encrypt(txtUsuario.Text);
                sqlCadastro.InsertParameters["email"].DefaultValue = cripto.Encrypt(txtEmail.Text);
                sqlCadastro.InsertParameters["senha"].DefaultValue = cripto.Encrypt(txtSenha.Text);

                sqlCadastro.InsertParameters["cpf"].DefaultValue = cripto.Encrypt(txtCPF.Text);
                sqlCadastro.InsertParameters["tel1"].DefaultValue = cripto.Encrypt(txtTel1.Text);
                sqlCadastro.InsertParameters["tel2"].DefaultValue = cripto.Encrypt(txtTel2.Text);

                sqlCadastro.InsertParameters["cep"].DefaultValue = cripto.Encrypt(txtCEP.Text);
                // sqlCadastro.InsertParameters["numero"].DefaultValue = cripto.Encrypt(txtNumero.Text);
                sqlCadastro.InsertParameters["complemento"].DefaultValue = cripto.Encrypt(txtComplemento.Text);

                sqlCadastro.InsertParameters["sexo"].DefaultValue = Session["sexo"].ToString();
                sqlCadastro.InsertParameters["estciv"].DefaultValue = Session["estciv"].ToString();

                sqlCadastro.InsertParameters["pergunta"].DefaultValue = cripto.Encrypt(txtPergSecreta.Text);
                sqlCadastro.InsertParameters["resposta"].DefaultValue = cripto.Encrypt(txtRespSecreta.Text);

                sqlCadastro.Insert();

                Session["RGVerificado"] = null;
                Response.Redirect("CadastroClienteSucesso.aspx");
           
        }
    }

    protected void btnVoltar_Click(object sender, EventArgs e)
    {
        Response.Redirect("index.aspx");
    }

    protected void lbEsqueceuSuaSenha_Click(object sender, EventArgs e)
    {
        Response.Redirect("PerfilCliente_EsqueceuSuaSenha.aspx");
    }


   

    public void verificarForcaSenha()
    {
        lblExigenciasSenha.Text = "";
        senha.Style.Add("display", "");

        lblConfere.Text = "Algo não confere para o sucesso do Cadastro. Verifique abaixo, por favor";
        lblConfere.Visible = true;
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

            imgForcaSenha.Visible = true;

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

    