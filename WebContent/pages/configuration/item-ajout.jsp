<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Item(),"crud-insert?classenom=com.mapping.Item&cible=configuration/item-liste&referreur=main.jsp?cible=configuration/item-ajout",request);
	builder.removeChamp("iditem");
	builder.setChampTextarea("discription");
%>
<h3>Add new Item</h3>

<%=builder.getHTML("", 6)%>