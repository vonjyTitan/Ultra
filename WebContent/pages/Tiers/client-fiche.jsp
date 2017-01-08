<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Client crit=new Client();
	crit.setNomTable("client");
	PageFiche builder=new PageFiche(crit,request);
	//builder.removeChamp("idunite");
%>
<h3><a href="main.jsp?cible=Tiers/client-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Customer details</h3>
<%=HTMLBuilder.beginPanel("General information",12) %>
<%=builder.getBody()%>
<div class="form-group col-lg-12" style="text-align: right;">
		<a class="btn btn-primary btn-xs" href="main.jsp?cible=Tiers/client-modif&id=<%=((Client)builder.getEntity()).getIdclient()%>"><i class="fa fa-pencil "></i> Update</a>
</div>
<%=HTMLBuilder.endPanel()%>