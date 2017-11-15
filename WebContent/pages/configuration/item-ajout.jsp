<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	List<Unite> unites = DaoModele.getInstance().findPageGenerique(1, new Unite());
%>
<form action="item-insert" method="post" class="form-horizontal style-form">
<%=HTMLBuilder.beginPanel("Add new Items", 12)%>
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Label</th>
			<th>Unit</th>
			<th>Description</th>
			<th></th>
		</tr>
	</thead>
	<tbody id="items">
	</tbody>
</table>
<div class="col-lg-12" style="text-align:center;">
<a href="javascript:;" id="addmateriel" class="btn btn-primary btn-xs" style="width:150px;"><i class="fa fa-plus"></i></a>
</div>
<div class="form-group col-lg-12"><label class="control-label col-lg-4"></label><div class="col-lg-8" style="text-align: right;"> <input class="btn btn-primary" value="Submit" type="submit"></div></div>

<%=HTMLBuilder.endPanel()%>
</form>
<script>
var selectText="<select class=\"form-control\" style=\"height: 35px;\" name=\"idunite\" id=\"idunite\">"
<%for(Unite unite: unites){%>+"<option value=<%=unite.getIdunite()%>><%=unite.getLibelle()%></option>"<%}%>
+"</select>";
$(document).ready(function(){
	$("#addmateriel").on("click",function(){
		additem();
	});
	for(var i=0;i<20;i++){
		additem();
	}
	
});
function additem(){
	var node = "<tr><td><input type=\"text\" name=\"code\" placeholder=\"code\"/></td>"+
	"<td><input type=\"text\" style=\"width: 70%;\" placeholder=\"libelle\" name=\"libelle\"/></td><td>"+selectText+"</td><td><textarea placeholder=\"description\" style=\"height: 25px;width: 70%;\" name=\"description\"></textarea></td><td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
	
	$("#items").append(node);
	$("[name='suppr']").on("click",function(){$(this).parent("td").parent("tr").remove();});
}
</script>