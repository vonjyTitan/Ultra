<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	BillItem critItem = new BillItem();
	critItem.setNomTable("billitem_libelle");
	PageFiche builder=new PageFiche(critItem,request);
	builder.removeChamp(new String[]{"Idbill","Iditem","Idbillitem"});
	
	ItemRapport critRapport = new ItemRapport();
	List<ItemRapport> raporrts = DaoModele.getInstance().findPageGenerique(1, critRapport, " and idbillitem="+SessionUtil.getValForAttr(request, "id"));
%>
<h3><a href="main.jsp?cible=Bill/bill-fiche&id=<%=((BillItem)builder.getData()).getIdbill()%>"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> MEASUREMENT SHEET</h3>
<%=HTMLBuilder.beginPanel("General information",6) %>
<%=builder.getBody()%>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Story",6) %>
	<div class="col-lg-12" style="max-height:250px;overflow-y:auto;">
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Month of decompte</th>
			<th>Calculated</th>
			<th>Estimated</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<%
		for(ItemRapport rap:raporrts){
		%>
			<tr>
			</tr>
		<%
		}
		%>
	</tbody>
</table>
</div>
<%=HTMLBuilder.endPanel()%>