
<%
	if(!request.getRequestURI().equals("/Boq/main.jsp")){
		%><script>document.location.replace("/Boq/main.jsp?cible=stat");</script><%
		return;
	}
%>