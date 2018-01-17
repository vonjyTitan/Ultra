<%@page import="utilitaire.UtileAffichage"%>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Bill crit = new Bill();
	crit.setNomTable("bill_libelle");
	Bill data = DaoModele.getInstance().findById(crit,Integer.valueOf( SessionUtil.getValForAttr(request, "id")));
	PageFiche builder = new PageFiche(crit,request);
	builder.setData(data);
	builder.addNotVisibleChamp(new String[]{"idbill","idprojet"});
	builder.setLienForAttr("projet", "main.jsp?cible=projet/projet-fiche", "id", "idprojet");
	BillItem critItem = new BillItem();
	critItem.setNomTable("billitem_libelle");
	critItem.setPackSize(100);
	List<BillItem> items = DaoModele.getInstance().findPageGenerique(1, critItem," and idbill="+SessionUtil.getValForAttr(request, "id"));
%>
<h3><a href="main.jsp?cible=projet/projet-fiche&id=<%=data.getIdprojet() %>" ><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Bill details</h3>
<%=HTMLBuilder.beginPanel("General informations", 5) %>
<%=builder.getBody()%>
<div class="form-group col-lg-12" style="text-align: right;">
		<a class="btn btn-primary btn-xs" href="main.jsp?cible=Bill/bill-modif&id=<%=data.getIdbill()%>"><i class="fa fa-pencil "></i> Update</a>
</div>
<%=HTMLBuilder.endPanel() %>
<%=HTMLBuilder.beginPanel("Items", 7)%>
<div class="col-lg-12" style="max-height:250px;overflow-y:auto;">
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Label</th>
			<th>Rate</th>
			<th>Estimate</th>
			<th>Total</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<%
		for(BillItem item:items){
		%>
			<tr>
				<td><a href="main.jsp?cible=Bill/bill-mesurment&id=<%=item.getIdbillitem()%>"><%=item.getCode() %></a></td>
				<td><%=item.getLibelle() %></td>
				<td><%=item.getPu() %></td>
				<td><%=item.getEstimation() %></td>
				<td><%=UtileAffichage.formatMoney(item.getActuel()) %></td>
				<td><a class="btn btn-primary btn-xs" onclick="modifItemBill(<%=item.getPu() %>,<%=item.getEstimation() %>,'<%=item.getCode() %>',<%=item.getIdbillitem() %>,<%=item.getIditem() %>)" href="javascript:;"><i class="fa fa-pencil "></i></a></td>
			</tr>
		<%
		}
		%>
	</tbody>
</table>
</div>
<%=HTMLBuilder.endPanel() %>
<%=HTMLBuilder.beginPanel("Add Items", 7)%>
<form method="post" action="bill-ajoutitem">
<input type="hidden" value="<%=data.getIdbill()%>" name="id"/>
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Rate</th>
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
<div class="col-lg-12" style="text-align:right;">
	<input class="btn btn-primary" value="Valide" type="submit">
</div>
</form>
<%=HTMLBuilder.endPanel()%>
<div class="modal fade" id="modif" style="margin-top:100px;margin-left:100px;">
	<div class="modal-dialog">
	<form action="bill-modifitem" id="form-annulation" method="post">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" style="color: white;" aria-label="Close" data-dismiss="modal" type="button">
                    <span aria-hidden="true">x</span>
                </button>
                <h4>Update item for bill</h4>
            </div>
            <div class="modal-body">
            	<input type="hidden" name="idbillitem" id="idbillitem"/>
            	<input type="hidden" name="iditem" id="iditem"/>
            	<input type="hidden" name="idbill" value="<%=data.getIdbill()%>"/>
            	<div id="codecontainer" class="form-group col-lg-12" style="margin-top:30px;"><div class="col-sm-4 col-sm-4 "><label class="control-label" for="">Code item : </label></div><div class="col-sm-7"><input name="codeitem" id="codeitem" class="form-control" disabled="true" value="" type="text"></div></div>
                <div id="codecontainer" class="form-group col-lg-12"><div class="col-sm-4 col-sm-4 "><label class="control-label" for="pu">PU : </label></div><div class="col-sm-7"><input name="pu" id="pu" class="form-control money number" value="" type="text"></div></div>
                <div id="codecontainer" class="form-group col-lg-12" ><div class="col-sm-4 col-sm-4 "><label class="control-label" for="estimation">Estimate : </label></div><div class="col-sm-7"><input name="estimation" id="estimation" class="form-control money number" value="" type="text"></div></div>
            </div>
            
            <div class="modal-footer">
                <div class="col-lg-12">
                <input type="submit" class="btn btn-primary btn-xs" name="confirme"  value="Valide"/>
			<a class="btn btn-warning btn-xs closes"  href="javascript:;">Cancel</a>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>
<script>
var indice=1;
$(document).ready(function(){
	$("#additem").on("click",function(){
		additem();
	});
	additem();
	$(".closes").on("click",function(){
		$(this).parents(".modal").prop("class","modal fade");
	});
	$(".close").on("click",function(){
		$(this).parents(".modal").prop("class","modal fade");
	});
});
function additem(){
	var node = "<tr><td><div class=\"col-sm-12\"><input id=\"iditem"+indice+"_val\" name=\"iditem\" type=\"hidden\"><input id=\"iditem"+indice+"_lib\" disabled=\"true\" class=\"form-control\" style=\"float: left;width: 75%;\" type=\"text\"><a href=\"javascript:;\" onclick=\"window.open('popup.jsp?cible=Pop-up/popup-item&amp;libtable=libelle&amp;inputname=iditem"+indice+"', 'popupWindow','width=1200,height=800,scrollbars=yes');\" style=\"height:  30px !important;margin-left: 4px;margin-top: 1px;\" class=\"btn btn-primary btn-xs\"><i class=\"fa fa-search\"></i></a>"+
	"<a href=\"javascript:;\" onclick=\"window.open('popup.jsp?cible=Pop-up/popup-ajoutitem&amp;libtable=libelle&amp;inputname=iditem"+indice+"', 'popupWindow','width=1200,height=800,scrollbars=yes');\" style=\"height:  30px !important;margin-left: 4px;margin-top: 1px;\" class=\"btn btn-primary btn-xs\">+</a>"+
	"</div></td>";
	node+="<td style=\"width: 100px;\"><input type=\"text\" class=\"money number\" name=\"pu\"/></td><td><input name=\"estimation\" class=\"money number\"/></td><td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
	
	$("#items").append(node);
	$("[name='suppr']").on("click",function(){$(this).parent("td").parent("tr").remove();});
	indice++;
}
function modifItemBill(pu,estimate,codeitem,idbillitem,iditem){
	$("#pu").prop("value",pu);
	$("#estimation").prop("value",estimate);
	$("#idbillitem").prop("value",idbillitem);
	$("#codeitem").prop( "value",codeitem);
	$("#iditem").prop( "value",iditem);
	$("#modif").prop("class","modal show");
}
</script>