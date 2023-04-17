<%-- 
    Document   : remove
    Created on : Nov 29, 2011, 6:07:56 PM
    Author     : Rishabh
--%>

<%@page import="session.Cart_1"%>
<%@page import="java.util.ArrayList"%>

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
            String mode=request.getParameter("mode");
            Cart_1 temp=(Cart_1)session.getAttribute("ordercart");
            //ArrayList al=temp.get();
            
                if(mode.equals("single")){
                temp.remove(id);
                }else{
                session.removeAttribute("ordercart");
                }
            
            if(temp.get().isEmpty()){
            session.removeAttribute("ordercart");
            out.print("Removed all products.");
            }
            
%>
<jsp:include page="displaycart.jsp"></jsp:include>
    </body>
</html>
