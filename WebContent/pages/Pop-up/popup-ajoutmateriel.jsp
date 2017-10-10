<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Materiel(),"crud-insert?classenom=com.mapping.Materiel&refereur=popup.jsp?cible=Pop-up/popup-ajoutmateriel",request);
	builder.removeChamp("idmateriel");
	builder.setChampTextarea("description");
	builder.setPopupType(true);
%>
<h3>Add new Material</h3>
<%=builder.getHTML("General information", 12)%>