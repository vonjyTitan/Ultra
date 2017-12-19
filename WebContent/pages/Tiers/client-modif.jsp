<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Client(), "crud-update?classenom=com.mapping.Client&cible=Tiers/client-fiche&referreur=main.jsp?cible=Tiers/client-fiche",request);
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.addNotVisibleChamp("idclient");
	//builder.setOrdre(new String[]{"idcustomer","Name","Description"});
	builder.setChampTextarea("description");
%>
<h3>Client: Edit information</h3>
<%=builder.getHTML("General information", 12)%>