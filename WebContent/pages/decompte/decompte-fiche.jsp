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
	Estimation estimationCrit = new Estimation();
	estimationCrit.setNomTable("decompte_libelle");
	List<Estimation>  listEstimation = DaoModele.getInstance().findPageGenerique(1, estimationCrit," and idmoisprojet= " + SessionUtil.getValForAttr(request, "id"));
	PageFiche builder=new PageFiche(crit,request);
	builder.setDefaultClassForCOntainer("col-lg-6");
	builder.addNotVisibleChamp(new String[]{"idmoisprojet","idprojet","idutilisateur","estimation","datedecompte","datecertification","remboursement","matonsitecredit","matonsitedebit","libelle","description","code"});
%>
<h3>Estimation details</h3>
<%=HTMLBuilder.beginPanel("General information",12) %>
<%=HTMLBuilder.endPanel()%>
<form action="decompte-decompte">
<div id="exTab3" class="">	
<ul  class="nav nav-pills">
	<% 
	
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
			ItemRapport critItem=new ItemRapport();
			critItem.setNomTable("itemrapport_libelle");
			List<ItemRapport> ItemResult=DaoModele.getInstance().findPageGenerique(1, critItem," and idbill= " + billResult.get(i).getIdbill() +" and idmoisprojet= " + SessionUtil.getValForAttr(request, "id"));%>
			  <div class="tab-pane active" id=<%=i+"a" %>>
		          <table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Label</th>
			<th>PU</th>
			<th>Estimate</th>
			<th>Quantity</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<%
		for(ItemRapport item:ItemResult){
		%>
			<tr>
				<td><%=item.getCode() %></td>
				<td><%=item.getLibelle() %></td>
				<td><%=item.getPu() %></td>
				<td><%=item.getQuantiteestime() %></td>
				<td><input type="text" name="quantite" ></td>
				<td><input type="hidden" name=idmoisprojet value="<%=item.getIdmoisprojet() %>" ></td>
				<td><input type="hidden" name="idbillitem" value="<%=item.getIdbillitem() %>" ></td>
			</tr>
		<%
		}
		%>
	</tbody>
	
</table>
<input type ="submit" class="btn btn-primary" value="update">      
			</div>
<%
}
		%>
</div>

</form>