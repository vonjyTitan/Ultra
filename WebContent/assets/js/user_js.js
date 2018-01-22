$(function($) {
	loadAccess($("#user-type").val());
	$("#user-type").on("change",function(){
		loadAccess($(this).val());
	});
}); 
function loadAccess(idusertype){
	$.get( "role-getfonctionnalite?id="+idusertype, function( data ) {
			var target = $("#access-container");
			target.empty();
			$.each(data, function(index,value ) {
	            target.append("<tr><td>"+value.idfonctionnalite+"</td><td>"+value.fonctionnalite+"</td></tr>");
	        });
		});
}