<%@page import="utilitaire.SessionUtil"%>
<%@page import="dao.DaoModele"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.affichage.InsertUpdateBuilder.ERROR_SHOW"%>
<%@page import="com.affichage.*"%>
<%@page import="com.mapping.*"%>
<jsp:include page='../verificateur.jsp'/>
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/attachement.js"></script>
<h3><a href="javascript:;" onclick="history.back();"><i class="fa fa-angle-left"></i><i class="fa fa-angle-left"></i></a>Add Attachments</h3>
<form action="attachement-ajout" method="POST" class="form-horizontal style-form" enctype="multipart/form-data">
<%=HTMLBuilder.beginPanel("News files", 6) %>
<input type="hidden" name="tb" value="<%=SessionUtil.getValForAttr(request, "tb")%>"/>
<input type="hidden" name="id" value="<%=SessionUtil.getValForAttr(request, "id")%>"/>
<input type="hidden" name="cb" value="<%=SessionUtil.getValForAttr(request, "cb")%>"/>
<div class="form-group col-lg-12" id="attachement">
</div>
<div class="form-group col-lg-12">
<label class="control-label col-lg-4"></label>
<div class="col-lg-8"> 
<input class="btn btn-primary" value="Submit" type="submit"> 
<input class="btn btn-danger" value="Cancel" type="reset" onclick="history.back();">
</div>
</div>
<%=HTMLBuilder.endPanel() %>
</form>
<script>
$(document).ready(function(){
	attachement($("#attachement"),"file");
});
</script>