<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder=new InsertUpdateBuilder(new Utilisateur(),"ingenieur-insert",request);
	builder.removeChamp(new String[]{"isingenieur","idutilisateur","etat"});
	builder.setLibelleFor("idrole", "Assign Role");
	builder.removeChamp("passe");
%>
<h3>Add new Engineer</h3>
<%=HTMLBuilder.beginPanel("General information",6)%>
<%=builder.beginHTMLForm()%>
<%=builder.getHTMLBody()%>
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