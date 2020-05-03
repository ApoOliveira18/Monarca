<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="CompraFinalizada.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

		
		<script src="js/modernizr3.custom.js"></script>
		<script src="js/modernizr2.custom.js"></script>
        <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />
        <style type="text/css">
           .style1
        {
            text-align: center;
        }
        .Cad
        { 
           text-align: center;
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
	width:27%;
	height:300px;
	margin: 0 auto;
	background: #fff;
	margin-top: 2%;
	}
        </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
            <br />
         <div class="box">
            <div class="text-box2-2">COMPRA FINALIZADA COM SUCESSO! </div>
            <br />
            <div class="Cad">Sua compra chegará em breve.<br />
                <a href="index.aspx" class="link"> Clique Aqui</a> para voltar à Página Inicial.</div>            
            </div>


</asp:Content>

