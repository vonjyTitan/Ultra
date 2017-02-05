<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Estimation(), "crud-update?classenom=com.mapping.Estimation&cible=Tiers/decompte-decompte&referreur=main.jsp?cible=decompte/decompte-fiche",request);
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.addNotVisibleChamp("idmoisprojet");
%>
<h3>Estimation update</h3>
<%=builder.getHTML("General information", 6)%>