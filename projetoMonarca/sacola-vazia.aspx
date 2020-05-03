<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="sacola-vazia.aspx.cs" Inherits="sacola_vazia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="erro404">
        
        <div class="texto-erro">
        Por incrível que pareça, você ainda não adquiriu um produto Monarca. Então, conheça nossas linhas:
        <br />                        
            <asp:Button ID="Button1" runat="server" Text="Aromas do Brasil" 
                CssClass="btnApp" OnClick="Button1_Click" />
       
            <asp:Button ID="Button2" runat="server" Text="Casual" CssClass="btnApp" 
                OnClick="Button2_Click" />
                            
            <asp:Button ID="Button3" runat="server" Text="Cyber" CssClass="btnApp" 
                OnClick="Button3_Click" />
       
            <asp:Button ID="Button4" runat="server" Text="Encore" CssClass="btnApp" 
                OnClick="Button4_Click" />
        
            <asp:Button ID="Button5" runat="server" Text="Sport" CssClass="btnApp" 
                OnClick="Button5_Click" />
        

        </div>
        
    </div>
</asp:Content>

