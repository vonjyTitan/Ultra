<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	TableBuilder builder = new TableBuilder(new Role(),request);
	builder.setLienForModif("main.jsp?cible=configuration/role-modif");
%>
<%=HTMLBuilder.beginPanel("List of Role", 6) %>
<%=builder.getHTML()%>
<%=HTMLBuilder.endPanel()%>