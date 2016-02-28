<%@page import="session.User"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%--
    Document   : del
    Created on : Nov 2, 2011, 1:37:02 PM
    Author     : Rishabh
--%>

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
User u=(User)session.getAttribute("user");
if(u!=null){
String user=request.getParameter("username");
String pass=request.getParameter("password");
String id=request.getParameter("id");
if(user.equals("")||pass.equals("")){
out.print("Invalid Operation.");
}else{
    
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps=cn.prepareStatement("update user set username=?,password=? where id="+id);
                            ps.setString(1, user);
                            ps.setString(2, pass);
                            ps.executeUpdate();
                            cn.close();
                            response.sendRedirect("home.jsp?q=db#fragment-9");

} catch (Exception ex) {
out.println(ex);
}}
}else{%>
You are not authorized. Please Login.
        <%}%>
    </body>
</html>