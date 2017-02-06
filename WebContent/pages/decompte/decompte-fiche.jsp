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
	builder.setDefaultClassForCOntainer("col-lg-6");
	builder.addNotVisibleChamp(new String[]{"idmoisprojet","idprojet","idutilisateur","estimation","datedecompte","datecertification","remboursement","matonsitecredit","matonsitedebit","libelle","description"});
%>
<h3>Estimation details</h3>
<%=HTMLBuilder.beginPanel("General information",12) %>
<%=builder.getBody()%>
<%=HTMLBuilder.endPanel()%>
