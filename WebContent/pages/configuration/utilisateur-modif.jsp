<%@page import="utilitaire.SessionUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>

<jsp:include page='../verificateur.jsp'/>

<% InsertUpdateBuilder builder=new InsertUpdateBuilder(new Utilisateur(),"utilisateur-modif",request); 
	builder.setValueFromDatabase(SessionUtil.getValForAttr(request, "id"));
	builder.removeChamp(new String[]{"etat"});
	builder.removeChamp("passe");
	builder.addNotVisibleChamp(new String[]{"idutilisateur","isingenieur"});%>
	
	<h3><a href="main.jsp?cible=configuration/utilisateur-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Edit User information</h3>
	<%=HTMLBuilder.beginPanel("User information",6)%>
<%=builder.beginHTMLForm()%>
<%=builder.getHTMLBody()%>
<div id="logincontainer" class="form-group col-lg-12">
<div class="col-sm-4 col-sm-4 ">
<label class="control-label" for="passe">Password * : </label>
</div>
<div class="col-sm-7"><input name="passe" id="passe" class="form-control  " value="<%=((Utilisateur)builder.getEntity()).findPasseDecrypted() %>" type="password">
</div>
</div>
<div id="logincontainer" class="form-group col-lg-12">
<div class="col-sm-4 col-sm-4 ">
<label class="control-label" for="passe_confirm">Confirm Password * : </label>
</div>
<div class="col-sm-7"><input name="passe_confirm" id="passe_confirm" class="form-control  " value="<%=((Utilisateur)builder.getEntity()).findPasseDecrypted() %>" type="password">
</div>
</div>
<%=builder.endHTMLFormWithButton()%>
<%=HTMLBuilder.endPanel()%>

