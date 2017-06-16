<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Utilisateur(),"ingenieur-insert",request);
	builder.removeChamp(new String[]{"isingenieur","idutilisateur","etat"});
	builder.setLibelleFor("idrole", "Role of engineer");
	builder.setPopupType(true);
%>
<h3>Add new Engineer</h3>
<%=builder.getHTML("General information", 6)%>