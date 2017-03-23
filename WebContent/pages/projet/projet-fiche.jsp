<%@page import="utilitaire.ConstantEtat"%>
<%@page import="utilitaire.UtileAffichage"%>
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
	crit.setNomTable("projet_fiche");
	crit = DaoModele.getInstance().findById(crit, Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
	PageFiche builder=new PageFiche(crit,request);
	builder.setData(crit);
	builder.addNotVisibleChamp(new String[]{"idprojet","idclient","identreprise","etat","identreprise","retenue"});
	builder.setLienForAttr("client", "main.jsp?cible=Tiers/client-fiche", "id", "idclient");
	builder.setLienForAttr("entreprise", "main.jsp?cible=Tiers/entreprise-fiche", "id", "identreprise");
	List<Attachement> atts = FileService.getInstance().getAttachement("projet",Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
	String foldername = "projet_"+SessionUtil.getValForAttr(request, "id")+"/";
	String fileurl = ConfigUtil.getConfigBundle().getString("file.url");
	MatOnSite critmos=new MatOnSite();
	critmos.setNomTable("matonsite_libelle");
	critmos.setPackSize(100);
	critmos.setIdprojet(Integer.valueOf(SessionUtil.getValForAttr(request, "id")));
	List<MatOnSite> matonsites = DaoModele.getInstance().findPageGenerique(1, critmos);
	
%>
<h3><a href="main.jsp?cible=projet/projet-liste"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a> Project <%=crit.getLibelle() %> details</h3>
<%=HTMLBuilder.beginPanel("General information",5) %>
<div class="col-lg-12 " style="max-height:600px;overflow-y:auto;">
<div class="form-group col-lg-12"><p class="col-lg-6">Progression : </p><p class="col-lg-6"><%=(int)(100*crit.getTotal()/(crit.getTotalestimation()==null || crit.getTotalestimation()==0 ? 1 : crit.getTotalestimation())) %> %</p></div>
<%=builder.getBody()%>
<div class="form-group col-lg-12"><p class="col-lg-6">Less Retention : </p><p class="col-lg-6"><%=(crit.getRetenue()!=null ? crit.getRetenue().intValue() : 0) %> %</p></div>
</div>
<div class="form-group col-lg-12" style="text-align: right;">
		<a class="btn btn-success btn-xs" href="main.jsp?cible=projet/projet-stat&id=<%=((Projet)builder.getEntity()).getIdprojet()%>"> Statistical and summary </a>
		<a class="btn btn-primary btn-xs" href="main.jsp?cible=projet/projet-modif&id=<%=((Projet)builder.getEntity()).getIdprojet()%>"><i class="fa fa-pencil "></i> Update</a>
</div>
<%=HTMLBuilder.endPanel()%>
<%=HTMLBuilder.beginPanel("Engineers",7) %>
<% 
	Utilisateur critUtilisateur=new Utilisateur();
	critUtilisateur.setNomTable("ingenieurprojet_libelle");
	List<Utilisateur> UserResult=DaoModele.getInstance().findPageGenerique(1, critUtilisateur," and idprojet= " + SessionUtil.getValForAttr(request, "id"));
	%>
	<div class="col-lg-12" style="max-height:200px;overflow-y:auto;">
	 <table class="table table-striped table-advance table-hover table-bordered table-scrollable" >
                              <thead>
                              <tr>
                           		<th>Id</th>
                                <th>Last Name</th>
                                <th>First Name</th>
                                <th>Status</th>  
                                <th></th>                              
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
									<td>
									<%if(util.getEtat_ingenieur()==ConstantEtat.INGENIEUR_PROJET_ACTIVE){
										%>
										<span class="label label-primary label-mini">ACTIVE</span>
										<%
										} else{
										%>
											<span class="label label-success label-mini">NOT ACTIVE</span>
										<%
										}
										%>
									</td>
									<td style="text-align:left;"> 
										<%if(util.getEtat_ingenieur()==ConstantEtat.INGENIEUR_PROJET_ACTIVE){
										%>
										 <a class="btn btn-danger btn-xs" href="projet-deleteingenieur?idingenieur=<%=util.getIdingenieur()%>&idprojet=<%=SessionUtil.getValForAttr(request, "id") %>"><i class="fa fa-trash-o "></i></a>
										<%
										}else{
											%>
											<a class="btn btn-success btn-xs" href="projet-reactiveingenieur?idingenieur=<%=util.getIdingenieur()%>&idprojet=<%=SessionUtil.getValForAttr(request, "id") %>"><i class="fa fa-check"></i></a>
											<%
										}
										%>
									</td>
								</tr>
							<%
							}
							%>                    
                              </tbody>
                          </table>
                          </div>
                          <div class="form-group col-lg-12" style="text-align: right;">
                          <input id="idingenieur1_val" name="idingenieur" onchange="addInganieur();" type="hidden">
								<a class="btn btn-primary btn-xs" onclick="window.open('popup.jsp?cible=Pop-up/popup-ingenieur&amp;libtable=prenom&amp;inputname=idingenieur1', 'popupWindow','width=1200,height=800,scrollbars=yes');" style="margin-left: 4px;margin-top: 1px;" href="javascript:;"> Add Engineer</a>
								<script type="text/javascript">
									function addInganieur(){
										 document.location.href = "projet-ajoutingenieur?idprojet=<%=SessionUtil.getValForAttr(request, "id") %>&idingenieur="+$("#idingenieur1_val").val();
									}
								</script>
							</div>
							
<%=HTMLBuilder.endPanel()%>
<div class="col-lg-7 col-md-7 col-sm-7 mt">

<div id="exTab3" class="">	
<ul  class="nav nav-pills">
			<li class="active" id="tabindex"><a href="#2a" data-toggle="tab" >Certificat</a>
			</li>
			<li>
        <a  href="#1a" data-toggle="tab">Bills</a>
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
                                <th>Status</th>
                                <th>Estimated</th>
                                <th>Actual</th>
                                <th>Date of count</th>
                                <th></th>                              
                            </tr>
                            </thead>
                            <tbody>
                            <%
					for(Estimation estimation:EstimationResult){
					%>
						<tr>
							<td><%=UtileAffichage.formatAfficherDate(estimation.getMois()) %></td>
							<td><%=estimation.getEstimation() %></td>
							<td><%if(estimation.getEtat()==ConstantEtat.MOIS_CREATED){%><span class="label label-warning label-mini">Created</span><%}
							else if(estimation.getEtat()==ConstantEtat.MOIS_DECOMPTE){
								%>
								<span class="label label-primary label-mini">Discount in progress</span>
								<%
							}
							else{
								%>
								<span class="label label-success label-mini">Certified</span>
								<%
							}
							%></td>
							<td><%=estimation.getTotal() %></td>
							<td><%=estimation.getEstimation()%></td>
							<td><%=UtileAffichage.formatAfficherDate(estimation.getDatedecompte()) %></td>
							<td><a class="btn btn-primary btn-xs" href="main.jsp?cible=decompte/decompte-fiche&id=<%=estimation.getIdmoisprojet() %>">Details</a>
							<a class="btn btn-primary btn-xs" href="main.jsp?cible=decompte/decompte-modif&id=<%=estimation.getIdmoisprojet() %>"><i class="fa fa-pencil"></i></a></td>
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
								<a class="btn btn-primary btn-xs" href="main.jsp?cible=decompte/decompte-ajout&id=<%=SessionUtil.getValForAttr(request, "id")%>">Add estimate</a>
							</div>
		</div>
        <div class="tab-pane" id="3a">
          	<div class="row mt">
	  		<div class="col-lg-12 col-md-12 col-sm-12 table-responsive">
                    <div class="content-panel">                  
                        <section id="unseen">
                          <table class="table table-striped table-advance table-hover table-bordered" >
                            <thead>
                            <tr>
                                <th>Code</th>
                                <th>PU</th>  
                                <th>Debit</th>
                                <th>Credit</th>  
                                <th></th>                         
                            </tr>
                            </thead>
                            <tbody>
                            <%
                            for(MatOnSite mos : matonsites){
					%>
						<tr>
							<td><a href="main.jsp?cible=configuration/materiel-fiche&id=<%=mos.getIdmateriel()%>"><%=mos.getCode()%></a></td>
							<td><%=mos.getPu() %></td>
							<td><%=mos.getDebit() %></td>
							<td><%=mos.getCredit() %></td>
							<td><a class="btn btn-primary btn-xs" onclick="modifMos(<%=mos.getPu() %>,'<%=mos.getCode() %>',<%=mos.getIdmatonsite() %>)" href="javascript:;"><i class="fa fa-pencil "></i></a></td>
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
								<a class="btn btn-primary btn-xs" href="main.jsp?cible=projet/projet-ajoutmatonsite&id=<%=SessionUtil.getValForAttr(request, "id")%>"> Add Mat on site</a>
			</div>
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
        <%
        int pageActTrack = Integer.valueOf("0"+SessionUtil.getValForAttr(request, "PageTrack"));
        int lastPageTrack = pageActTrack;
        pageActTrack = pageActTrack==0 ? 1: pageActTrack;
        	ListPaginner<Historique> histo = (ListPaginner<Historique>)LogService.getInstance().getLog(pageActTrack,((Projet)builder.getEntity()).getIdprojet(), "projet");
        %>
        	<div class="row mt">
	  		<div class="col-lg-12 col-md-12 col-sm-12 table-responsive">
                    <div class="content-panel">                  
                        <section id="unseen">
                          <table class="table table-striped table-advance table-hover table-bordered" >
                            <thead>
                            <tr>
                                <th>User</th>
                                <th>Action</th> 
                                <th>Date of action</th>                               
                            </tr>
                            </thead>
                            <tbody> 
                            <%for(Historique hist:histo){ %>
                            	<tr>
                            		<td><%=hist.getPrenom() %></td>
                            		<td><%=hist.getAction() %></td>
                            		<td><%=UtileAffichage.formatAfficherDate(hist.getDatelog()) %></td>
                            	</tr>
                            <%} %>                 
                        	</tbody>
                    </table>
                    <div class="col-lg-3 pull-right">
                                <ul class="pagination">
                                    <li>
                                    <%
                                    
                                    	for(int i=1;i<=histo.nbPage;i++){
                                    		if(i==pageActTrack){
                                    %>
                                                    <a href="javascript:;" style="background: #0086de; color: white;"><%=i %></a>
                                                <%} else{%>
                                                <a href="main.jsp?cible=projet/projet-fiche&id=<%=critmos %>&PageTrack=<%=i%>"><%=i %></a>
									<%
                                                }
									} %>
                                    </li>
                                </ul>
                            </div>
                    </section>
                  </div><!-- /content-panel -->
               </div><!-- /col-lg-4 -->			
		  	</div><!-- /row -->							
							
          </div>
	</div>
</div>

</div>
  <div class="modal fade" id="modif" style="margin-top:100px;margin-left:100px;">
	<div class="modal-dialog">
	<form action="projet-modifmatonsite" id="form-annulation" method="post">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" style="color: white;" aria-label="Close" data-dismiss="modal" type="button">
                    <span aria-hidden="true">x</span>
                </button>
                <h4>Update Mat on site</h4>
            </div>
            <div class="modal-body">
            	<input type="hidden" name="idmatonsite" id="idmatonsite"/>
            	<div id="codecontainer" class="form-group col-lg-12" style="margin-top:30px;"><div class="col-sm-4 col-sm-4 "><label class="control-label" for="">Code Material : </label></div><div class="col-sm-7"><input name="codemateriel" id="codemateriel" class="form-control" disabled="true" value="" type="text"></div></div>
                <div id="codecontainer" class="form-group col-lg-12"><div class="col-sm-4 col-sm-4 "><label class="control-label" for="pu">PU : </label></div><div class="col-sm-7"><input name="pu" id="pu" class="form-control" value="" type="text"></div></div>
            </div>
            
            <div class="modal-footer">
                <div class="col-lg-12">
                <input type="submit" class="btn btn-primary btn-xs" name="confirme"  value="Valide"/>
			<a class="btn btn-warning btn-xs closes"  href="javascript:;">Cancel</a>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>
 <script>
  	$(document).ready(function(){
  		window.setTimeout(function(){
  			<%if(lastPageTrack==0){%>
  				$("#tabindex > a").trigger("click");
  		<%}
  		else{
  			%>
  			$("#tablog > a").trigger("click");
  			<%
  		}%>
  		},500);
  		$(".closes").on("click",function(){
  			$(this).parents(".modal").prop("class","modal fade");
  		});
  		$(".close").on("click",function(){
  			$(this).parents(".modal").prop("class","modal fade");
  		});
  	});
  	function modifMos(pu,codemateriel,idmatonsite){
  		$("#pu").prop("value",pu);
  		$("#idmatonsite").prop("value",idmatonsite);
  		$("#codemateriel").prop( "value",codemateriel);
  		$("#modif").prop("class","modal show");
  	}
  </script>