<%@page import="dao.Connecteur"%>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	String id=SessionUtil.getValForAttr(request, "id");
	InsertUpdateBuilder builder = new InsertUpdateBuilder(new Role(),"role-modif",request);
	builder.setValueFromDatabase(id);
	builder.addNotVisibleChamp("idrole");
	builder.setChampTextarea("description");
	List<RoleFonctionnalite> rfs=DaoModele.getInstance().findPageGenerique(1, new RoleFonctionnalite(), Connecteur.getConnection(), " and idrole="+id);
	List<Fonctionnalite> foncts=DaoModele.getInstance().findPageGenerique(1,new Fonctionnalite());
%>
<h3><a href="main.jsp?cible=configuration/role-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Role update</h3>

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
		boolean isSelected=false;
		for(RoleFonctionnalite rf:rfs){
			if(rf.getIdfonctionnalite()==fonct.getIdfonctionnalite()){
				isSelected=true;
				rfs.remove(rf);
				break;
			}
		}
	%>
		<tr>
			<td><%=fonct.getIdfonctionnalite() %></td>
			<td><%=fonct.getDescription() %></td>
			<td><input name="idfonctionnalite" type="checkbox" value="<%=fonct.getIdfonctionnalite()%>" <%=(isSelected ? "checked='checked'" : "") %>/></td>
		</tr>
	<%
	}
	%>
	</tbody>
</table>
<%=HTMLBuilder.endPanel() %>
<%=builder.endHTMLForm()%>