<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Estimation crit=new Estimation();
	crit.setNomTable("decompte_libelle");
	PageFiche builder=new PageFiche(crit,request);
	builder.setDefaultClassForCOntainer("col-lg-6");
	builder.addNotVisibleChamp(new String[]{"idmoisprojet","idprojet","idutilisateur","estimation","datedecompte","datecertification","remboursement","matonsitecredit","matonsitedebit","libelle","description","mois","code"});
%>
<h3>Estimation details</h3>
<%=HTMLBuilder.beginPanel("General information",12) %>
<%=builder.getBody()%>
<%=HTMLBuilder.endPanel()%>


<div id="exTab3" class="">	
<ul  class="nav nav-pills">
	<% 
		Estimation estimationCrit = new Estimation();
		estimationCrit.setNomTable("decompte_libelle");
		List<Estimation>  listEstimation = DaoModele.getInstance().findPageGenerique(1, estimationCrit," and idmoisprojet= " + SessionUtil.getValForAttr(request, "id"));
		Bill critBill=new Bill();
		critBill.setNomTable("bill_libelle");
		List<Bill> billResult=DaoModele.getInstance().findPageGenerique(1, critBill," and idprojet= " + listEstimation.get(0).getIdprojet());
	%>
<%for(int i=0;i<billResult.size();i++){ %>
			<li class="active" id="tabindex">
        		<a  href=<%="#"+i+"a" %> data-toggle="tab">Bill <%=i %></a>
			</li>
			<%} %>
		</ul>
		<div class="tab-content clearfix">
		<%for(int i=0;i<billResult.size();i++){ 
			BillItem critBillItem=new BillItem();
			critBill.setNomTable("billitem_libelle");
			List<BillItem> billItemResult=DaoModele.getInstance().findPageGenerique(1, critBillItem," and idbill= " + billResult.get(i).getIdbill());%>
			  <div class="tab-pane active" id=<%=i+"a" %>>
		          <table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Label</th>
			<th>PU</th>
			<th>Estimate</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<%
		for(BillItem item:billItemResult){
		%>
			<tr>
				<td><%=item.getCode() %></td>
				<td><%=item.getLibelle() %></td>
				<td><%=item.getPu() %></td>
				<td><%=item.getEstimation() %></td>
				<td><a class="btn btn-primary btn-xs" onclick="modifItemBill(<%=item.getPu() %>,<%=item.getEstimation() %>,'<%=item.getCode() %>',<%=item.getIdbillitem() %>,<%=item.getIditem() %>)" href="javascript:;"><i class="fa fa-pencil "></i></a></td>
			</tr>
		<%
		}
		%>
	</tbody>
</table>        
			</div>
			<%
			} %>

</div>
