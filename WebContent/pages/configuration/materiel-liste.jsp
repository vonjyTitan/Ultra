<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Materiel crit=new Materiel();
	crit.setNomTable("materiel_libelle");
	TableBuilder builder=new TableBuilder(crit,request);
	builder.removeChamp("description");
	builder.removeChamp("idunite");
	builder.setLienForId("main.jsp?cible=configuration/materiel-fiche");
	builder.setLienForModif("main.jsp?cible=configuration/materiel-modif");
	builder.getFilterBuilder().removeChamp("unite");
%>
<h3>Material list</h3>
<%=builder.getFilterBuilder().getHTML("Filter", 12)%>
<%=builder.getHTML()%>