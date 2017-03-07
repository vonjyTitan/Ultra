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
   <%=HTMLBuilder.beginPanel("", 12)%>
   <div id="exTab3" class="">	
<ul  class="nav nav-pills">
			<li class="active" id="tabindex">
        <a  href="#1a" data-toggle="tab">Bills</a>
			</li>
			<li><a href="#2a" data-toggle="tab">Estimate and Count</a>
			</li>
			<li><a href="#3a" data-toggle="tab">Material on site</a>
			</li>
			<li><a href="#5a" data-toggle="tab">Attached file</a>
			</li>
			<li id="tablog"><a href="#4a" data-toggle="tab">Log</a>
			</li>
		</ul>

			<div class="tab-content clearfix">
			<div class="tab-pane active" id="1a">
			</div>
			</div>
			</div>
   <%=HTMLBuilder.endPanel() %>
<script language="JavaScript">
function drawChart() {
   // Define the chart to be drawn.
   var data = google.visualization.arrayToDataTable([
      ['Month', 'Estimate','Real']
      <%for(Estimation st:stat){%>
	  ,['<%=UtileAffichage.getMonthLibeleByDate(st.getMois())%> <%=UtileAffichage.getYearByDate(st.getMois())%>',  <%=st.getEstimation()%>,<%=st.getTotal()%>]
	  <%}%>
      ]);

   var options = {
      title: ''	  
   }; 

   // Instantiate and draw the chart.
   var chart = new google.visualization.BarChart(document.getElementById('stat'));
   chart.draw(data, options);
}
google.charts.setOnLoadCallback(drawChart);
</script>