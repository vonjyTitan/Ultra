<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Entreprise(),"crud-insert?classenom=com.mapping.Entreprise&refereur=popup.jsp?cible=Pop-up/popup-ajoutentreprise",request);
	builder.removeChamp("identreprise");
	builder.setChampTextarea("description");
	builder.setPopupType(true);
%>
<h3>Add new Contractor</h3>
<%=builder.getHTML("General information", 12)%>