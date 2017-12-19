<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder = new InsertUpdateBuilder(new Projet(),"projet-modif",request);
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.addNotVisibleChamp(new String[]{"idprojet","etat"});
	builder.setChampTextarea("description");
%>
<h3><a href="main.jsp?cible=projet/projet-fiche&id=<%=SessionUtil.getValForAttr(request, "id")%>" ><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Edit Project details</h3>
<%=builder.getHTML("General informations", 6)%>