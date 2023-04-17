<%-- 
    Document   : remove
    Created on : Nov 29, 2011, 6:07:56 PM
    Author     : Rishabh
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="session.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%
            int id=Integer.parseInt(request.getParameter("id"));
            int se=Integer.parseInt(request.getParameter("se"));
            Cart temp=(Cart)session.getAttribute("cart"+se);
            ArrayList al=temp.get();
            al.remove(id);
            
%>
<jsp:include page="display.jsp"><jsp:param name="se" value="<%=se%>"></jsp:param> </jsp:include>
    </body>
</html>
