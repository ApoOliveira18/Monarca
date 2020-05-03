<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="ContaDeletada.aspx.cs" Inherits="ContaDeletada" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
.cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
}
        .Cad
        { 
           padding:2%;
           -webkit-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
             -moz-box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
            box-shadow: 4px 4px 45px -20px rgba(0,0,0,0.75);
            font-family: "Century Gothic";
        }
        .Cad h2
        {
    font-size: 1.3em;
    color: #333;

    font-weight: bold;
    }
        

        .link
        {
            text-decoration:none;
            color: #333;
            }
         .link:hover
        {
            text-decoration:none;
            color: #ccc;
            transition: ease-in 0.1s;
            }    
            
            .box{
	background-color: #FFF;
	width:60%;
	height:auto;
	margin:0 auto;
	}
	h1
	{
	    font-size: 3rem;
    line-height: 4.35rem;
    font-weight: 600;
    letter-spacing: .1em;
    text-transform: uppercase;
    margin: 0 auto;
    padding-top: 10px;
    color: #000;
    font-family: "Century Gothic";
    width: 60%;
	    }
    #TextArea1 {
      height: 88px;
    }

                 
                 
    @media screen and (max-width: 1023px) 
{
    .box{
	background-color: #FFF;
	width:90%;
	height:auto;
	margin:0 auto;
	}
    h1
	{
	    font-size: 3rem;
    line-height: 4.35rem;
    font-weight: 600;
    letter-spacing: .1em;
    text-transform: uppercase;
    margin: 0 auto;
    padding-top: 10px;
    color: #000;
    font-family: "Century Gothic";
    width: 90%;
	    }
}
        </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <br />
     <br />
     <br />
    <h1>Exclusão da Conta</h1>
    <br />
    <br />
         <div class="box">
            
            <div class="Cad">
            <h2>SUA CONTA FOI EXCLUÍDA</h2>
            <br />
                Monarca agradece pelo seu tempo conosco.
                <br /> Você pode se cadastrar novamente quando desejar, estaremos sempre de braços abertos.<br />
                <br />
                <asp:Button ID="btnVoltar" runat="server" CssClass="btnApp" Text="Voltar" 
                    OnClick="btnVoltar_Click" ToolTip="Ir para Home" />
            </div>      
         </div>


</asp:Content>

