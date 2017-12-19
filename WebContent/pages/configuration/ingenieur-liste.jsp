<%@page import="utilitaire.SessionUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Utilisateur crit=new Utilisateur();
	crit.setNomTable("ingenieur_libelle");
	TableBuilder builder=new TableBuilder(crit,request);
	Map<String,String> active=new HashMap<String,String>();
	active.put("1", "Active");
	active.put("2", "Not active");
	builder.getFilterBuilder().setChampSelect("etat", active);
	builder.getFilterBuilder().setLibelleFor("idrole", "Role of engineer");
	builder.getFieldByName("etat").setMethodForChamp("findActive");
	builder.addNotVisibleChamp(new String[]{"login","passe","idrole","isingenieur"});
	builder.setLibelleFor("idutilisateur", "ID_Engineer");
	builder.getFilterBuilder().removeChamp(new String[]{"idutilisateur","isingenieur","passe","login","role"});
	builder.setLienForId("main.jsp?cible=configuration/ingenieur-fiche");
	builder.setLienForModif("main.jsp?cible=configuration/ingenieur-modif");
%>
<%=builder.getFilterBuilder().getHTML("Filter", 12) %>
<%=builder.getHTML()%>