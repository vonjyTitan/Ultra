<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%
		TableBuilder builder = new PopupTable(new Client(),request);
%>
<%=builder.getFilterBuilder().getHTML("filter") %>
<%=HTMLBuilder.beginPanel("List of Custommer", 12) %>
<%=builder.getHTML()%> 
<%=HTMLBuilder.endPanel()%>

