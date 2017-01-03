<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Materiel(), "crud-update?classenom=com.mapping.Materiel&cible=configuration/materiel-fiche&referreur=main.jsp?cible=configuration/materiel-fiche",request);
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.addNotVisibleChamp("idmateriel");
	builder.setOrdre(new String[]{"code","libelle","idunite","description"});
	builder.setChampTextarea("description");
%>
<h3>Material update</h3>
<%=builder.getHTML("General information", 6)%>