<%@page import="utilitaire.UtileAffichage"%>
<%@page import="com.service.DecompteService"%>
<%@page import="utilitaire.ConstantEtat"%>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map.Entry"%>
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
	builder.addNotVisibleChamp(new String[]{"idmoisprojet","idprojet","idutilisateur","datedecompte","datecertification","matonsitecredit","matonsitedebit","libelle","description","code","etat"});
	double somme = DecompteService.getInstance().getQuantityxUnitPrice(Integer.parseInt(SessionUtil.getValForAttr(request, "id")));
	
	List<MatOnSite> matonsites = DecompteService.getInstance().getMatOnSiteByEstimation(Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
	Map<Bill,List<ItemRapport>> billItem = DecompteService.getInstance().getItemRapportByBill(Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
%>
<h3><a href="main.jsp?cible=projet/projet-fiche&id=<%=listEstimation.get(0).getIdprojet() %>"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Estimation details</h3>
<%=HTMLBuilder.beginPanel("General information",6) %>
<div class="form-group col-lg-6">
	<p class="col-lg-6">Status : </p>
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
	
	<form action="decompte-getCertificate" id="getCertificate_form">
		<input type="hidden" name="idmoisprojet" value="<%=listEstimation.get(0).getIdmoisprojet() %>" >
		<input type ="submit" class="btn btn-primary" value="Export to Excel">
	</form>
	<a class="btn btn-primary btn-xs" href="main.jsp?cible=decompte/decompte-getCertificate">Extract 1</a>
	<a class="btn btn-primary btn-xs <%=(listEstimation.get(0).getEtat() == ConstantEtat.MOIS_CERTIFIED ? "" : "disabled") %>" href="#" >Export to Excel</a>
		<a class="btn btn-primary btn-xs <%=(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ? "" : "disabled") %>" onclick="<%=(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ? "certificated();" : "") %>" href="javascript:;">Certified</a>
<form action="decompte-decompte" id="decompte_form">
	<input type="hidden" name="etat" value="<%=ConstantEtat.MOIS_CERTIFIED %>" >
	<input type="hidden" name="idmoisprojet" value="<%=listEstimation.get(0).getIdmoisprojet() %>" >

</form>
</div>

<%=HTMLBuilder.endPanel()%>
<div class="col-lg-6" >
	<h3>Material on site (value on this month only)</h3>
	<form action="decompte-matonsiteupdate">
		         <input type="hidden" name="idmoisprojet" value="<%=listEstimation.get(0).getIdmoisprojet()%>">
		          <table class="table table-striped table-advance table-hover table-bordered table-scrollable" style="background-color: #d2c9c9;">
	<thead>
	<tr>
		<th>Id</th>
		<th>Description</th>
		<th>Rate</th>
		<th>Last</th>
		<th>This</th>
		<th>Amount</th>
	</tr>
	</thead>
	<tbody>
		<%for(MatOnSite matonsite:matonsites){
			%>
			<tr>
				<td><%=matonsite.getCode() %></td>
				<td><%=matonsite.getLibelle() %></td>
				<td><%=matonsite.getPu() %></td>
				<td><%=matonsite.getLast() %></td>
				<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ){%>
				<td><input type="text" name="credit" value="<%=matonsite.getCredit()%>">
				<input type="hidden" name="idmatonsite" value="<%=matonsite.getIdmatonsite()%>"></td>
				<%} else{%>
				<td><%=matonsite.getCredit() %></td>
				<%} %>
				<td><%=matonsite.getMontant() %></td>
				</tr>
		<%}%>
	</tbody>
	</table>
	<input type ="submit" class="btn btn-primary" <%=(matonsites.size()==0 ? "disabled=\"disabled\"" : "") %> value="update">
	</form>
</div>
<div class="col-lg-12">
<div id="exTab3" class="">	
<ul  class="nav nav-pills">
	<% 
		Set<Entry<Bill,List<ItemRapport>>> set = billItem.entrySet();
		int i = 0;
		for(Entry<Bill,List<ItemRapport>> entry:set){%>
			<li <% if(i == 0){%>class="active" id="tabindex"<%} %> >
        		<a  href=<%="#"+i+"a" %> data-toggle="tab"><%=entry.getKey().getCode() %></a>
			</li>
			<%i++;}i=0; %>
		</ul>
		<div class="tab-content clearfix">
		<%for(Entry<Bill,List<ItemRapport>> entry:set){ 
			List<ItemRapport> ItemResult=entry.getValue();%>
			  <div class="tab-pane active" id=<%=i+"a" %>>
		     <form action="decompte-decompte">
		          <table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Id</th>
			<th>Description</th>
			<th>Rate</th>
			<th>Last</th>
			<th>Calculated Quantity</th>
			<th>Estimated Quantity</th>
			<th>Amount</th>

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
				<td><%=item.getLast() %></td>
				<% if(listEstimation.get(0).getEtat() != ConstantEtat.MOIS_CERTIFIED ){%>
					<td><input type="text" name="estimate" value="<%=item.getQuantiteestime() %>" ></td>
					<td><input type="text" name="quantite" value="<%=item.getCredit() %>" ></td>
					
				<%} 
				else {%>
					<td><%=item.getQuantiteestime() %></td>
					<td><%=item.getCredit() %></td>
				<% }%>
				<td><%=UtileAffichage.formatMoney(item.getMontant()) %></td>
				<input type="hidden" name=iditemrapport value="<%=item.getIditemrapport() %>" >
				<input type="hidden" name=idmoisprojet value="<%=item.getIdmoisprojet() %>" >
				<input type="hidden" name="idbillitem" value="<%=item.getIdbillitem() %>" >
			</tr>
		
		<%
		i++;
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

<script>

$(document).ready(function(){
	window.setTimeout(function(){
		$("#tabindex > a").trigger("click");},500);
		$("#decompte_form").on("submit",function(){
			return certificated;
		});
	});
	
	function certificated(){
		var r = confirm("Would you like to certificate ?");
		if(r==true)
			$("#decompte_form").submit();
	}
</script>

