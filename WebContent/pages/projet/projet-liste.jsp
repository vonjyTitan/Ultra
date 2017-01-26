<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	TableBuilder builder = new TableBuilder(new Projet(),request);
	builder.getEntity().setNomTable("projet_libelle");
	builder.addNotVisibleChamp(new String[]{"idprojet","idclient","identreprise","etat"});
	builder.setOrdre(new String[]{"code","libelle","lieu","description","datedebut","datefin","client","entreprise"});
	builder.setLienForChamp("code","main.jsp?cible=configuration/materiel-fiche","idprojet");
%>
<%=builder.getFilterBuilder().getHTML("filter") %>
<%=HTMLBuilder.beginPanel("List of Project", 12) %>
<%=builder.getHTML()%> 
<%=HTMLBuilder.endPanel()%>