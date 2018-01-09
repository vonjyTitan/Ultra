<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Item crit=new Item();
	crit.setNomTable("item_libelle");
	TableBuilder builder= new TableBuilder(crit,request);
	builder.setLienForChamp("code", "main.jsp?cible=configuration/item-fiche", "iditem");
	builder.removeChamp(new String[]{"iditem","idunite"});
	builder.getFilterBuilder().removeChamp(new String[]{"unite","iditem"});
	builder.setLienForModif("main.jsp?cible=configuration/item-modif");
	builder.setAddnewUrl("main.jsp?cible=configuration/item-ajout");
%>
<h3>List of all Items</h3>
<%=builder.getFilterBuilder().getHTML("Filter") %>
<%=builder.getHTML()%>