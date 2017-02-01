<%@page import="javax.xml.crypto.Data"%>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<%@page import="com.service.*"%>
<%@page import="utilitaire.ConfigUtil"%>
<%@page import="java.util.Map"%>
<jsp:include page='../verificateur.jsp'/>
<%
	Projet crit=new Projet();
	crit.setNomTable("projet_libelle");
	PageFiche builder=new PageFiche(crit,request);
	builder.addNotVisibleChamp(new String[]{"idprojet","idclient","identreprise","etat","identreprise"});
	builder.setLienForAttr("client", "main.jsp?cible=Tiers/client-fiche", "id", "idclient");
	builder.setLienForAttr("entreprise", "main.jsp?cible=Tiers/entreprise-fiche", "id", "identreprise");
	List<Attachement> atts = FileService.getInstance().getAttachement("projet",Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
	String foldername = "projet_"+SessionUtil.getValForAttr(request, "id")+"/";
	String fileurl = ConfigUtil.getConfigBundle().getString("file.url")+"/projet_"+SessionUtil.getValForAttr(request, "id");
	
%>
<h3><a href="main.jsp?cible=projet/projet-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Project details</h3>
<%=HTMLBuilder.beginPanel("General information",6) %>
<%=builder.getBody()%>
<div class="form-group col-lg-12" style="text-align: right;">
		<a class="btn btn-primary btn-xs" href="main.jsp?cible=projet/projet-modif&id=<%=((Projet)builder.getEntity()).getIdprojet()%>"><i class="fa fa-pencil "></i> Update</a>
</div>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Engineers",6) %>
<% 
	Utilisateur critUtilisateur=new Utilisateur();
	critUtilisateur.setNomTable("ingenieurprojet_libelle");
	List<Utilisateur> UserResult=DaoModele.getInstance().findPageGenerique(1, critUtilisateur," and idprojet= " + SessionUtil.getValForAttr(request, "id"));
	%>
	 <table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
                              <thead>
                              <tr>
                           		<th>Id</th>
                                <th>Last Name</th>
                                <th>First Name</th>                                
                              </tr>
                              </thead>
                              <tbody>
                              <%
							for(Utilisateur util:UserResult){
							%>
								<tr>
									<td><a href="main.jsp?cible=configuration/ingenieur-fiche&id=<%=util.getIdingenieur()%>"><%=util.getIdingenieur() %></a></td>
									<td><%=util.getNom() %></a></td>
									<td><%=util.getPrenom()%></td>
									
								</tr>
							<%
							}
							%>                    
                              </tbody>
                          </table>
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
			<li><a href="#5a" data-toggle="tab">Attached file</a>
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
									<td><a href="main.jsp?cible=Bill/bill-fiche&id=<%=bill.getIdbill()%>"><%=bill.getCode() %></a></td>
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
		  	<div class="form-group col-lg-12" style="text-align: right;">
								<a class="btn btn-primary btn-xs" href="main.jsp?cible=Bill/bill-ajout&id=<%=SessionUtil.getValForAttr(request, "id")%>"> Add bill</a>
							</div>
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
		<div class="tab-pane" id="5a">
           <div class="row mt">
	  		<div class="col-lg-12 col-md-12 col-sm-12 table-responsive">
                    <div class="content-panel">                  
                        <section id="unseen">
                          <table class="table table-striped table-advance table-hover table-bordered" >
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th></th>                                
                            </tr>
                            </thead>
                            <tbody>
                            <%
                            for(Attachement att : atts){
					%>
						<tr>
							<td><a href="<%=fileurl+"/"+att.getCible() %>" target="_blank"><%=att.getCible().replace(foldername, "") %></a></td>
							<td></td>
							
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
		  	<div class="col-lg-12" style="text-align: right;">
								<a class="btn btn-primary btn-xs" href="main.jsp?cible=Attachement/attachement-add&tb=projet&id=<%=SessionUtil.getValForAttr(request, "id")%>&cb=projet/projet-fiche&id=<%=SessionUtil.getValForAttr(request, "id")%>"> Add file</a>
							</div>
		</div>
        <div class="tab-pane" id="4a">
          <h3>We use css to change the background color of the content to be equal to the tab</h3>
		</div>
	</div>
</div>

</div>
  
 <script>
  	$(document).ready(function(){
  		window.setTimeout(function(){
  		$("#tabindex > a").trigger("click");
  		});},500);
  </script>