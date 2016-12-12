<!DOCTYPE html>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="com.mapping.Utilisateur"%>
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
  	//SessionUtil.testAcces(request);
  }
  catch(Exception ex)
  {
	  %><script language="JavaScript">
	  alert("Vous n'avez pas acces a cette page!");
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
                  <li class="mt">
                      <a class="active" id="menu-ecceuil" href="main.jsp?cible=stat&currmenu=menu-ecceuil" >
                          <i class="fa fa-dashboard"></i>
                          <span>Tableau de bord</span>
                      </a>
                  </li>
				<li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-table"></i>
                          <span>Gestion projet</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="#" id="menu-liste-table"><i class="fa fa-archive"></i>Résumé</a></li>
                          <li><a  href="#" id="menu-ajout-table"><i class="fa fa-list"></i>Liste Projet</a></li>
                          <li><a  href="#" id="menu-ajout-table"><i class="fa fa-plus"></i>Ajout Nouveau Projet</a></li>
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
                          <span>Gestion tiers</span>
                      </a>
                      <ul class="sub-menu">
                      <li>
                      	<a  href="main.jsp?cible=commande/commande-ajout&currmenu=menu-commmande-ajout" id="menu-commmande-ajout"><i class="fa fa-cubes"></i>Client</a>
                      	<ul class="sub-sub-item">
                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-list"></i>Liste Client</a></li>
               			</ul>
                      	<ul class="sub-sub-item">
                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-plus"></i>Ajout Nouveau Client</a></li>
               			</ul>
                      </li>
                      	
                      <li>
                      	<a  href="main.jsp?cible=commande/commande-liste&currmenu=menu-commande-liste" id="menu-commande-liste"><i class="fa fa-university"></i>Entreprise</a>
                      	<ul class="sub-sub-item">
                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-list"></i>Liste Entreprise</a></li>
               			</ul>
                      	<ul class="sub-sub-item">
                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-plus"></i>Ajout Nouvelle Entreprise</a></li>
               			</ul>
                      </li>
                  </ul>
                  </li>
                   <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-users"></i>
                          <span>Gestion utilisateur</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="main.jsp?cible=configuration/utilisateur-liste" id="utilisateur-liste"><i class="fa fa-list"></i>List Utilisateur</a></li>
                          <li><a  href="main.jsp?cible=configuration/utilisateur-ajout" id="utilisateur-ajout"><i class="fa fa-plus"></i>Ajout Nouvel Utilisateur</a></li>
                      </ul>
                  </li>
                   <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-cog"></i>
                          <span>Configuration</span>
                      </a>
                      <ul class="sub">
                       	<li>
                       		<a  href="#" id="menu-ajout-table"><i class="fa fa-cubes"></i>Item</a>
	                       	<ul class="sub-sub-item">
	                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-list"></i>Liste Item</a></li>
	               			</ul>
	                      	<ul class="sub-sub-item">
	                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-plus"></i>Ajout Nouveau Item</a></li>
	               			</ul>
                       	</li>
                      	<li>
                      		<a  href="#" id="menu-ajout-table"><i class="fa fa-magnet"></i>Matériel</a>
	                      	<ul class="sub-sub-item">
	                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-list"></i>Liste Matériel</a></li>
	               			</ul>
	                      	<ul class="sub-sub-item">
	                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-plus"></i>Ajout Nouveau Matériel</a></li>
	               			</ul>
                      	</li>
                   	  	<li>
                   	  		<a  href="#" id="menu-ajout-table"><i class="fa fa-cogs"></i>Unité</a>
	                   	  	<ul class="sub-sub-item">
	                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-list"></i>Liste Unité</a></li>
	               			</ul>
	                      	<ul class="sub-sub-item">
	                      		<li><a  href="#" id="menu-liste-table"><i class="fa fa-plus"></i>Ajout Nouvelle Unité</a></li>
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
	
	<script type="text/javascript">
       /* $(document).ready(function () {
        var unique_id = $.gritter.add({
            // (string | mandatory) the heading of the notification
            title: 'Notification',
            // (string | mandatory) the text inside the notification
            text: 'Hover me to enable the Close Button. You can hide the left sidebar clicking on the button next to the logo. Free version for <a href="http://blacktie.co" target="_blank" style="color:#ffd777">BlackTie.co</a>.',
            // (string | optional) the image to display on the left
            image: 'assets/img/ui-sam.jpg',
            // (bool | optional) if you want it to fade out on its own or just sit there
            sticky: true,
            // (int | optional) the time you want it to be alive for before fading out
            time: '',
            // (string | optional) the class name you want to apply to that specific message
            class_name: 'my-sticky-class'
        });

        return false;
        });*/
	</script>
	
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
