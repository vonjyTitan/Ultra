<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Estimation crit=new Estimation();
	crit.setNomTable("moisprojet");
	PageFiche builder=new PageFiche(crit,request);
	//builder.removeChamp("idunite");
%>
<h3><a href="main.jsp?cible=Tiers/client-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Customer details</h3>
<%=HTMLBuilder.beginPanel("General information",6) %>
<%=builder.getBody()%>
<%=HTMLBuilder.endPanel()%>