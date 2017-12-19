<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder =new InsertUpdateBuilder(new Bill(),"crud-update?classenom=com.mapping.Bill&cible=Bill/bill-fiche&referreur=main.jsp?cible=Bill/bill-modif",request);
	builder.addNotVisibleChamp(new String[]{"idbill","idprojet"});
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.setChampTextarea("description");
%>
<h3><a href="main.jsp?cible=Bill/bill-fiche&id=<%=SessionUtil.getValForAttr(request, "id") %>" ><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Bill: Edit information</h3>
<%=builder.getHTML("", 6)%>