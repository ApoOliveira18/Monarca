<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageFunc.master" AutoEventWireup="true" CodeFile="AjudaFunc.aspx.cs" Inherits="Ajuda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h1 class="posicionamento">Precisa de Ajuda?</h1>

<div class="caixa_tudo">
 
 <div class="conteudo">
 
 <div class="centro-cont">
 
 <br />

    <p>Este Setor do Funcionário foi criado para facilitar o gerenciamento do Banco de 
        Dados da Monarca. Portanto, você pode cadastrar novos produtos para o site, 
        alterar os que já estão cadastrados, consultar o Banco de Dados, entre outros.</p>
    <p>Abaixo, confira uma lista das tarefas que podem ser executadas neste Setor 
        Administrativo, e um rápido tutorial para realizá-las.</p>
<h4>→ CADASTRO</h4>
    <p>Esta seção é responsável <strong>apenas</strong> pela<strong> inserção de novos 
        dados</strong> no Banco. Aqui, você pode cadastrar <strong>novos perfumes</strong>. O cadastro de clientes é feito a 
        partir de outro formulário, disponível aos mesmos na Página Inicial.</p>
    <p>
        <strong>Cadastro de Perfumes:</strong>
        <span style="font-size:12.0pt;line-height:115%;
font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;mso-ascii-theme-font:minor-latin;mso-fareast-font-family:
&quot;Times New Roman&quot;;mso-hansi-theme-font:minor-latin;mso-bidi-font-family:&quot;Times New Roman&quot;;
mso-ansi-language:PT-BR;mso-fareast-language:PT-BR;mso-bidi-language:AR-SA">acesse a página 
            através do menu lateral, clicando em &quot;Perfumes&quot;, no submenu Cadastro. Após a 
            inserção dos dados necessários, finalize o processo clicando em &quot;Cadastrar&quot;.<br />
        <br />Para cadastrar o produto, é preciso inserir:</span></p>
    <ul>
        <li>Nome do Produto.</li>
        <li>Linha correspondente (selecione a opção desejada na lista disponível).</li>
        <li>Preço.</li>
        <li>Imagem do Produto (será exibida aos clientes).</li>
        <li>Descrição.</li>
    </ul>
    <h4>
        → PESQUISA</h4>
    <p>
        Esta seção é responsável pela <strong>consulta dos dados já cadastrados</strong> 
        no Banco de Dados (perfumes e clientes). Através desta seção,
        <strong>é possível alterar os dados</strong>, clicando em &quot;Editar&quot;.</p>
    <p>
        Para realizar a pesquisa, basta acessar a página correspondente no submenu 
        Pesquisa, digitar o termo desejado e clicar em &quot;Pesquisar&quot;.</p>
    <h4>
        → EDIÇÃO</h4>
    <p>
        Esta seção é responsável pela <strong>alteração dos dados cadastrados</strong>. 
        Para alterar, basta pesquisar o conteúdo desejado na seção Pesquisa - seja 
        Perfumes ou Clientes -, e clicar em &quot;Editar&quot;, ao lado do 
        registro que se deseja autalizar. Então, basta inserir os dados atualizados nos 
        campos solicitados.</p>

    <h4>
        → CONTATO</h4>
    <p>
        A empresa Monarca possui um email para contato direto entre a equipe e os 
        clientes, através do formulário <strong>Fale Conosco</strong>, presente no <strong>setor do Cliente</strong>. O 
        endereço é <strong>monarcaperfumes@gmail.com</strong>, 
        e a senha pode ser obtida com o líder da equipe de administração. </p>
    <p>
        Para ser redirecionado ao Login do Gmail, copie e cole o link: https://accounts.google.com/ServiceLogin</p>

</asp:Content>

