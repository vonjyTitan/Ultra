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
	BillItem critItem = new BillItem();
	critItem.setNomTable("billitem_libelle");
	PageFiche builder=new PageFiche(critItem,request);
	builder.removeChamp(new String[]{"Idbill","Iditem","Idbillitem"});
	
	ItemRapport critRapport = new ItemRapport();
	critRapport.setNomTable("mesurment");
	List<ItemRapport> raporrts = DaoModele.getInstance().findPageGenerique(1, critRapport, " and idbillitem="+SessionUtil.getValForAttr(request, "id"));
%>
<h3><a href="main.jsp?cible=Bill/bill-fiche&id=<%=((BillItem)builder.getData()).getIdbill()%>"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> MEASUREMENT SHEET</h3>
<%=HTMLBuilder.beginPanel("General information",5) %>
<%=builder.getBody()%>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Story",7) %>
	<div class="col-lg-12" style="max-height:450px;overflow-y:auto;">
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Month of decompte</th>
			<th>Calculated quantity</th>
			<th>Estimated quantity</th>
			<th>Total</th>
			<th>User</th>
		</tr>
	</thead>
	<tbody>
		<%
		for(ItemRapport rap:raporrts){
			String cible="main.jsp?cible=configuration/utilisateur-fiche";
			if(rap.getIsingenieur()==1)
				cible="main.jsp?cible=configuration/ingenieur-fiche";
		%>
			<tr>
				<th><%=UtileAffichage.getNonNullValue(rap.getDatedecompte(),java.sql.Date.class) %></th>
				<th><%=UtileAffichage.getNonNullValue(rap.getCredit(),Double.class) %></th>
				<th><%=UtileAffichage.getNonNullValue(rap.getQuantiteestime(),Double.class) %></th>
				<th><%=UtileAffichage.getNonNullValue(rap.getMontant(),Double.class) %></th>
				<th><a href="<%=cible+"&id="+rap.getIdutilisateur()%>"><%=UtileAffichage.getNonNullValue(rap.getUtilisateur(),String.class) %></a></th>
			</tr>
		<%
		}
		%>
	</tbody>
</table>
</div>
<%=HTMLBuilder.endPanel()%>