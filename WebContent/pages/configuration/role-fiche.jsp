<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>

<jsp:include page='../verificateur.jsp'/>
<%
	PageFiche builder=new PageFiche<Role>(new Role(),request);
	RoleFonctionnalite crit=new RoleFonctionnalite();
	crit.setNomTable("rolefonctionnalite_libelle");
	List<RoleFonctionnalite> rfs=DaoModele.getInstance().findPageGenerique(1, crit, Connecteur.getConnection(), " and idrole="+SessionUtil.getValForAttr(request, "id"));
%>
<h3><a href="main.jsp?cible=configuration/role-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Role Details</h3>
<%=HTMLBuilder.beginPanel("General information", 6) %>
<%=builder.getBody() %>
<div class="form-group col-lg-12" style="text-align: right;">
		<a class="btn btn-primary btn-xs" href="main.jsp?cible=configuration/role-modif&id=<%=((Role)builder.getEntity()).getIdrole()%>"><i class="fa fa-pencil "></i> Update</a>
</div>
<%=HTMLBuilder.endPanel() %>
<%=HTMLBuilder.beginPanel("Access", 6)%>
<table class="table table-striped table-advance table-hover table-bordered">
	<thead>
		<tr>
			<th>Id</th>
			<th>Access</th>
		</tr>
	</thead>
	<tbody>
	<%
	for(RoleFonctionnalite rf: rfs){
	%>
		<tr>
			<td><%=rf.getIdfonctionnalite() %></td>
			<td><%=rf.getFonctionnalite() %></td>
		</tr>
	<%
	}
	%>
	</tbody>
</table>
<%=HTMLBuilder.endPanel()%>