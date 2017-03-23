<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Entreprise(), "crud-update?classenom=com.mapping.Entreprise&cible=Tiers/entreprise-fiche&referreur=main.jsp?cible=Tiers/entreprise-fiche",request);
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.addNotVisibleChamp("identreprise");
	builder.setChampTextarea("description");
%>
<h3>Contractor update</h3>
<%=builder.getHTML("General information", 6)%>