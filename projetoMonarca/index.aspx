<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="menu_monarca" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style>
        .text1
{
	font-size: 8em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 150px 30px 10px 30px;
    width: 80%;
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
	
}
         .text1b
{
	font-size: 3em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 10px 30px 10px 40px;
    width: 80%;
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
	
}

    .text2
{
	font-size: 8em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 150px 30px 10px 30px;
    width: 95%;
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
	
}
    .text2b
{
	font-size: 3em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 10px 30px 10px 40px;
    width: 95%;
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
	
}
    .text3
{
	font-size: 8em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 150px 30px 10px 30px;
 
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
    float: right;
    margin-right: 150px;
	
}
    .text3 h4
{
	font-size: 0.3em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
    padding-left: 7px;
    margin-top: 10px;

	
}

    .text4
{
	font-size: 8em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 150px 30px 10px 30px;
    width: 95%;
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
	
}
    .text4b
{
	font-size: 3em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 10px 30px 10px 40px;
    width: 95%;
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
	
}
    .text5
{
	font-size: 8em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 550px 30px 10px 30px;
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
    float: right;
    margin-right: 200px;
	
}
    .text5 h4
{
	font-size: 0.3em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
    padding-left: 7px;
    margin-top: 10px;

	
}

        @media screen and (max-width: 1023px) {
            .text1 {
            visibility: hidden;
            }
            .text1b {
            visibility: hidden;
            }
            .text2 {
            visibility: hidden;
            }
            .text2b {
            visibility: hidden;
            }
            .text3 {
            visibility: hidden;
            }
            .text3 h4 {
            visibility: hidden;
            }
            .text4 {
            visibility: hidden;
            }
            .text4b {
            visibility: hidden;
            }
            .text5 {
            visibility: hidden;
            }
            .text5 h4 {
            visibility: hidden;
            }
            
        }
        @media screen and  (min-width:1024px) and  (max-width:1439px) 
            {
    .text2
{
	font-size: 6em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 150px 30px 10px 30px;
    width: 95%;
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
	
}
    .text2b
{
	font-size: 2em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 10px 30px 10px 40px;
    width: 95%;
    color: #fff;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
	
}

    .text3
{
	font-size: 6em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 150px 30px 10px 30px;
 
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
    float: right;
    margin-right: 50px;
	
}
    .text3 h4
{
	font-size: 0.3em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
    padding-left: 7px;
    margin-top: 10px;

	
}

    .text4
{
	font-size: 6em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 150px 30px 10px 30px;
    width: 95%;
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 200;
	
}
    .text4b
{
	font-size: 2em;
    text-shadow: 0 -1px 0 rgba(0,0,0,0.2);
    padding: 10px 30px 10px 40px;
    width: 95%;
    color: #212121;
    margin: 0 auto;
    position: relative;
    z-index: 100;
    font-weight: 100;
	
}
                
            }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


			<div class="main">	
     
     <div class="container demo-2">

            <div id="slider" class="sl-slider-wrapper">

				<div class="sl-slider">
				
					<div class="sl-slide" data-orientation="horizontal" data-slice1-rotation="-25" data-slice2-rotation="-25" data-slice1-scale="2" data-slice2-scale="2">
						<a href="Store.aspx">
                        <div class="sl-slide-inner">
							<div class="bg-img bg-img-1"></div>

                            <div class="text1">
                                Para Elas
                            </div>
                            <div class="text1b">
                                O que elas desejam
                            </div>

						</div>
                            </a>
					</div>
					
					<div class="sl-slide" data-orientation="vertical" data-slice1-rotation="10" data-slice2-rotation="-15" data-slice1-scale="1.5" data-slice2-scale="1.5">
                    <a href="Store.aspx">
						<div class="sl-slide-inner">
							<div class="bg-img bg-img-2"></div>
                            <div class="text2">
                                Para Eles
                            </div>
                            <div class="text2b">
                                O que eles desejam
                            </div>
						</div>
                        </a>
					</div>
					
					<div class="sl-slide" data-orientation="horizontal" data-slice1-rotation="3" data-slice2-rotation="3" data-slice1-scale="2" data-slice2-scale="1">
                    <a href="Casual.aspx">
						<div class="sl-slide-inner">
							<div class="bg-img bg-img-3"></div>
                            <div class="text3">
                                Le Beauté
                                <br />
                                <h4>Encante-se</h4>
                            </div>

						</div>
                        </a>
					</div>
					
					<div class="sl-slide" data-orientation="vertical" data-slice1-rotation="-5" data-slice2-rotation="25" data-slice1-scale="2" data-slice2-scale="1">
                    <a href="Casual.aspx">
						<div class="sl-slide-inner">
							<div class="bg-img bg-img-4"></div>
                            <div class="text4">
                                Silver Digger
                            </div>
                            <div class="text4b">
                                Desperte-se
                            </div>
						</div>
                        </a>
					</div>
					
					<div class="sl-slide" data-orientation="horizontal" data-slice1-rotation="-5" data-slice2-rotation="10" data-slice1-scale="2" data-slice2-scale="1">
                    <a href="cyber.aspx">
						<div class="sl-slide-inner">
							<div class="bg-img bg-img-5"></div>
                            <div class="text5">
                                Cyber
                                <br />
                                <h4>Descubra</h4>
                            </div>
                            
						</div>
					</div>
                    </a>
				</div><!-- /sl-slider -->

				<nav id="nav-dots" class="nav-dots">
					<span class="nav-dot-current"></span>
					<span></span>
					<span></span>
					<span></span>
					<span></span>
				</nav>

			</div><!-- /slider-wrapper -->           
           </div>
           			
			</div>
            
            <div id="novi">Novidades Monarca</div>
            <div class="cor-bg">

            <div class="conteudo-casual">

                <a href="Casual.aspx">
                <div class="b1">
                    <div class="texto-em-cima"><center>Casual</center></div>
                    <div class="corner"></div>
                </div>
                </a>
                
                <a href="Casual.aspx">
                <div class="b2">

                </div>
                    </a>

                <a href="Casual.aspx">
                <div class="b3">

                </div>
                </a>

                <a href="Casual.aspx">
                <div class="b4">

                </div>
                    </a>

                <a href="Casual.aspx">
                <div class="b5">

                </div>
                    </a>

                <a href="Casual.aspx">
                <div class="b6">

                </div>
                    </a>


                <a href="Casual.aspx">
                <div class="b7">
                 <center>   <img src="images/plus.png" /></center>
                </div>
                </a>
              

            </div>

            <div class="conteudo-encore">

                <a href="Encore.aspx">
                <div class="e1">
                    <div class="texto-em-cima"><center>Encore</center></div>
                    <div class="corner"></div>
                </div>
                </a>

                <a href="Encore.aspx">
                <div class="e2">

                </div>
                </a>
                
                <a href="Encore.aspx">
                <div class="e3">

                </div>
                    </a>
               
                <a href="Encore.aspx">
                <div class="e4">

                </div>
                </a>

                <a href="Encore.aspx">
                <div class="e5">

                </div>
                    </a>

                <a href="Encore.aspx">
                <div class="e6">

                </div>
                </a>


                <a href="Encore.aspx">
                <div class="e7">
                 <center>   <img src="images/plus.png" /></center>
                </div>
                </a>
              

            </div>

            </div>
        



</asp:Content>

