<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%@page import="java.util.Map"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Projet crit=new Projet();
	crit.setNomTable("projet_libelle");
	PageFiche builder=new PageFiche(crit,request);
	builder.addNotVisibleChamp(new String[]{"idprojet","idclient","identreprise","etat"});
	builder.removeChamp("identreprise");
%>
<h3><a href="main.jsp?cible=Tiers/client-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Customer details</h3>
<%=HTMLBuilder.beginPanel("General information",6) %>
<%=builder.getBody()%>
<div class="form-group col-lg-12" style="text-align: right;">
		<a class="btn btn-primary btn-xs" href="main.jsp?cible=projet/projet-modif&id=<%=((Projet)builder.getEntity()).getIdprojet()%>"><i class="fa fa-pencil "></i> Update</a>
</div>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Engineers",6) %>
<% Utilisateur critIngenieur=new Utilisateur();
	critIngenieur.setNomTable("ingenieur_libelle");
	TableBuilder builderIngenieur=new TableBuilder(critIngenieur,request);
	builderIngenieur.addNotVisibleChamp(new String[]{"idutilisateur","idrole","passe","etat","login","isingenieur","options"});
	%>
<%=builderIngenieur.getHTML()%>
<%=HTMLBuilder.endPanel()%>
<div class="col-lg-6 col-md-6 col-sm-6 mt">

<div id="exTab3" class="">	
<ul  class="nav nav-pills">
			<li class="active" id="tabindex">
        <a  href="#1a" data-toggle="tab">Bills</a>
			</li>
			<li><a href="#2a" data-toggle="tab">Estimate and Count</a>
			</li>
			<li><a href="#3a" data-toggle="tab">Material on site</a>
			</li>
			<li><a href="#4a" data-toggle="tab">Log</a>
			</li>
		</ul>

			<div class="tab-content clearfix">
			  <div class="tab-pane active" id="1a">
		          <div class="row mt">
		          	<% 
					Bill critBill=new Bill();
					critBill.setNomTable("bill_libelle");
					List<Bill> billResult=DaoModele.getInstance().findPageGenerique(1, critBill," and idprojet= " + SessionUtil.getValForAttr(request, "id"));
					%>
			  		<div class="col-lg-12">
                      <div class="content-panel">                  
                          <section id="unseen">
                            <table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
                              <thead>
                              <tr>
                                  <th>Code</th>
                                  <th>Bill</th>                                
                              </tr>
                              </thead>
                              <tbody>
                              <%
							for(Bill bill:billResult){
							%>
								<tr>
									<td><a href="main.jsp?cible=Bill/bill-modif&id=<%=bill.getIdbill()%>"><%=bill.getCode() %></a></td>
									<td><%=bill.getLibelle() %></td>
									
								</tr>
							<%
							}
							%>                    
                              </tbody>
                          </table>
                          </section>
                  </div><!-- /content-panel -->
               </div><!-- /col-lg-4 -->			
		  	</div><!-- /row -->
		</div>
		<div class="tab-pane" id="2a">
          <div class="row mt">
          	<% 
			Estimation critEstimation=new Estimation();
			List<Estimation> EstimationResult=DaoModele.getInstance().findPageGenerique(1, critEstimation," and idprojet= " + SessionUtil.getValForAttr(request, "id"));
			%>
	  		<div class="col-lg-12 col-md-12 col-sm-12 table-responsive">
                    <div class="content-panel">                  
                        <section id="unseen">
                          <table class="table table-striped table-advance table-hover table-bordered" >
                            <thead>
                            <tr>
                                <th>Month</th>
                                <th>Amount</th>                                
                            </tr>
                            </thead>
                            <tbody>
                            <%
					for(Estimation estimation:EstimationResult){
					%>
						<tr>
							<td><%=estimation.getMois() %></td>
							<td><%=estimation.getEstimation() %></td>
							
						</tr>
					<%
					}
					%>                    
                        </tbody>
                    </table>
                    </section>
                  </div><!-- /content-panel -->
               </div><!-- /col-lg-4 -->			
		  	</div><!-- /row -->
		</div>
        <div class="tab-pane" id="3a">
          <h3>We applied clearfix to the tab-content to rid of the gap between the tab and the content</h3>
		</div>
        <div class="tab-pane" id="4a">
          <h3>We use css to change the background color of the content to be equal to the tab</h3>
		</div>
	</div>
</div>

</div>
  
  <script>
  	$(document).ready(function(){
  		$("#tabindex > a").trigger("click");
  		});
  </script>