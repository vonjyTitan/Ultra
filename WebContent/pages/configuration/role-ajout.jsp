<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder = new InsertUpdateBuilder(new Role(),"role-ajout",request);
	builder.removeChamp("idrole");
	builder.setChampTextarea("description");
	List<Fonctionnalite> foncts=DaoModele.getInstance().findPageGenerique(1,new Fonctionnalite());
%>
<%=builder.beginHTMLForm() %>
<%=HTMLBuilder.beginPanel("Role details", 6) %>
<%=builder.getHTMLBody()%>
<%=builder.getHTMLButton() %>
<%=HTMLBuilder.endPanel() %>
<%=HTMLBuilder.beginPanel("Role details", 6) %>

<%=HTMLBuilder.endPanel() %>
<%=builder.endHTMLForm()%>