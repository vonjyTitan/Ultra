<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Entreprise(),"crud-insert?classenom=com.mapping.Entreprise&cible=Tiers/entreprise-liste&referreur=main.jsp?cible=Tiers/entreprise-ajout",request);
	builder.removeChamp("identreprise");
	builder.setChampTextarea("description");
%>
<h3>Add new Contractor</h3>
<%=HTMLBuilder.beginPanel("General information", 6)%>
<%=builder.beginHTMLForm()%>
<%=builder.blockFor("nom")%>
<div id="descriptioncontainer" class="form-group col-lg-12"><div class="col-sm-4 col-sm-4 "><label class="control-label" for="description">Description  : </label></div>
<div class="col-sm-7">
<%=builder.inputFor("description")%>
<br>
<span>Any details relevant to the Contractor (VAT, BRN, Address, etc)</span>
</div>
</div>

<%=builder.endHTMLFormWithButton()%>
<%=HTMLBuilder.endPanel()%>