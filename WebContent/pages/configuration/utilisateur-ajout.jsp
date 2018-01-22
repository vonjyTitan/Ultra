<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%

	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Utilisateur(),"utilisateur-ajout",request);
	builder.removeChamp(new String[]{"idutilisateur","etat","isingenieur"});
	builder.setLibelleFor("idrole", "Assign Role");
	builder.removeChamp(new String[]{"passe","idrole"});
	Role crit = new Role();
	crit.setPackSize(50);
	List<Role> roles = DaoModele.getInstance().findPageGenerique(1, crit);
%>
<h3> Add new User</h3>
<%=HTMLBuilder.beginPanel("User information",6)%>
<%=builder.beginHTMLForm()%>
<%=builder.getHTMLBody()%>
<div id="idrolecontainer" class="form-group col-lg-12">
<div class="col-sm-4 col-sm-4 ">
	<label class="control-label" for="idrole">Assign Role  : </label>
</div>
<div class="col-sm-7">
	<select class="  form-control" name="idrole" id="user-type">
	<%for(Role rl:roles){ %>
	<option value="<%=rl.getIdrole() %>"><%=rl.getLibelle() %></option>
	<%} %>
</select>
</div>
</div>
<div id="logincontainer" class="form-group col-lg-12">
<div class="col-sm-4 col-sm-4 ">
<label class="control-label" for="passe">Password * : </label>
</div>
<div class="col-sm-7"><input name="passe" id="passe" class="form-control  " value="" type="password">
</div>
</div>
<div id="logincontainer" class="form-group col-lg-12">
<div class="col-sm-4 col-sm-4 ">
<label class="control-label" for="passe_confirm">Confirm Password * : </label>
</div>
<div class="col-sm-7"><input name="passe_confirm" id="passe_confirm" class="form-control  " value="" type="password">
</div>
</div>
<%=builder.endHTMLFormWithButton()%>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Access allowed to selected role",6)%>
<table class="table table-striped table-advance table-hover table-bordered">
	<thead>
		<tr>
			<th>Id</th>
			<th>Access</th>
		</tr>
	</thead>
	<tbody id="access-container">	
	</tbody>
</table>
<%=HTMLBuilder.endPanel()%>
<script type="text/javascript" src="assets/js/user_js.js"></script>