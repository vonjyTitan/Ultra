<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Projet p = DaoModele.getInstance().findById(new Projet(), Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
	InsertUpdateBuilder builder =new InsertUpdateBuilder(new Bill(),"bill-ajout",request);
	builder.removeChamp(new String[]{"idbill","idprojet"});
	builder.setChampTextarea("description");
	
%>
<h3><a href="main.jsp?cible=projet/projet-fiche&id=<%=p.getIdprojet() %>" ><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Add new bill for project <%=p.getLibelle() %></h3>
<%=builder.beginHTMLForm() %>
<%=HTMLBuilder.beginPanel("", 5)%>
<%=builder.getHTMLBody() %>
<input type="hidden" value="<%=p.getIdprojet()%>" name="idprojet"/>
<%=builder.getHTMLButton() %>
<%=HTMLBuilder.endPanel() %>
<%=HTMLBuilder.beginPanel("Items", 7)%>
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Unit price</th>
			<th>Estimate</th>
			<th></th>
		</tr>
	</thead>
	<tbody id="items">
	</tbody>
</table>
<div class="col-lg-12" style="text-align:center;">
<a href="javascript:;" id="additem" class="btn btn-primary btn-xs" style="width:150px;"><i class="fa fa-plus"></i></a>
</div>
<%=HTMLBuilder.endPanel()%>
<%=builder.endHTMLForm()%>
<script>
var indice=1;
$(document).ready(function(){
	$("#additem").on("click",function(){
		additem();
	});
	additem();
});
function additem(){
	var node = "<tr><td><div class=\"col-sm-12\"><input id=\"iditem"+indice+"_val\" name=\"iditem\" type=\"hidden\"><input id=\"iditem"+indice+"_lib\" disabled=\"true\" class=\"form-control\" style=\"float: left;width: 80%;\" type=\"text\"><a href=\"javascript:;\" onclick=\"window.open('popup.jsp?cible=Pop-up/popup-item&amp;libtable=libelle&amp;inputname=iditem"+indice+"', 'popupWindow','width=1200,height=800,scrollbars=yes');\" style=\"height:  30px !important;margin-left: 4px;margin-top: 1px;\" class=\"btn btn-primary btn-xs\"><i class=\"fa fa-search\"></i></a></div></td>";
	node+="<td style=\"width: 100px;\"><input type=\"text\" name=\"pu\"/></td><td><input name=\"estimation\"/></td><td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
	
	$("#items").append(node);
	$("[name='suppr']").on("click",function(){$(this).parent("td").parent("tr").remove();});
	indice++;
}
</script>