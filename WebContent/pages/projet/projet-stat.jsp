<%@page import="utilitaire.UtileAffichage"%>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%@page import="com.service.StatService"%>
<jsp:include page='../verificateur.jsp'/>
<%
	int idprojet = Integer.valueOf("0"+SessionUtil.getValForAttr(request, "id"));
	List<Estimation> stat = StatService.getInstance().getStatProjet(idprojet);
	
%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   <script type="text/javascript">
   google.charts.load('current', {packages: ['corechart']});     
   </script>
   
   <h3><a href="main.jsp?cible=projet/projet-fiche&id=<%=idprojet%>"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Project progress stat</h3>
   <div class="col-lg-12">
   		<div id="stat" class="raw"></div>
   </div>
<script language="JavaScript">
function drawChart() {
   // Define the chart to be drawn.
   var data = google.visualization.arrayToDataTable([
      ['Month', 'Estimate','Real','Line Estimate','Line real']
      <%for(Estimation st:stat){%>
	  ,['<%=UtileAffichage.getMonthLibeleByDate(st.getMois())%> <%=UtileAffichage.getYearByDate(st.getMois())%>',  <%=st.getEstimation()%>,<%=st.getTotal()%>,  <%=st.getEstimation()%>,<%=st.getTotal()%>]
	  <%}%>
      ]);

   var options = {
      title: ''	  ,
      seriesType: 'bars',
      series: {3: {type: 'line'},2: {type: 'line'}},
      legend: { position: 'top', maxLines: 2 } 
   }; 

   // Instantiate and draw the chart.
   var chart = new google.visualization.ComboChart(document.getElementById('stat'));
   chart.draw(data, options);
}
google.charts.setOnLoadCallback(drawChart);
</script>