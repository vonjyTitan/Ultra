<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder = new InsertUpdateBuilder(new Role(),"role-ajout",request);
	builder.removeChamp("idrole");
	builder.setChampTextarea("description");
	List<Fonctionnalite> foncts=DaoModele.getInstance().findPageGenerique(1,new Fonctionnalite());
%>
<h3> Add new Role</h3>

<%=builder.beginHTMLForm() %>
<%=HTMLBuilder.beginPanel("Role details", 6) %>
<%=builder.getHTMLBody()%>
<%=builder.getHTMLButton() %>
<%=HTMLBuilder.endPanel() %>
<%=HTMLBuilder.beginPanel("Access", 6) %>
<table class="table table-striped table-advance table-hover table-bordered">
	<thead>
		<tr>
			<th>Id</th>
			<th>Access</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
	<%
	for(Fonctionnalite fonct: foncts){
	%>
		<tr>
			<td><%=fonct.getIdfonctionnalite() %></td>
			<td><%=fonct.getDescription() %></td>
			<td><input name="idfonctionnalite" type="checkbox" value="<%=fonct.getIdfonctionnalite()%>"/></td>
		</tr>
	<%
	}
	%>
	</tbody>
</table>
<%=HTMLBuilder.endPanel() %>
<%=builder.endHTMLForm()%>