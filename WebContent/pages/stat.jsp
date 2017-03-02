<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%@page import="com.service.ProjetService"%>
<jsp:include page='verificateur.jsp'/>
 <%
 	List<ProjetStat> generalStat = ProjetService.getInstance().getStatProjetEnCour();
 %>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   <script type="text/javascript">
   google.charts.load('current', {packages: ['corechart']});     
   </script>
   
 <div class="row">
 
                  <div class="col-lg-9 main-chart">
                  
                  <div class="col-lg-12">
                  	<div id="rapport" class="row"></div>
                  </div>
                       <div class="col-lg-12">
                  	<div id="avancement" class="row"></div>
                    </div><!-- /row -->
                    
                    				
					<div class="row">
						<!-- TWITTER PANEL -->
					<!-- <div class="col-md-4 mb">
                      		<div class="darkblue-panel pn">
                      			<div class="darkblue-header">
						  			<h5>DROPBOX STATICS</h5>
                      			</div>
								<canvas id="serverstatus02" height="120" width="120"></canvas>
								<script>
									var doughnutData = [
											{
												value: 60,
												color:"#68dff0"
											},
											{
												value : 40,
												color : "#444c57"
											}
										];
										var myDoughnut = new Chart(document.getElementById("serverstatus02").getContext("2d")).Doughnut(doughnutData);
								</script>
								<p>April 17, 2014</p>
								<footer>
									<div class="pull-left">
										<h5><i class="fa fa-hdd-o"></i> 17 GB</h5>
									</div>
									<div class="pull-right">
										<h5>60% Used</h5>
									</div>
								</footer>
                      		</div><! -- /darkblue panel -->
						<!-- </div><!-- /col-md-4 -->
						
						
						<!-- <div class="col-md-4 mb">
							<!-- INSTAGRAM PANEL -->
							<!-- <div class="instagram-panel pn">
								<i class="fa fa-instagram fa-4x"></i>
								<p>@THISISYOU<br/>
									5 min. ago
								</p>
								<p><i class="fa fa-comment"></i> 18 | <i class="fa fa-heart"></i> 49</p>
							</div>
						</div><!-- /col-md-4 -->
						
					</div><!-- /row -->
					
					
					
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  
                  <div class="col-lg-3 ds">
                    <!--COMPLETED ACTIONS DONUTS CHART-->
						<h3>NOTIFICATIONS</h3>
                                        
                      <!-- First Action -->
                      <div class="desc">
                      	<div class="thumb">
                      		<span class="badge bg-theme"><i class="fa fa-clock-o"></i></span>
                      	</div>
                      	<div class="details">
                      		<p><muted>2 Minutes Ago</muted><br/>
                      		   <a href="#">You</a> have added new item.<br/>
                      		</p>
                      	</div>
                      </div>
                      <!-- Second Action -->
                      <div class="desc">
                      	<div class="thumb">
                      		<span class="badge bg-theme"><i class="fa fa-clock-o"></i></span>
                      	</div>
                      	<div class="details">
                      		<p><muted>3 Hours Ago</muted><br/>
                      		   <a href="#">You </a> have edit Bill 1 on project FLIC EN FLAC.<br/>
                      		</p>
                      	</div>
                      </div>
                      <!-- Third Action -->
                      <div class="desc">
                      	<div class="thumb">
                      		<span class="badge bg-theme"><i class="fa fa-clock-o"></i></span>
                      	</div>
                      	<div class="details">
                      		<p><muted>7 Hours Ago</muted><br/>
                      		   <a href="#">You </a> have added new item on Bill 1.<br/>
                      		</p>
                      	</div>
                      </div>
                      
                 
                  </div><!-- /col-lg-3 -->
              </div><! --/row -->
              <script language="JavaScript">
function drawRapport() {
   // Define the chart to be drawn.
   var datar = google.visualization.arrayToDataTable([
      ['Project', 'Estimate', 'Real']
      <%for(ProjetStat ps:generalStat){%>
	  ,['<%=ps.getLibelle()%>',  <%=ps.getEstimation()%>,      <%=ps.getActuel()%>]
	  <%}%>
      ]);
   
   var dataAv = google.visualization.arrayToDataTable([
        ['Project', '%']
        <%for(ProjetStat ps:generalStat){%>
  	  ,['<%=ps.getLibelle()%>',  <%=(100*ps.getActuel()/ps.getEstimation())%>]
  	  <%}%>
        ]);
   
   
   var optionsR = {
      title: 'General progress report'      
   };  
   
   var optionsAv = {
		      title: 'Progress by project (%)'      
		   };

   // Instantiate and draw the chart.
   var chartRap = new google.visualization.BarChart(document.getElementById('rapport'));//avancement
   
   var chartAv = new google.visualization.BarChart(document.getElementById('avancement'));//avancement
   
   chartRap.draw(datar, optionsR);
   chartAv.draw(dataAv, optionsAv);
}

</script>
              <script>
              google.charts.setOnLoadCallback(drawRapport);
              </script>