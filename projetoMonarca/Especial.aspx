<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Especial.aspx.cs" Inherits="Especial" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
	<!-- Behavioral Meta Data -->
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

	<!-- Styles -->
	<link rel="stylesheet" type="text/css" href="css/styles.css"/>
</head>
<body>

<!-- ver este efeito http://css3generator.com/ -->
    <form id="form1" runat="server">
    <div id="logo"><br /></div>
    <div id="container" class="container">
		<ul id="scene" class="scene">
			<li class="layer" data-depth="1.00"><img src="images/layer1.png"></li>
			<li class="layer" data-depth="0.80"><img src="images/layer2.png"></li>
			<li class="layer" data-depth="0.60"><img src="images/layer3.png"></li>
			<li class="layer" data-depth="0.40"><img src="images/layer4.png"></li>
			<li class="layer" data-depth="0.20"><img src="images/layer5.png"></li>
			<li class="layer" data-depth="0.00"><img src="images/layer6.png"></li>
		</ul>
	</div>

    <div id="conteudo-texto">
        <div id="texto">EXPERIMENTE O NOVO</div>
    <div id="perfume"><br /></div>
    <div id="nomePerfume">Amazônia</div>
    <div id="descPerfume">Exclusividade Monarca</div>
        <asp:Button ID="Button1" runat="server" Text="Button" />
        <asp:Button ID="Button2" runat="server" Text="Button" />
    </div>

	<!-- Scripts -->
	<script src="js/jquery.js"></script>
	<script src="deploy/jquery.parallax.js"></script>
	<script>

	    // Yep, that's it!
	    $('#scene').parallax();
  </script>

    </form>
</body>
</html>
