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
<h3>Add new Material</h3>
<%=builder.getHTML("General information", 6)%>