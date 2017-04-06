
<%
	if(!request.getRequestURI().contains("/main.jsp")){
		%><script>document.location.replace("main.jsp?cible=stat");</script><%
		return;
	}
%>