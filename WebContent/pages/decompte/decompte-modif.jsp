<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Estimation(), "crud-update?classenom=com.mapping.Estimation&cible=decompte/decompte-fiche&referreur=main.jsp?cible=decompte/decompte-modif",request);
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.addNotVisibleChamp(new String[]{"idmoisprojet","idprojet","idutilisateur","total","datedecompte","datecertification","matonsitecredit","matonsitedebit","etat"});
%>
<h3><a href="javascript:;" onclick="history.back();" ><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Estimation and Count update</h3>
<%=builder.getHTML("General information", 6)%>