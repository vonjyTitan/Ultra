<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%
	Item crit=new Item();
	crit.setNomTable("item_libelle");
	TableBuilder builder= new PopupTable(crit,request);
	builder.removeChamp(new String[]{"idunite"});
	builder.addNotVisibleChamp("iditem");
	builder.getFilterBuilder().removeChamp(new String[]{"unite","iditem"});
%>
<h3>List of all Items</h3>
<%=builder.getFilterBuilder().getHTML("Filter") %>
<%=builder.getHTML()%>