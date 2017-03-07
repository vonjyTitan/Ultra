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
	builder.addNotVisibleChamp(new String[]{"idmoisprojet","idprojet","idutilisateur","estimation","datedecompte","datecertification","matonsitecredit","matonsitedebit","libelle","description","code","etat"});
	double somme = DecompteService.getInstance().getQuantityxUnitPrice(Integer.parseInt(SessionUtil.getValForAttr(request, "id")));
	MatOnSite critmts = new MatOnSite();
	critmts.setPackSize(50);
	critmts.setNomTable("matonsite_projet_libelle");
	List<MatOnSite> matonsites = DaoModele.getInstance().findPageGenerique(1, critmts," and idmoisprojet="+listEstimation.get(0).getIdmoisprojet());
%>
<h3><a href="main.jsp?cible=projet/projet-fiche&id=<%=listEstimation.get(0).getIdprojet() %>"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Estimation details</h3>
<%=HTMLBuilder.beginPanel("General information",12) %>
<div class="form-group col-lg-6">
	<p class="col-lg-6">Etat : </p>
	<% if(listEstimation.get(0).getEtat() == ConstantEtat.MOIS_CREATED){%>
	<p class="col-lg-6">Created</p>
	<%} 
	else if(listEstimation.get(0).getEtat() == ConstantEtat.MOIS_DECOMPTE){%>
	<p class="col-lg-6">Discount in progress</p>
	<%} 
	 else {%>
	 <p class="col-lg-6">Certified</p>
	 <%} %>
</div>

<%=builder.getBody()%>
<div class="form-group col-lg-12" style="margin-left: 50px;">
	<a class="btn btn-primary btn-xs" href="main.jsp?cible=decompte/decompte-modif&id=<%=SessionUtil.getValForAttr(request, "id")%>">Update</a>
	<a class="btn btn-primary btn-xs <%=(listEstimation.get(0).getEtat() == ConstantEtat.MOIS_CERTIFIED ? "" : "disabled") %>" href="#" >Export to Excel</a>
		<a class="btn btn-primary btn-xs <%=(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ? "" : "disabled") %>" onclick="<%=(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ? "$('#decompte_form').submit()" : "") %>" href="javascript:;">Certified</a>
<form action="decompte-decompte" id="decompte_form">
	<input type="hidden" name="etat" value="<%=ConstantEtat.MOIS_CERTIFIED %>" >
	<input type="hidden" name="idmoisprojet" value="<%=listEstimation.get(0).getIdmoisprojet() %>" >

</form>
</div>

<%=HTMLBuilder.endPanel()%>
<div class="col-lg-6">
<div id="exTab3" class="">	
<ul  class="nav nav-pills">
	<% 
		
		Bill critBill=new Bill();
		critBill.setNomTable("bill_libelle");
		List<Bill> billResult=DaoModele.getInstance().findPageGenerique(1, critBill," and idprojet= " + listEstimation.get(0).getIdprojet());
	%>
<%for(int i=0;i<billResult.size();i++){ %>
			<li <% if(i == 0){%>class="active" id="tabindex"<%} %> >
        		<a  href=<%="#"+i+"a" %> data-toggle="tab"><%=billResult.get(i).getCode() %></a>
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
	
		for(ItemRapport item:ItemResult)
		{
		%>
		
			<tr>
				<td><%=item.getCode() %></td>
				<td><%=item.getLibelle() %></td>
				<td><%=item.getPu()%></td>
				
				<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ){%>
					<td><input type="text" name="estimate" value="<%=item.getQuantiteestime() %>" ></td>
					<td><input type="text" name="quantite" value="<%=item.getCredit() %>" ></td>
					
				<%} 
				else {%>
					<td><%=item.getQuantiteestime() %></td>
					<td><%=item.getCredit() %></td>
				<% }%>
			
				<input type="hidden" name=iditemrapport value="<%=item.getIditemrapport() %>" >
				<input type="hidden" name=idmoisprojet value="<%=item.getIdmoisprojet() %>" >
				<input type="hidden" name="idbillitem" value="<%=item.getIdbillitem() %>" >
			</tr>
		
		<%
		}
		
		
		%>
	</tbody>
	
</table>
	<% if(ItemResult.size() < 0 || ItemResult.size() == 0)
	{%>
		<p>No data to updated</p>	
	<%}%>
	<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED && ItemResult.size()>0){%>
		<input type ="submit" class="btn btn-primary" value="update">
	      
	<%} %>
	<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED &&  ItemResult.size() == 0){%>
		<input type ="submit" class="btn btn-primary" disabled="disabled" value="updated" onclick="return false;">
	      
	<%} %>
	</div>
	</form>
<%
}
		%>
</div>
</div>
</div>
<div class="col-lg-6" >
	<h3>Material on site (debit and credit on the month only)</h3>
	<form action="decompte-matonsiteupdate">
		         <input type="hidden" name="idmoisprojet" value="<%=listEstimation.get(0).getIdmoisprojet()%>">
		          <table class="table table-striped table-advance table-hover table-bordered table-scrollable" style="background-color: #d2c9c9;">
	<thead>
	<tr>
		<th>Code</th>
		<th>Label</th>
		<th>PU</th>
		<th>Credit</th>
		<th>Debit</th>
	</tr>
	</thead>
	<tbody>
		<%for(MatOnSite matonsite:matonsites){
			%>
				<td><%=matonsite.getCode() %></td>
				<td><%=matonsite.getLibelle() %></td>
				<td><%=matonsite.getPu() %></td>
				<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ){%>
				<td><input type="text" name="credit" value="<%=matonsite.getCredit()%>">
				<input type="hidden" name="idmatonsite" value="<%=matonsite.getIdmatonsite()%>"></td>
				<td><input type="text" name="debit" value="<%=matonsite.getDebit()%>"></td>
				<%} else{%>
				<td><%=matonsite.getCredit() %></td>
				<td><%=matonsite.getDebit() %></td>
				<%} %>
		<%}%>
	</tbody>
	</table>
	<input type ="submit" class="btn btn-primary" <%=(matonsites.size()==0 ? "disabled=\"disabled\"" : "") %> value="update">
	</form>
</div>
<script>

$(document).ready(function(){
	window.setTimeout(function(){
		$("#tabindex > a").trigger("click");},500);
	});
	
</script>

