<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Item(),"crud-insert?classenom=com.mapping.Item&refereur=popup.jsp?cible=Pop-up/popup-ajoutitem",request);
	builder.removeChamp("iditem");
	builder.setChampTextarea("discription");
	builder.setPopupType(true);
%>
<h3>Add new Item</h3>
<%=builder.getHTML("General information", 12)%>