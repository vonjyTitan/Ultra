<!DOCTYPE html>
<%@page import="utilitaire.SessionUtil"%>
<%@page import="com.mapping.Utilisateur"%>
<%@page import="com.service.LoginService"%>
<%
String cible=SessionUtil.getValForAttr(request,"cible");
String currmenu=SessionUtil.getValForAttr(request,"cible");
String id=SessionUtil.getValForAttr(request,"id");
%>
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
    <script src="assets/js/chart-master/Chart.js"></script>
    <script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script   src="https://code.jquery.com/ui/1.11.3/jquery-ui.min.js"   integrity="sha256-xI/qyl9vpwWFOXz7+x/9WkG5j/SVnSw21viy8fWwbeE="   crossorigin="anonymous"></script>
<script src="assets/js/bootstrap-datepicker-1.6.4-dist/js/bootstrap-datepicker.min.js"></script>
    
    
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
            <!--logo start-->
            <a href="javascript:;" class="logo"><img src="assets/img/lxc_logo.png" class="" style="background-color: white;margin-top: -10px;" width="150"></a>
            
            <!--logo end-->
           
            <div class="nav notify-row" id="top_menu">
            <ul class="nav top-menu">
                    <!-- settings start -->
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
            
            </div>
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
     
      <!--sidebar end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      <section id="main-content" style="margin-left:0px !important;">
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
            $('.datepicker').datepicker({
        		format: 'dd/mm/yyyy'
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
        
        
            function select(id,libelle){ //var result = eval();
            	try {
           				window.opener.HandlePopupResult(id,libelle,'<%=SessionUtil.getValForAttr(request, "inputname")%>');
			        }
			        catch (err) {}
			        window.close();
			  }
    </script>
  
<style>
	.dropdown-menu{
		z-index:999999;
	}
</style>
  </body>
</html>
