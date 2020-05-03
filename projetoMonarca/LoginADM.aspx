<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginADM.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Monarca: Setor Administrativo</title>  

  <link href="css/adm_estilo.css" rel="stylesheet" type="text/css" />

  <style>
  
    /* Check - http://www.designcouch.com/home/why/2013/05/13/styling-form-radio-buttons/ */


	input[type="checkbox"] {
	position:			absolute;
	opacity: 			0;
	-moz-opacity: 		0;
	-webkit-opacity: 	0;
	-o-opacity: 		0;
	}

	input[type="checkbox"] + label {
	position: 			relative;
	padding: 			0 0 0 2px;
	font-size: 			16px;
	line-height: 		25px;
	margin:				0 0 10px 0;
	color: 				#fff;
	}

	input[type="checkbox"] + label:before {
	content: 			"";
	display: 			block;
	position: 			absolute;
	top: 				2px;
	height: 			14px;
	width: 				14px;
	background: 		transparent;
	border: 			1px solid white;
	box-shadow: 		inset 0px 0px 0px 2px white;
	-webkit-box-shadow: inset 0px 0px 0px 2px white;
	-moz-box-shadow: 	inset 0px 0px 0px 2px white;
	-o-box-shadow: 		inset 0px 0px 0px 2px white;
	}

	input[type="checkbox"]:checked + label:before {
	background: 		#666;
	}

	/*fim do checkbox*/
	

  body 
  {
      background-color:#000;
      font-family: "Century Gothic";
  }
  
 #img-login
 {
     height: 700px;
     width: 400px;
     margin: 0 auto;
     margin-top: 0px;
     background: url("images/fundo-do-login.png");

      }
 
 #caixa-login
 {
     height: 200px;
     width:  400px;
     background: transparent;
     margin: 0 auto;
     margin-top: 320px;
     /*border:solid 2px #fff;*/
    -moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    border-radius: 20px;    
    color: #fff;
     }
     
     #titulo-caixa
     {
    height: 28px;
    width: 100%;
    /*border-bottom: solid 1px #fff;*/
    text-align: center;
    font-size: 1.5em;
    margin-top: 10px;
         }

  .texto-login
  { 
      width:49%;
      height:42px;
      /*border-right: solid 1px #fff;
      border-bottom: solid 1px #fff;*/
      float: left;
      font-size: 1.3em;
      padding-top: 24px;  
      text-align:right;
          
      }
      
  .bloco-login
  {
      width:50.5%;
      height:42px;
      /*border-bottom: solid 1px #fff;*/
      float: left;
      font-size: 1.3em;
      padding-top: 24px;
      
      }
      
  .bloco-botao-login1
  {
      width:49%;
      height:66px;
      /*border-right: solid 1px #fff;*/
      float: left;
      font-size: 1.3em;
    
      }
      
  .bloco-botao-login2
  {
      width:49%;
      height:66px;
      float: left;
      font-size: 1.3em;

      
      }
      
    .btnLogin{
	border: none;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    border-radius: 20px;   
    color: #fff;
    width: 128px;
	height:45px;
    margin: 0 auto;
    text-decoration: none;
	background: transparent;
	font-weight: 700;
	margin:0 auto;
	margin-top:3.5px;
	cursor:pointer;
	}
	.btnLogin:hover{
	border: none ;
	-moz-border-radius: 20px;
    -webkit-border-radius: 20px;
    border-radius: 20px; 
    color: #000;
    width: 128px;
	height:45px;
    margin: 0 auto;
    text-decoration: none;
	background: #fff;
	-webkit-transition: all 0.2s;
	-moz-transition: all 0.2s;
	-ms-transition: all 0.2s;
	-o-transition: all 0.2s;
	transition: all 0.2s;
	font-weight: 700;
	margin:0 auto;
	margin-top:3.5px;
	cursor:pointer;
	
	}
	
	.txt-dados
	{
	background-color: transparent;
    border: none;
    border-bottom: 1px solid #fff;
    color: #fff;
    font-family: "PT Sans", sans-serif;
    font-size: 13px;
    outline: 0;
    padding-left: 10px;
    width: 70%;
	    }
	
  </style>

