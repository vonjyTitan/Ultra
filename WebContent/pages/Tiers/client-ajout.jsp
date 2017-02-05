<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Client(),"crud-insert?classenom=com.mapping.Client&cible=Tiers/client-liste&referreur=main.jsp?cible=Tiers/client-ajout",request);
	builder.removeChamp("idclient");
	builder.setChampTextarea("description");
%>
<h3>Add new Customer</h3>
<%=builder.getHTML("General information", 12)%>