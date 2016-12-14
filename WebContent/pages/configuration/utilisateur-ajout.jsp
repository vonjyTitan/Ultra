<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%

	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Utilisateur(),"utilisateur-ajout",request);
	builder.removeChamp(new String[]{"idutilisateur","etat"});
%>
<h3> Add new User</h3>
<%=builder.getHTML("User information",6)%>