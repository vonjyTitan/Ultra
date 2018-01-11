<%@page import="utilitaire.UtileAffichage"%>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%@page import="com.service.StatService"%>
<jsp:include page='verificateur.jsp'/>
 <%
	 int pageGeneral = Integer.valueOf("0"+SessionUtil.getValForAttr(request, "PageProj"));
 	pageGeneral = pageGeneral==0 ? 1: pageGeneral;
 	ListPaginner<ProjetStat> generalStat = (ListPaginner)StatService.getInstance().getStatProjetEnCour(pageGeneral);
 	Historique critH = new Historique();
 	critH.setNomChampOrder("datelog");
 	critH.setOrdering(DataEntity.DESC);
 	critH.setPackSize(20);
 	int pageActTrack = Integer.valueOf("0"+SessionUtil.getValForAttr(request, "PageTrack"));
    pageActTrack = pageActTrack==0 ? 1: pageActTrack;
 	critH.setNomTable("projet_historique_libelle");
 	ListPaginner<Historique> listHisto = (ListPaginner)DaoModele.getInstance().findPageGenerique(pageActTrack, critH);
 %>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   <script type="text/javascript">
   google.charts.load('current', {packages: ['corechart']});     
   </script>
   
 <div class="row">
 
                  <div class="col-lg-9 main-chart">
                  <div class="col-lg-3 pull-right">
						<ul class="pagination">
							<li><%if(pageGeneral>1){%><a href="main.jsp?cible=stat&PageProj=<%=pageGeneral-1 %>&PageTrack=<%=pageActTrack %>" style="background: #0086de; color: white;"><< Preview</a><%} if(pageGeneral<generalStat.nbPage){%><a href="main.jsp?cible=stat&PageProj=<%=pageGeneral+1 %>&PageTrack=<%=pageActTrack %>" style="background: #0086de; color: white;">Next >></a><%} %></li>
						</ul>
					</div>
                  <div class="col-lg-12">
                  	<div id="rapport" class="row"></div>
                  </div>
                       <div class="col-lg-12">
                  	<div id="avancement" class="row"></div>
                    </div><!-- /row -->
                    
                    <div class="col-lg-12">
                  	<div id="avance" class="row"></div>
                    </div>
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
					<div class="col-lg-3 pull-right">
						<ul class="pagination">
							<li><%if(pageGeneral>1){%><a href="main.jsp?cible=stat&PageProj=<%=pageGeneral-1 %>&PageTrack=<%=pageActTrack %>" style="background: #0086de; color: white;"><< Preview</a><%} if(pageGeneral<generalStat.nbPage){%><a href="main.jsp?cible=stat&PageProj=<%=pageGeneral+1 %>&PageTrack=<%=pageActTrack %>" style="background: #0086de; color: white;">Next >></a><%} %></li>
						</ul>
					</div>
					
					
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                
                  <div class="col-lg-3 ds" style="max-height:700px;overflow-y:auto;">
                    <!--COMPLETED ACTIONS DONUTS CHART-->
						<h3>History</h3>
                              <%for(Historique histo:listHisto){ %>         
                      <!-- First Action -->
                      <div class="desc">
                      	<div class="thumb">
                      		<span class="badge bg-theme"><i class="fa fa-clock-o"></i></span>
                      	</div>
                      	<div class="details">
                      		<p><muted><%=UtileAffichage.formatAfficherDate(histo.getDatelog()) %></muted><br/>
                      		   <a href="main.jsp?cible=configuration/utilisateur-fiche&id=<%=histo.getIdutilisateur()%>"><%=histo.getPrenom() %></a>, <%=histo.getAction() %>, on project <a href="main.jsp?cible=projet/projet-fiche&id=<%=histo.getIdintable()%>"><%=histo.getLibelle() %></a><br/>
                      		</p>
                      	</div>
                      </div>
                      <%} %>
                      </div>
                 <div class="col-lg-3 pull-right">
                                <ul class="pagination">
                                    <li>
                                    <%
                                    int compteurHaut = 0,compteurBas=pageActTrack;
                                    if(pageActTrack>3){
                                    	%><a href="javascript:;"><i class=\"fa fa-search\"></i></a><%
                                    }
                                    	for(int i=1;i<=listHisto.nbPage;i++){
                                    		compteurBas--;
                                    		if(compteurBas>3)
                                    			continue;
                                    		if(i==pageActTrack){
                                    %>
                                                    <a href="javascript:;" style="background: #0086de; color: white;"><%=i %></a>
                                                <%} else{%>
                                                <a href="main.jsp?cible=stat&PageTrack=<%=i%>&PageProj=<%=pageGeneral%>"><%=i %></a>
									<%
                                                }
                                    		if(compteurHaut==2)
                                    		{
                                    			%><a href="javascript:;"><i class=\"fa fa-search\"></i></a><%
                                    			break;
                                    		}
                                    		if(i>pageActTrack)
                                    			compteurHaut++;
									} %>
                                    </li>
                                </ul>
                            </div>
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
        <%for(ProjetStat ps:generalStat){
        double pourc = ps.getEstimation()==0 ? 0.0 : (100*ps.getActuel()/ps.getEstimation());
        %>
  	  ,['<%=ps.getLibelle()%>',  <%=pourc%>]
  	  <%}%>
        ]);
   
   var dataAvance = google.visualization.arrayToDataTable([
        ['Project', 'Advance start','Advance payed']
        <%for(ProjetStat ps:generalStat){
        %>
  	  ,['<%=ps.getLibelle()%>',  <%=ps.getAvance()%>,<%=(ps.getAvance()-ps.getAvanceactuel())%>]
  	  <%}%>
        ]);
   
   
   var optionsR = {
      title: 'General progress report'   ,
      legend: { position: 'top', maxLines: 2 }  
   };  
   
   var optionsAv = {
		      title: 'Progress by project (%)',
		      legend: { position: 'top', maxLines: 2 }      
		   };
   var optionsAvance = {
		      title: 'Avance payed by project',
		      legend: { position: 'top', maxLines: 2 }       
		   };

   // Instantiate and draw the chart.
   var chartRap = new google.visualization.BarChart(document.getElementById('rapport'));//avancement
   
   var chartAv = new google.visualization.BarChart(document.getElementById('avancement'));//avancement
   
   var chartAvance = new google.visualization.BarChart(document.getElementById('avance'));//avance
   
   chartRap.draw(datar, optionsR);
   chartAv.draw(dataAv, optionsAv);
   chartAvance.draw(dataAvance, optionsAvance);
}

</script>
              <script>
              google.charts.setOnLoadCallback(drawRapport);
              </script>