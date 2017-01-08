<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Utilisateur(),"ingenieur-insert",request);
	builder.addNotVisibleChamp(new String[]{"isingenieur","idutilisateur","etat"});
	builder.setLibelleFor("idrole", "Role of engineer");
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.getFieldByName("passe").setMethodForChamp("findPasseDecrypted");
%>
<h3>Update Engineer information</h3>
<%=builder.getHTML("General information", 6)%>