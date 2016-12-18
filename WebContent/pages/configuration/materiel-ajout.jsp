<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Materiel(),"crud-insert?classenom=com.mapping.Materiel&cible=configuration/materiel-liste&referreur=main.jsp?cible=configuration/meteriel-ajout",request);
	builder.removeChamp("idmateriel");
	builder.setOrdre(new String[]{"libelle","idunite","description"});
	builder.setChampTextarea("description");
%>
<h3>Add new Material</h3>
<%=builder.getHTML("General information", 6)%>