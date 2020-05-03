<%@ Page Title="" Language="C#" MasterPageFile="~/MasterGeral.master" AutoEventWireup="true" CodeFile="PerfilCliente_Enderecos.aspx.cs" Inherits="PerfilCliente_Enderecos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="stylesheet" type="text/css" href="css/estilo_perfil_cliente.css"/>
        <link rel="stylesheet" type="text/css" href="css/botao-e-centralizar.css" />
                <style>
.cd-main-content {
    padding-top: 80px;
    background-color: #f5f5f5;
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="centralizar-total2">
<div id="tudo">
    <br />
    <br />
    <h1>Endereços Existentes</h1>
	<div id="container2">
         <div id="info-container-end">
            <div class="resultado_senha">
                <div class="posicao-botao">
                    <asp:DataList ID="DataList1" runat="server" DataKeyField="id_end" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <br />
                            <asp:Label ID="nome_endLabel" runat="server" Font-Bold="True" Font-Size="Large" Text='<%# Eval("nome_end") %>' />
                            <br />
                            <br />
                            <asp:Label ID="lblRua" runat="server" Text='<%# Eval("rua_end") %>'></asp:Label>
                            <br />
                            <asp:Label ID="lblCidade" runat="server" Text='<%# Eval("cidade_end") %>'></asp:Label>
                            &nbsp;-
                            <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("estado_end") %>'></asp:Label>
                            <br />
                            <asp:Label ID="CEP_cliLabel" runat="server" Text='<%# Eval("CEP_cli") %>' />
                            <br />
                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("id_end") %>' Visible="False"></asp:Label>
                            <asp:Button ID="btnEditar" runat="server" CssClass="btnEditar" Height="40px" 
                                OnClick="btnEditar_Click" Text="Editar" Visible="False" />
                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="btnEditar" 
                                NavigateUrl='<%# Eval("id_end","PerfilCliente_EditarEnd.aspx?id={0}") %>' 
                                Width="60px" Font-Bold="True" Height="30px" >Editar</asp:HyperLink>
                            <br />
                            <br />
                            <asp:LinkButton ID="lbExcluir" runat="server" OnClick="lbExcluir_Click1">Excluir</asp:LinkButton>
                        </ItemTemplate>
                    </asp:DataList>
                    <br />
                    <asp:Label ID="lblSemEnd" runat="server" Font-Size="X-Large"></asp:Label>
                    <br />                    <br />
                    <asp:Button ID="btnNovoEnd" runat="server" Text="Adicionar Endereços" 
                    CssClass="btnApp" onclick="btnNovoEnd_Click" Width="150px" /></div>
                
                <asp:SqlDataSource ID="sqlEndAdicionais" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:monarcaConnectionString2 %>" 
                    ProviderName="<%$ ConnectionStrings:monarcaConnectionString2.ProviderName %>" 
                    
                    
                    SelectCommand="SELECT id_end, nome_end, CEP_cli, cidade_end, rua_end, estado_end FROM endereco WHERE (id_cli = @codigo)" 
                    DeleteCommand="DELETE FROM endereco WHERE (id_end = @cod)">
                    <DeleteParameters>
                        <asp:SessionParameter Name="cod" SessionField="endExcluir" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="codigo" SessionField="idCliente" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
        <br />
        <br />
    </div>
</div>
    </div>
</asp:Content>

