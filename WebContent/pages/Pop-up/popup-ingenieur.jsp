<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%
	Utilisateur crit=new Utilisateur();
	crit.setNomTable("ingenieur_libelle");
	TableBuilder builder=new PopupTable(crit,request);
	Map<String,String> active=new HashMap<String,String>();
	active.put("1", "Active");
	active.put("2", "Not active");
	builder.getFilterBuilder().setChampSelect("etat", active);
	builder.getFilterBuilder().setLibelleFor("idrole", "Role of engineer");
	builder.getFieldByName("etat").setMethodForChamp("findActive");
	builder.addNotVisibleChamp(new String[]{"login","passe","idrole","isingenieur"});
	builder.getFilterBuilder().removeChamp(new String[]{"idutilisateur","isingenieur","passe","login","role"});
%>
<%=builder.getFilterBuilder().getHTML("filter") %>
<%=HTMLBuilder.beginPanel("List of engineers", 12) %>
<%=builder.getHTML()%> 
<%=HTMLBuilder.endPanel()%>

