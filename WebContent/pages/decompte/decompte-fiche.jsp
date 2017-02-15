<%@page import="com.service.DecompteService"%>
<%@page import="utilitaire.ConstantEtat"%>
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
	builder.addNotVisibleChamp(new String[]{"idmoisprojet","idprojet","idutilisateur","estimation","datedecompte","datecertification","remboursement","matonsitecredit","matonsitedebit","libelle","description","code","etat"});
	double somme = DecompteService.getInstance().getQuantityxUnitPrice(Integer.parseInt(SessionUtil.getValForAttr(request, "id")));
%>
<h3>Estimation details</h3>
<%=HTMLBuilder.beginPanel("General information",12) %>
<div class="form-group col-lg-6">
	<p class="col-lg-6">Etat : </p>
	<% if(listEstimation.get(0).getEtat() == ConstantEtat.MOIS_CREATED){%>
	<p class="col-lg-6">Created</p>
	<%} 
	else if(listEstimation.get(0).getEtat() == ConstantEtat.MOIS_DECOMPTE){%>
	<p class="col-lg-6">Discount</p>
	<%} 
	 else {%>
	 <p class="col-lg-6">Certified</p>
	 <%} %>
</div>

<%=builder.getBody()%>

<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED){%>
<form action="decompte-decompte">
	<input type="hidden" name="etat" value="<%=ConstantEtat.MOIS_CERTIFIED %>" >
	<input type="hidden" name="idmoisprojet" value="<%=listEstimation.get(0).getIdmoisprojet() %>" >
	<input type ="submit" class="btn btn-primary" value="Certified">
</form>
<%} %>
<% if(listEstimation.get(0).getEtat() == ConstantEtat.MOIS_CERTIFIED){%>
<div class="form-group col-lg-12" style="margin-left: 50px;">
	<a class="btn btn-primary btn-xs" href="#">Export to Excel</a>
	
</div>
<%} %>

<%=HTMLBuilder.endPanel()%>

<div id="exTab3" class="">	
<ul  class="nav nav-pills">
	<% 
		
		Bill critBill=new Bill();
		critBill.setNomTable("bill_libelle");
		List<Bill> billResult=DaoModele.getInstance().findPageGenerique(1, critBill," and idprojet= " + listEstimation.get(0).getIdprojet());
	%>
<%for(int i=0;i<billResult.size();i++){ %>
			<li class="active" id="tabindex">
        		<a  href=<%="#"+i+"a" %> data-toggle="tab"><%=billResult.get(i).getLibelle() %></a>
			</li>
			<%} %>
		</ul>
		<div class="tab-content clearfix">
		<%for(int i=0;i<billResult.size();i++){ 
			ItemRapport critItem=new ItemRapport();
			critItem.setNomTable("itemrapport_libelle");
			List<ItemRapport> ItemResult=DaoModele.getInstance().findPageGenerique(1, critItem," and idbill= " + billResult.get(i).getIdbill() +" and idmoisprojet= " + SessionUtil.getValForAttr(request, "id"));%>
			  <div class="tab-pane active" id=<%=i+"a" %>>
		     <form action="decompte-decompte">
		          <table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Code</th>
			<th>Label</th>
			<th>PU</th>
			<th>Estimate</th>
			<th>Quantity</th>

		</tr>
	</thead>
	<tbody>
		<%
		for(ItemRapport item:ItemResult){
		%>
		
			<tr>
				<td><%=item.getCode() %></td>
				<td><%=item.getLibelle() %></td>
				<td><%=item.getPu()%></td>
				<td><%=item.getQuantiteestime() %></td>
				<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED && ItemResult.size()>0){%>
					<td><input type="text" name="quantite" placeholder="<%=item.getCredit() %>" ></td>
				<%} 
				else {%><td><%=item.getCredit() %></td><% }%>
			
				<td><input type="hidden" name=iditemrapport value="<%=item.getIditemrapport() %>" ></td>
				<td><input type="hidden" name=idmoisprojet value="<%=item.getIdmoisprojet() %>" ></td>
				<td><input type="hidden" name="idbillitem" value="<%=item.getIdbillitem() %>" ></td>
			</tr>
		
		<%
		
		}
		%>
	</tbody>
	
</table>
	
	<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED && ItemResult.size()>0){%>
		<input type ="submit" class="btn btn-primary" value="update">
	      
	<%} %>
	</div>
	</form>
<%
}
		%>
</div>

