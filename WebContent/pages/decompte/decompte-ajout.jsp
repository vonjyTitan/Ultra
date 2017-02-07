<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Estimation(),"decompte-ajout",request);
	builder.removeChamp("idmoisprojet");
	builder.addNotVisibleChamp(new String[]{"idprojet","idutilisateur","total","datedecompte","datecertification","matonsitecredit","matonsitedebit","etat"});
	Projet p = DaoModele.getInstance().findById(new Projet(), Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
	((Estimation)builder.getEntity()).setIdprojet(p.getIdprojet());
	
%>
<h3>Add new Estimation and Count for project <%=p.getLibelle() %></h3>
<%=builder.getHTML("General information", 6)%>