</head>
<body>
<form id="form1" runat="server">


        <div id="img-login">
        <br />
            <div id="caixa-login">

                <div class="texto-login"> Usuário <img src="images/Username.png" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>  

                <div class="bloco-login">  

                <center>
                &nbsp;&nbsp;
                
                <asp:TextBox ID="txtLogin" runat="server" CssClass="txt-dados"></asp:TextBox>
                &nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="*" ControlToValidate="txtLogin"></asp:RequiredFieldValidator>
                </center>
                 </div> 

                <div class="texto-login"> Senha <img src="images/Password.png" />  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>  

                <div class="bloco-login">

                <center>
                &nbsp;&nbsp;
                <asp:TextBox ID="txtSenha" runat="server" TextMode="Password" CssClass="txt-dados"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="*" ControlToValidate="txtSenha"></asp:RequiredFieldValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="txtSenha" ErrorMessage="*" ValidationGroup="2"></asp:RequiredFieldValidator>
                </center>
                </div>    
                
                <div class="bloco-botao-login1">
                <center>
                    <asp:CheckBox ID="chkManterLogado" runat="server" style="font-size: xx-small" Text="Manter conectado" /> 
                </center>

                </div> 
                
                <div class="bloco-botao-login2">
                
                <center>
                  <asp:Button ID="btnOK" runat="server" onclick="btnOK_Click" Text="Entrar" 
                        CssClass="btnLogin" />
                  <asp:Button ID="btnOKApos3Erros" runat="server" onclick="btnOKApos3Erros_Click" Text="Entrar" 
                        CssClass="btnLogin" ValidationGroup="2" Visible="False" />
                </center>

                </div>             

                    
<p>
        <asp:Label ID="lblErro" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>

    </p>
    <p>
         <div id="captcha" runat= "server">
                <asp:TextBox ID="txtimgcode" runat="server" ValidationGroup="2" 
                    CssClass="txt-dados" Width="150px"></asp:TextBox>
                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                      ControlToValidate="txtimgcode" ErrorMessage="*" ValidationGroup="2"></asp:RequiredFieldValidator>
                    &nbsp;<asp:Button ID="btnRecuperar" runat="server" CssClass="btnLogin" 
                      OnClick="btnRecuperar_Click" Text="Recuperar Senha" ValidationGroup="2" />
                 
                    <br />
                <br />
                <asp:Image ID="Image1" runat="server" ImageUrl="~/CImage.aspx"/>
                    <br />
                    <asp:Label ID="lblmsg" runat="server" style="font-weight: 700; color: #FF0000"></asp:Label>
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
             </div>
            </div>

        </div>
    </p>
     <p>
        <asp:SqlDataSource ID="sqlLogin" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            
            
            
            SelectCommand="SELECT login_adm, senha_adm, id_adm FROM adm WHERE (login_adm = @usuario) AND (senha_adm = @senha)">
            <SelectParameters>
                <asp:Parameter Name="usuario" />
                <asp:Parameter Name="senha" />
            </SelectParameters>
        </asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlManterLogado" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT id_rec_adm, login_rec_adm FROM loginrecenteadm"></asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlAtualizarRecente" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM [loginrecenteadm]" 
             UpdateCommand="UPDATE loginrecenteadm SET login_rec_adm = @login">
             <UpdateParameters>
                 <asp:ControlParameter ControlID="txtLogin" Name="login" PropertyName="Text" />
             </UpdateParameters>
         </asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlApagarRecente" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             DeleteCommand="DELETE FROM loginrecenteadm" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM [loginrecenteadm]"></asp:SqlDataSource>
         <asp:SqlDataSource ID="sqlSalvarRecente" runat="server" 
             ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
             InsertCommand="INSERT INTO loginrecenteadm(login_rec_adm) VALUES (@login)" 
             ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
             SelectCommand="SELECT * FROM [loginrecenteadm]">
             <InsertParameters>
                 <asp:ControlParameter ControlID="txtLogin" Name="login" PropertyName="Text" />
             </InsertParameters>
         </asp:SqlDataSource>
    </p>
    <asp:SqlDataSource ID="sqlDataADM" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT id_adm, email_adm, data_conta FROM adm WHERE (id_adm = @idADM)">
        <SelectParameters>
            <asp:SessionParameter Name="idADM" SessionField="idADM" />
        </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="sqlResetarSenha" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [adm]" 
            
            UpdateCommand="UPDATE adm SET senha_adm = @senha, data_conta = @data_alt WHERE (id_adm = @codADM)">
            <UpdateParameters>
                <asp:SessionParameter Name="codADM" SessionField="idADM" />
                <asp:Parameter Name="data_alt" />
                <asp:Parameter Name="senha" />
            </UpdateParameters>
        </asp:SqlDataSource>



        <asp:SqlDataSource ID="sqlRegistro" runat="server" 
            ConnectionString="<%$ ConnectionStrings:monarcaConnectionString %>" 
            InsertCommand="INSERT INTO registrologin(id_adm, id_func, data_registro, registro) VALUES (@adm, NULL, @data, @registro)" 
            ProviderName="<%$ ConnectionStrings:monarcaConnectionString.ProviderName %>" 
            SelectCommand="SELECT * FROM [registrologin]">
            <InsertParameters>
                <asp:Parameter Name="registro" />
                <asp:SessionParameter Name="adm" SessionField="idADM" />
                <asp:Parameter Name="data" />
            </InsertParameters>
        </asp:SqlDataSource>



</form>
</body>
</html>
