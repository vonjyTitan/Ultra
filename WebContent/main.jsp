<!DOCTYPE html>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="com.mapping.Utilisateur"%>
<%@page import="com.service.LoginService"%>
<% 
	String cible=SessionUtil.getValForAttr(request,"cible");
	String currmenu=SessionUtil.getValForAttr(request,"cible");
	String id=SessionUtil.getValForAttr(request,"id");
	try{
      	SessionUtil.isExisteSession(request);
      }
      catch(Exception ex)
      {
    	  %><script>document.location.replace("login.jsp?error=<%=ex.getMessage()%>&cible=<%=cible%>&currmenu=<%=currmenu%>&id=<%=id%>");</script><%
      		return ;
      }
try{
	if(cible.split("/").length>1 && !LoginService.getInstance().isAllowed((Utilisateur) request.getSession().getAttribute("utilisateur"),cible.split("/")[1])){
  		throw new Exception("You do not have permission for this page");
  	}
  }
  catch(Exception ex)
  {
	  ex.printStackTrace();
	  %><script language="JavaScript">
	  alert("<%=ex.getMessage()%>");
         history.back();</script><%
  		return ;
  }
%>
<%try{%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">

    <title>Boq admin</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="assets/css/zabuto_calendar.css">
    <link rel="stylesheet" type="text/css" href="assets/js/gritter/css/jquery.gritter.css" />
    <link rel="stylesheet" type="text/css" href="assets/lineicons/style.css">    
    
    <!-- Custom styles for this template -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">

    <script src="assets/js/chart-master/Chart.js"></script>
    
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      <header class="header black-bg">
              <div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
              </div>
            <!--logo start-->
            <a href="main.jsp?cible=stat" class="logo"><img src="assets/img/lxc_logo.png" class="" style="background-color: white;margin-top: -10px;" width="150"></a>
            
            <!--logo end-->
           
            <div class="nav notify-row" id="top_menu">
            <ul class="nav top-menu">
                    <!-- settings start -->
                    <li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                            <i class="fa fa-tasks"></i>
                            <span class="badge bg-theme">4</span>
                        </a>
                        <ul class="dropdown-menu extended tasks-bar">
                            <div class="notify-arrow notify-arrow-green"></div>
                            <li>
                                <p class="green">You have 4 Projects in Progress</p>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <div class="task-info">
                                        <div class="desc">Project FLIC EN FLAC</div>
                                        <div class="percent">40%</div>
                                    </div>
                                    <div class="progress progress-striped">
                                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                            <span class="sr-only">40% Complete (success)</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <div class="task-info">
                                        <div class="desc">Project 2</div>
                                        <div class="percent">60%</div>
                                    </div>
                                    <div class="progress progress-striped">
                                        <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                            <span class="sr-only">60% Complete (warning)</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <div class="task-info">
                                        <div class="desc">Project 3</div>
                                        <div class="percent">80%</div>
                                    </div>
                                    <div class="progress progress-striped">
                                        <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                            <span class="sr-only">80% Complete</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <div class="task-info">
                                        <div class="desc">Project 4</div>
                                        <div class="percent">70%</div>
                                    </div>
                                    <div class="progress progress-striped">
                                        <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 70%">
                                            <span class="sr-only">70% Complete (Important)</span>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="external">
                                <a href="#">See All Projects</a>
                            </li>
                        </ul>
                    </li>
                    <!-- settings end -->
                    <!-- inbox dropdown start-->
                    <!-- <li id="header_inbox_bar" class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="index.html#">
                            <i class="fa fa-envelope-o"></i>
                            <span class="badge bg-theme">5</span>
                        </a>
                        <ul class="dropdown-menu extended inbox">
                            <div class="notify-arrow notify-arrow-green"></div>
                            <li>
                                <p class="green">You have 5 new messages</p>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <span class="photo"><img alt="avatar" src="assets/img/ui-zac.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Zac Snider</span>
                                    <span class="time">Just now</span>
                                    </span>
                                    <span class="message">
                                        Hi mate, how is everything?
                                    </span>
                                </a>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <span class="photo"><img alt="avatar" src="assets/img/ui-divya.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Divya Manian</span>
                                    <span class="time">40 mins.</span>
                                    </span>
                                    <span class="message">
                                     Hi, I need your help with this.
                                    </span>
                                </a>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <span class="photo"><img alt="avatar" src="assets/img/ui-danro.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Dan Rogers</span>
                                    <span class="time">2 hrs.</span>
                                    </span>
                                    <span class="message">
                                        Love your new Dashboard.
                                    </span>
                                </a>
                            </li>
                            <li>
                                <a href="index.html#">
                                    <span class="photo"><img alt="avatar" src="assets/img/ui-sherman.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Dj Sherman</span>
                                    <span class="time">4 hrs.</span>
                                    </span>
                                    <span class="message">
                                        Please, answer asap.
                                    </span>
                                </a>
                            </li>
                            <li>
                                <a href="index.html#">See all messages</a>
                            </li>
                        </ul>
                    </li>-->
                    <!-- inbox dropdown end -->
                </ul>
                <!--  notification end -->
          
            </div>
            
            <div class="top-menu">
            
            	<ul class="nav pull-right top-menu">
                    <li><a class="logout" href="login.jsp">Deconnexion</a></li>
            	</ul>
            </div>
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <ul class="sidebar-menu" id="nav-accordion">
              
              	   <!-- <p class="centered"><a href="profile.html"><img src="assets/img/lxc_logo.png" class="img-circle" width="60"></a></p>-->
              	  <h5 class="centered"><%=((Utilisateur)request.getSession().getAttribute("utilisateur")).getNom()%></h5>
                  <!-- <form action="" class="search-form">
                <div class="form-group has-feedback">
            		<label for="search" class="sr-only">Search</label>
            		<input type="text" class="form-control" name="search" id="search" placeholder="search">
              		<span class="glyphicon glyphicon-search form-control-feedback"></span>
            	</div>
            </form>-->
                  <li class="mt">
                      <a class="active" id="menu-ecceuil" href="main.jsp?cible=stat&currmenu=menu-ecceuil" >
                          <i class="fa fa-dashboard"></i>
                          <span>Dashboard</span>
                      </a>
                  </li>
				<li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-table"></i>
                          <span>Manage Project</span>
                      </a>
                      <ul class="sub">
                          <!--  <li><a  href="#" id="menu-liste-table"><i class="fa fa-archive"></i>Summary</a></li>-->
                          <li><a  href="main.jsp?cible=projet/projet-liste" id="projet-liste"><i class="fa fa-list"></i>List Project</a></li>
                          <li><a  href="main.jsp?cible=projet/projet-ajout" id="projet-ajout"><i class="fa fa-plus"></i>Add New Project</a></li>
                      </ul>
                </li>
                <!-- <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-tasks"></i>
                          <span>Gestion Bill</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="#" id="menu-ajout-table"><i class="fa fa-list"></i>Liste Bill</a></li>
                          <li><a  href="#" id="menu-ajout-table"><i class="fa fa-plus"></i>Ajout Nouveau Bill</a></li>
                      </ul>
                </li>-->
				<li class="sub-menu">
					<a href="javascript:;" >
                          <i class="fa fa-cube"></i>
                          <span>Third Party</span>
                      </a>
                      <ul class="sub">
                      <li class="sub-menu">
                      	<a  href="main.jsp?cible=commande/commande-ajout&currmenu=menu-commmande-ajout" id="menu-commmande-ajout"><i class="fa fa-cubes"></i>Customer</a>
                      	<ul class="sub">
                      		<li><a href="main.jsp?cible=Tiers/client-liste" id="client-liste"><i class="fa fa-list"></i>List Customer</a></li>               
                      		<li><a href="main.jsp?cible=Tiers/client-ajout" id="client-ajout"><i class="fa fa-plus"></i>Add New Customer</a></li>
               			</ul>
                      </li>
                      	
                      <li class="sub-menu">
                      	<a  href="main.jsp?cible=commande/commande-liste&currmenu=menu-commande-liste" id="menu-commande-liste"><i class="fa fa-university"></i>Company</a>
                      	<ul class="sub">
                      		<li><a href="main.jsp?cible=Tiers/entreprise-liste" id="entreprise-liste"></i>List Company</a></li>
               			
                      		<li><a href="main.jsp?cible=Tiers/entreprise-ajout" id="entreprise-ajout"></i>Add New Company</a></li>
               			</ul>
                      </li>
                  </ul>
                  </li>
                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-users"></i>
                          <span>Manage Engineer</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="main.jsp?cible=configuration/ingenieur-liste" id="ingenieur-liste"><i class="fa fa-list"></i>List of Engineer</a></li>
                          <li><a  href="main.jsp?cible=configuration/ingenieur-ajout" id="ingenieur-ajout"><i class="fa fa-plus"></i>Add New Engineer</a></li>
                      </ul>
                </li>
                   <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-users"></i>
                          <span>Manage User</span>
                      </a>
                      <ul class="sub">
                      
                      <li class="sub-menu">
			                      <a href="javascript:;" >
			                          <i class="fa fa-users"></i>
			                          <span>User</span>
			                      </a>
			                      <ul class="sub">
			                      <li><a  href="main.jsp?cible=configuration/utilisateur-liste" id="utilisateur-liste"><i class="fa fa-list"></i>List User</a></li>
                          			<li><a  href="main.jsp?cible=configuration/utilisateur-ajout" id="utilisateur-ajout"><i class="fa fa-plus"></i>Add New User</a></li>
			                      </ul>
	                      </li>
	                      
	                       <li class="sub-menu">
			                      <a href="javascript:;" >
			                          <i class="fa fa-check-circle"></i>
			                          <span>User Type</span>
			                      </a>
			                      <ul class="sub">
			                      <li><a  href="main.jsp?cible=configuration/role-liste" id="role-liste"><i class="fa fa-list"></i>List User Type</a></li>
                          			<li><a  href="main.jsp?cible=configuration/role-ajout" id="role-ajout"><i class="fa fa-plus"></i>Add New User Type</a></li>
			                      </ul>
	                      </li>
	                      
                      </ul>
                  </li>
                   <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-cog"></i>
                          <span>Settings</span>
                      </a>
                      <ul class="sub">
                       	<li class="sub-menu">
                       		<a  href="#" id="menu-ajout-table"><i class="fa fa-cubes"></i>Item</a>
	                       	<ul class="sub">
	                      		<li><a  href="main.jsp?cible=configuration/item-liste" id="item-liste"><i class="fa fa-list"></i>List Item</a></li>
	                      		<li><a  href="main.jsp?cible=configuration/item-ajout" id="item-ajout"><i class="fa fa-plus"></i>Add New Item</a></li>
	               			</ul>
                       	</li>
                      	<li class="sub-menu">
                      		<a  href="#" id="menu-ajout-table"><i class="fa fa-magnet"></i>Material</a>
	                      	<ul class="sub">
	                      		<li><a  href="main.jsp?cible=configuration/materiel-liste" id="materiel-liste"><i class="fa fa-list"></i>List Material</a></li>
	               			
	                      		<li><a  href="main.jsp?cible=configuration/materiel-ajout" id="materiel-ajout"><i class="fa fa-plus"></i>Add New Material</a></li>
	               			</ul>
                      	</li>
                   	  	<li class="sub-menu">
                   	  		<a  href="#" id="menu-ajout-table"><i class="fa fa-cogs"></i>Unit</a>
	                   	  	<ul class="sub">
	                      		<li><a  href="main.jsp?cible=configuration/unite-liste" id="unite-liste"><i class="fa fa-list"></i>List Unit</a></li>
	               			
	                      		<li><a  href="main.jsp?cible=configuration/unite-ajout" id="unite-ajout"><i class="fa fa-plus"></i>Add New Unit</a></li>
	               			</ul>
                   	  	</li>
                      </ul>
                  </li>
                  
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
          <%
          		cible="pages/"+cible+".jsp";
          		try{
          		%>
          		<jsp:include page='<%=cible%>'/>
                <% 
                }
          		catch (Exception e) {
          			e.printStackTrace();
          			%>
                    <script language="JavaScript"> alert('<%=e.getMessage().toUpperCase() %>');
                        history.back();</script>
                    <%
                }
          %>
          </section>
      </section>

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <div class="text-center">
              BOQ
              <a href="#" class="go-top">
                  <i class="fa fa-angle-up"></i>
              </a>
          </div>
      </footer>
      <!--footer end-->
  </section>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/jquery-1.8.3.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="assets/js/jquery.scrollTo.min.js"></script>
    <script src="assets/js/jquery.nicescroll.js" type="text/javascript"></script>
    <script src="assets/js/jquery.sparkline.js"></script>


    <!--common script for all pages-->
    <script src="assets/js/common-scripts.js"></script>
    
    <script type="text/javascript" src="assets/js/gritter/js/jquery.gritter.js"></script>
    <script type="text/javascript" src="assets/js/gritter-conf.js"></script>

    <!--script for this page-->
    <script src="assets/js/sparkline-chart.js"></script>    
	<script src="assets/js/zabuto_calendar.js"></script>	
	
	
	<script type="application/javascript">
        $(document).ready(function () {
            $("#date-popover").popover({html: true, trigger: "manual"});
            $("#date-popover").hide();
            $("#date-popover").click(function (e) {
                $(this).hide();
            });
        
            $("#my-calendar").zabuto_calendar({
                action: function () {
                    return myDateFunction(this.id, false);
                },
                action_nav: function () {
                    return myNavFunction(this.id);
                },
                ajax: {
                    url: "show_data.php?action=1",
                    modal: true
                },
                legend: [
                    {type: "text", label: "Special event", badge: "00"},
                    {type: "block", label: "Regular event", }
                ]
            });
        });
        
        
        function myNavFunction(id) {
            $("#date-popover").hide();
            var nav = $("#" + id).data("navigation");
            var to = $("#" + id).data("to");
            console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
        }
        var defaults = {
    			classParent	 : 'dcjq-parent',
    			classActive	 : 'active',
    			classArrow	 : 'dcjq-icon',
    			classCount	 : 'dcjq-count',
    			classExpand	 : 'dcjq-current-parent',
    			eventType	 : 'click',
    			hoverDelay	 : 300,
    			menuClose     : true,
    			autoClose    : true,
    			autoExpand	 : false,
    			speed        : 'slow',
    			saveState	 : true,
    			disableLink	 : true,
    			showCount : false,
//    			cookie	: 'dcjq-accordion'
    		};
        var obj = this;
        function autoCloseAccordion($parentsLi, $parentsUl){
			$('ul',obj).not($parentsUl).slideUp(defaults.speed);
			// Reset active links
			$('a',obj).removeClass(defaults.classActive);
			$('> a',$parentsLi).addClass(defaults.classActive);
			$('> ul',$parentsLi).slideToggle(defaults.speed);
		}
        $(document).ready(function () {
        	$(".active").removeClass("active");
        	<%if(currmenu!=null && currmenu.compareToIgnoreCase("null")!=0){%>
        	active($("#<%=currmenu.split("/")[1]%>"));
        	<%}%>
        });
        function active(dom)
        {
        	$activeLi = dom.parent('li');
			$parentsLi = $activeLi.parents('li');
			$parentsUl = $activeLi.parents('ul');

			// Prevent browsing to link if has child links
			if(defaults.disableLink == true){
				if(dom.siblings('ul').length >0){
					e.preventDefault();
				}
			}

			// Auto close sibling menus
			if(defaults.autoClose == true){
				autoCloseAccordion($parentsLi, $parentsUl);
			}

			if ($('> ul',$activeLi).is(':visible')){
				$('ul',$activeLi).slideUp(defaults.speed);
				$('a',$activeLi).removeClass(defaults.classActive);
			} else {
				$(dom).siblings('ul').slideToggle(defaults.speed);
				$('> a',$activeLi).addClass(defaults.classActive);
			}
        	
        }
        function HandlePopupResult(id,libelle,inputname){
        	$("[name='"+inputname+"']").prop("value",id);
        	$("#"+inputname+"_lib").prop("value",libelle);
        }
    </script>
  

  </body>
</html>

<%}
catch(Exception ex){
	ex.printStackTrace();
	%>
	<script>alert('<%=ex.getMessage()%>');</script>
	<%
}
%>
