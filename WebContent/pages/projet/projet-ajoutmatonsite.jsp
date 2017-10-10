<%@page import="javax.xml.crypto.Data"%>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%@page import="com.service.*"%>
<%@page import="utilitaire.ConfigUtil"%>
<%@page import="java.util.Map"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Projet p=DaoModele.getInstance().findById(new Projet(), Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
%>
<h3><a href="main.jsp?cible=projet/projet-fiche&id=<%=p.getIdprojet() %>" ><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Add Mat on site for project <%=p.getLibelle() %></h3>
<form action="projet-ajoutmatonsite" method="post" class="form-horizontal style-form">
<input type="hidden" name="idprojet" value="<%=SessionUtil.getValForAttr(request, "id")%>"/>
<%=HTMLBuilder.beginPanel("", 6)%>
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>PU</th>
			<th></th>
		</tr>
	</thead>
	<tbody id="materiels">
	</tbody>
</table>
<div class="col-lg-12" style="text-align:center;">
<a href="javascript:;" id="addmateriel" class="btn btn-primary btn-xs" style="width:150px;"><i class="fa fa-plus"></i></a>
</div>
<div class="form-group col-lg-12"><label class="control-label col-lg-4"></label><div class="col-lg-8" style="text-align: right;"> <input class="btn btn-primary" value="Submit" type="submit"></div></div>

<%=HTMLBuilder.endPanel()%>
</form>
<script>
var indice=1;
$(document).ready(function(){
	$("#addmateriel").on("click",function(){
		additem();
	});
	additem();
});
function additem(){
	var node = "<tr><td><div class=\"col-sm-12\"><input id=\"idmateriel"+indice+"_val\" name=\"idmateriel\" type=\"hidden\"><input id=\"idmateriel"+indice+"_lib\" disabled=\"true\" class=\"form-control\" style=\"float: left;width: 80%;\" type=\"text\"><a href=\"javascript:;\" onclick=\"window.open('popup.jsp?cible=Pop-up/popup-materiel&amp;libtable=libelle&amp;inputname=idmateriel"+indice+"', 'popupWindow','width=1200,height=800,scrollbars=yes');\" style=\"height:  30px !important;margin-left: 4px;margin-top: 1px;\" class=\"btn btn-primary btn-xs\">...</a>"+
	"<a href=\"javascript:;\" onclick=\"window.open('popup.jsp?cible=Pop-up/popup-ajoutmateriel&amp;libtable=libelle&amp;inputname=idmateriel"+indice+"', 'popupWindow','width=1200,height=800,scrollbars=yes');\" style=\"height:  30px !important;margin-left: 4px;margin-top: 1px;\" class=\"btn btn-primary btn-xs\">+</a>"+
	"</div></td>";
	node+="<td style=\"width: 100px;\"><input type=\"text\" name=\"pu\"/></td><td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
	
	$("#materiels").append(node);
	$("[name='suppr']").on("click",function(){$(this).parent("td").parent("tr").remove();});
	indice++;
}
</script>