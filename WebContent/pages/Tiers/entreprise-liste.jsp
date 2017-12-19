<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	TableBuilder builder = new TableBuilder(new Entreprise(),request);
	builder.setLienForModif("main.jsp?cible=Tiers/entreprise-modif");
	builder.setLienForId("main.jsp?cible=Tiers/entreprise-fiche");
%>
<%=builder.getFilterBuilder().getHTML("filter") %>
<%=HTMLBuilder.beginPanel("List of Contractors", 12) %>
<%=builder.getHTML()%> 
<%=HTMLBuilder.endPanel()%>