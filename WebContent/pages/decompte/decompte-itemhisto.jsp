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
	int iditemrapport = Integer.valueOf(SessionUtil.getValForAttr(request, "id"));
	ItemRapport ir= new ItemRapport();
	ir.setNomTable("itemrapport_libelle");
	ir = DaoModele.getInstance().findById(ir, iditemrapport);
	ItemRapport crit = new ItemRapport();
	crit.setIdbillitem(ir.getIdbillitem());
	crit.setPackSize(40);
	crit.setNomTable("item_histo");
	List<ItemRapport> irs = DaoModele.getInstance().findPageGenerique(1,crit," and datedecompte is not null and iditemrapport!="+ir.getIditemrapport());
%>
<h3><a href="main.jsp?cible=decompte/decompte-fiche&id=<%=ir.getIdmoisprojet() %>" ><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Item <%=ir.getCode() %> story</h3>
<%=HTMLBuilder.beginPanel("", 7,"mt pull-center")%>
<table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
	<thead>
		<tr>
			<th>Date</th>
			<th>Qte</th>
			<th>Amount</th>
		</tr>
	</thead>
	<tbody>
		<%
			for(ItemRapport itemrapport:irs){
		%>
		<tr>
			<td><%=UtileAffichage.formatAfficherDate(itemrapport.getDatedecompte())%></td>
			<td><%=itemrapport.getCredit() %></td>
			<td></td>
		</tr>
		<%} %>
	</tbody>
</table>
<%=HTMLBuilder.endPanel()%>