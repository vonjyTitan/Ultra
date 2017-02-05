<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Estimation(),"crud-insert?classenom=com.mapping.Estimation&cible=decompte/decompte-liste&referreur=main.jsp?cible=Tiers/decompte-ajout",request);
	builder.removeChamp("idmoisprojet");
%>
<h3>Add new Estimation</h3>
<%=builder.getHTML("General information", 12)%>
