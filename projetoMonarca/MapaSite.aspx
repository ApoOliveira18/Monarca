<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="MapaSite.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

        <link rel="stylesheet" type="text/css" href="css/mapa.css" />

        <style>
        .cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
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
        .mapa-menu
        {
            background: #fff;
            }

                 
                 
    @media screen and (max-width: 1023px) 
{

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
    <h1> Mapa do Site</h1>

    <div class="conteudo-mp">

    <div id= "mapa-menu">

    <div id="topo-lateral">Início
    <div id="lateral1">
    <a href="index.aspx" class="cor-da-letra">Home</a>
    </div>
    </div>

    <div id="topo-lateral">
    Linhas
    <div id="lateral1">
    <a href="Encore.aspx" class="cor-da-letra">Encore</a>
        <br />
    <a href="Casual.aspx"class="cor-da-letra">Casual</a>
        <br />
    <a href="Sports.aspx" class="cor-da-letra">Sports</a>
        <br />
    <a href="Aromas.aspx" class="cor-da-letra">Aromas do Brasil</a>

         <br />
         <a href="cyber.aspx" class="cor-da-letra">Cyber</a>
         <br />
    <a href="Store.aspx" class="cor-da-letra">Store</a>
    </div> 
    </div>

    <div id="topo-lateral">
    Monarca e Você
    <div id="lateral1">
    <a href="PerfilCliente_Entrar.aspx" class="cor-da-letra">Login</a>
    <br />
    <a href="FaleConosco.aspx" class="cor-da-letra">Fale Conosco</a>
    <br />
    <a href="politica_de_privacidade.aspx" class="cor-da-letra">Atendimento ao Cliente</a>
    </div>
    </div>
    
    </div>


    </div>
</asp:Content>

