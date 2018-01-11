<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	InsertUpdateBuilder builder = new InsertUpdateBuilder(new Projet(),"projet-ajout",request);
	builder.removeChamp(new String[]{"idprojet","etat"});
	builder.setChampTextarea("description");
	Utilisateur crit = new Utilisateur();
	crit.setNomTable("ingenieur_libelle");
	crit.setPackSize(100);
	List<Utilisateur> ingenieurs = DaoModele.getInstance().findPageGenerique(1, crit);
	((Projet)builder.getEntity()).setRetenue(10.0);
%>
<h3>Add new project</h3>
<%=builder.beginHTMLForm(true)%>
<%=HTMLBuilder.beginPanel("General informations", 6)%>
<%=builder.getHTMLBody() %>
<div id="datefincontainer" class="form-group col-lg-12">
<div class="col-sm-4 col-sm-4 ">
<label class="control-label" for="datefin" style="display:none;">Attached files </label></div>
<div class="col-sm-7" id="filescontainer" style="display:none;">
</div></div>
<%=HTMLBuilder.endPanel() %>
<%=HTMLBuilder.beginPanel("Engineers", 6)%>
<div class="panel-body form-horizontal style-form">
<table class="table table-striped table-advance table-hover table-bordered">
	<thead>
		<tr>
			<th>First and last names</th>
			<th>Options</th>
			<th></th>
		</tr>
	</thead>
	<tbody id="ingenieurs">
	</tbody>
</table>
<div class="col-lg-12" style="text-align:center;">
<a href="javascript:;" id="addingeneur" class="btn btn-primary btn-xs" style="width:150px;"><i class="fa fa-plus"></i></a>
</div>
</div>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Estimate", 6)%>
<div class="panel-body form-horizontal style-form">
<table class="table table-striped table-advance table-hover table-bordered">
	<thead>
		<tr>
			<th>Month</th>
			<th>Amount</th>
			<th></th>
		</tr>
	</thead>
	<tbody id="estimates">
	</tbody>
</table>
<div class="col-lg-12" style="text-align:center;">
<a href="javascript:;" id="addestimate" class="btn btn-primary btn-xs" style="width:150px;"><i class="fa fa-plus"></i></a>
</div>
</div>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Bills", 6)%>
<div class="panel-body form-horizontal style-form">
<table class="table table-striped table-advance table-hover table-bordered">
	<thead>
		<tr>
			<th>Bill Code</th>
			<th>Label</th>
			<th>Description</th>
			<th></th>
		</tr>
	</thead>
	<tbody id="bills">
	</tbody>
</table>
<div class="col-lg-12" style="text-align:center;">
<a href="javascript:;" id="addbill" class="btn btn-primary btn-xs" style="width:150px;"><i class="fa fa-plus"></i></a>
</div>
</div>
<%=HTMLBuilder.endPanel()%>
<%=builder.getHTMLButton() %>
<%=builder.endHTMLForm()%>
<script src="assets/js/attachement.js"></script>
<script>
var taille=<%=ingenieurs.size()%>;
var ingenieurs=[];
var indice=1;
$(document).ready(function(){
	attachement($("#filescontainer"),"file");
	<%int ii=0;for(Utilisateur ingenieur:ingenieurs){%>ingenieurs[<%=ii%>]=[];ingenieurs[<%=ii%>]["id"]=<%=ingenieur.getIdutilisateur() %>;ingenieurs[<%=ii%>]["lib"]='<%=(ingenieur.getPrenom()+" "+ingenieur.getNom())%>';<%ii++;}%>
	$("#addingeneur").on("click",function(){
		addChildIng();
	});
	$("#addestimate").on("click",function(){
		addChildEstim();
	});
	$("#addbill").on("click",function(){
		addChildBill();
	});
	addChildIng();
	addChildEstim();
	addChildBill();
});
function addChildIng(){
	var node = "<tr><td><div class=\"col-sm-12\"><input id=\"idingenieur"+indice+"_val\" name=\"idingenieur\" onChange=\"changeUnite(this);\" type=\"hidden\"><input id=\"idingenieur"+indice+"_lib\" disabled=\"true\" class=\"form-control\" style=\"float: left;width: 80%;\" type=\"text\"><a href=\"javascript:;\" onclick=\"window.open('popup.jsp?cible=Pop-up/popup-ingenieur&amp;libtable=prenom&amp;inputname=idingenieur"+indice+"', 'popupWindow','width=1200,height=800,scrollbars=yes');\" style=\"height:  30px !important;margin-left: 4px;margin-top: 1px;\" class=\"btn btn-primary btn-xs\"><i class=\"fa fa-search\"></i></a>"+
	"<a href=\"javascript:;\" onclick=\"window.open('popup.jsp?cible=Pop-up/popup-ajoutingenieur&amp;libtable=prenom&amp;inputname=idingenieur"+indice+"', 'popupWindow','width=1200,height=800,scrollbars=yes');\" style=\"height:  30px !important;margin-left: 4px;margin-top: 1px;\" class=\"btn btn-primary btn-xs\">+</a>"+
	"</div></td>";
	node+="<td style=\"width: 100px;\"><a href=\"javascript:;\">details</a></td><td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
	
	$("#ingenieurs").append(node);
	$("[name='suppr']").on("click",function(){$(this).parent("td").parent("tr").remove();});
	indice++;
}
function addChildEstim(){
	var node = "<tr><td><input placeholder=\"dd/MM/yyyy\" class=\"datepicker\" type=\"text\" name=\"dateestimation\"/></td>";
	node+="<td style=\"width: 100px;\"><input type=\"text\" name=\"estimation\"/></td><td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
	
	$("#estimates").append(node);
	$('.datepicker').datepicker({
		format: 'dd/mm/yyyy'
	});
	$("[name='suppr']").on("click",function(){$(this).parent("td").parent("tr").remove();});
}
function addChildBill(){
	var node = "<tr><td><input type=\"text\" style=\"width: 50px;\" name=\"codebill\"/></td>";
	node+="<td><input type=\"text\" name=\"libellebill\"/></td><td><textarea style=\"height: 25px;\" name=\"descriptionbill\"></textarea></td><td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
	
	$("#bills").append(node);
	$("[name='suppr']").on("click",function(){$(this).parent("td").parent("tr").remove();});
}

function changeUnite(select){
	var node = $("a",$(select).parent("div").parent("td").next());
	node.prop("href","main.jsp?cible=configuration/ingenieur-fiche&id="+select.value);
	node.prop("target","_blank");
}
</script>