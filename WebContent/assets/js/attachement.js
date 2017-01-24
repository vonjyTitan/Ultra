function attachement(container,inputname){
	var scriptTab="<table class=\"col-lg-12\">" +
			"<thead><tr><th></th><th></th></tr></thead>"
	+"<tbody id=\"filecontainer\">"
	+"<tr><td><input type=\"file\" name=\""+inputname+"\"></td><td></td></tr>"
	+"</tbody>"
	+"</table>" ;
		var	scriptBut="<div class=\"col-lg-12\" style=\"text-align:center; margin-top: 10px;\">"
			+"<a href=\"javascript:;\" id=\"addfile\" class=\"btn btn-primary btn-xs\" style=\"width:150px;\"><i class=\"fa fa-plus\"></i></a>"+
			"</div>";
	$(container).append(scriptTab);
	$(container).append(scriptBut);
	$("#addfile").on("click",function(){
		var newInput="<tr><td><input type=\"file\" name=\""+inputname+"\"></td>" +
				"<td><a href=\"javascript:;\" name=\"suppr\" class=\"suppr btn btn-danger btn-xs\"><i class=\"fa fa-trash-o\"></i></a></td></tr>";
		$("#filecontainer").append(newInput);
		$("[name='suppr']").on("click",function(){
			$(this).parent("td").parent("tr").remove();
		});
	});
}