<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageFunc.master" AutoEventWireup="true" CodeFile="IndexFunc.aspx.cs" Inherits="IndexADM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>

                .img-adm {
        background: url(../images/logo-email.png);
        float: left;
        height: 128px;
        width: 128px;
        }
        .linha-adm {
        height: 128px;
        width: 1px;
        float: left;
        margin-left: 10px;
        margin-right: 10px;
        background-color: #ccc;
        }
        .texto-adm {
        font-size: 2em;
        margin-top: 45px;
        }


    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Home</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />
      <br />
      <br />
     <br />

<div class="img-adm"></div>
<div class="linha-adm"></div>
<div class="texto-adm">Setor Funcionário</div>

     </div>
     </div>
     </div>

</asp:Content>

