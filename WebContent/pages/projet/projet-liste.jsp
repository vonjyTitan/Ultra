<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%@page import="java.util.Map"%>
<jsp:include page='../verificateur.jsp'/>
<%
	TableBuilder builder = new TableBuilder(new Projet(),request);
	builder.getEntity().setNomTable("projet_libelle");
	Map<String,String> active=new HashMap<String,String>();
	builder.addNotVisibleChamp(new String[]{"idprojet","idclient","identreprise","etat","description","avanceactuel","total","Totalestimation"});
	builder.setOrdre(new String[]{"code","libelle","lieu","datedebut","datefin","client","entreprise"});
	builder.setLienForChamp("code","main.jsp?cible=projet/projet-fiche","idprojet");
	builder.getFilterBuilder().removeChamp(new String[]{"idprojet","datefin"});
	builder.getFilterBuilder().setChampToInterval("datedebut");
	active.put("1", "Active");
	active.put("2", "Not active");
	builder.getFilterBuilder().setChampSelect("etat", active);
	builder.setLienForModif("main.jsp?cible=projet/projet-modif");
	builder.setLienForChamp("entreprise","main.jsp?cible=Tiers/entreprise-fiche","identreprise");
	builder.setLienForChamp("client","main.jsp?cible=Tiers/client-fiche","idclient");
%>
<%=builder.getFilterBuilder().getHTML("filter") %>
<%=HTMLBuilder.beginPanel("List of Project", 12) %>
<%=builder.getHTML()%> 
<%=HTMLBuilder.endPanel()%>