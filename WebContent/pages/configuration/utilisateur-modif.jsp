<%@page import="utilitaire.SessionUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>

<jsp:include page='../verificateur.jsp'/>

<% InsertUpdateBuilder builder=new InsertUpdateBuilder(new Utilisateur(),"utilisateur-modif",request); 
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.removeChamp(new String[]{"etat"});
	builder.addNotVisibleChamp(new String[]{"idutilisateur"});
	builder.getFieldByName("passe").setMethodForChamp("findPasseDecrypted");%>
	
	<h3><a href="main.jsp?cible=configuration/utilisateur-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> User update</h3>
	<%
	out.print(builder.getHTML("User informations",6)); 
	%>


