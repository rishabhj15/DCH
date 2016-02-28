<%-- 
    Document   : test1
    Created on : Nov 29, 2011, 5:36:58 PM
    Author     : Rishabh
--%>

<%@page import="session.Item"%>
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
        
// Item I=new Item("Jain","1","test","10","10",null, null, null);
        Item I=new Item();
            Cart temp=(Cart)session.getAttribute("cart");
            if(temp==null){
            Cart c =new Cart(I);
            session.setAttribute("cart", c);
            out.println("new Session Object");
            }else{
            temp.add(I);
            out.println("oldSession Object");
            }
            Cart newCart=(Cart)session.getAttribute("cart");
            ArrayList al=newCart.get();
            int i=al.size();
            for(int j=0;j<i;j++){
            Item m=(Item)al.get(j);
            out.print(m.getLi());
            out.print(m.getSE());
            out.print(m.getNB());
            out.print(m.getB());
            out.print(m.getL());
            }
%>
    </body>
</html>
