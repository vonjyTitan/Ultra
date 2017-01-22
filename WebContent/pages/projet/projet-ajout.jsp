<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder = new InsertUpdateBuilder(new Projet(),"",request);
	builder.removeChamp(new String[]{"idprojet","etat"});
	builder.setChampTextarea("description");
%>
<h3>Add new project</h3>
<%=builder.getHTML("General informations", 6)%>