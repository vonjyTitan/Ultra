<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>

<jsp:include page='../verificateur.jsp'/>
<%
	PageFiche builder=new PageFiche(new Utilisateur(),request);
	builder.getEntity().setNomTable("ingenieur_libelle");
	builder.addNotVisibleChamp(new String[]{"login","passe","idrole","isingenieur"});
	builder.setLibelleFor("idutilisateur", "idEngineer");
	builder.getFieldByName("etat").setMethodForChamp("findActive");
	Projet p=new Projet();
	p.setNomTable("ingenieurprojet_libelle");
	p.setPackSize(150);
	List<Projet> projets = DaoModele.getInstance().findPageGenerique(1, p, " and idingenieur="+SessionUtil.getValForAttr(request, "id"));
%>
<h3><a href="main.jsp?cible=configuration/ingenieur-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Engineer Details</h3>
<%=builder.beginPanel("General Information", 6) %>
<%=builder.getBody()%>
<div class="form-group col-lg-12" style="text-align: right;">
<%if(((Utilisateur)builder.getEntity()).getEtat()==2){ %>
	<a class="btn btn-success btn-xs" href="utilisateur-active?id=<%=((Utilisateur)builder.getEntity()).getIdutilisateur()%>"><i class="fa fa-check"></i>Enabled</a>
		<%
		}
		else 
		{
		%><a class="btn btn-danger btn-xs" href="utilisateur-desactive?id=<%=((Utilisateur)builder.getEntity()).getIdutilisateur()%>"><i class="fa fa-trash-o "></i> Disabled</a>
		<%} %>
		<a class="btn btn-primary btn-xs" href="main.jsp?cible=configuration/ingenieur-modif&id=<%=((Utilisateur)builder.getEntity()).getIdutilisateur()%>"><i class="fa fa-pencil "></i> Update</a>
</div>
<%=builder.endPanel() %>
<%=HTMLBuilder.beginPanel("Projects", 6)%>
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Name</th>
			<th>Client</th>
		</tr>
	</thead>
	<tbody>
	<%
	for(Projet projet:projets){
	%>
		<tr>
			<td><a href="main.jsp?cible=projet/projet-fiche&id=<%=projet.getIdprojet()%>"><%=projet.getCode() %></a></td>
			<td><%=projet.getLibelle() %></td>
			<td><a href="main.jsp?cible=Tiers/client-fiche&id=<%=projet.getIdclient()%>"><%=projet.getClient() %></a></td>
		</tr>
	<%
	}
	%>
	
	</tbody>
</table>
<%=HTMLBuilder.endPanel()%>
