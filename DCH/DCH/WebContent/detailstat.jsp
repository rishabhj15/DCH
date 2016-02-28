<%-- 
    Document   : detailstat
    Created on : Feb 17, 2012, 5:56:41 PM
    Author     : Rishabh
--%>


<%@page import="session.User"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
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
    String tab=request.getParameter("tab");
    String id=request.getParameter("id");
try {
Class.forName("com.mysql.jdbc.Driver").newInstance();
Conf c=new Conf();
Connection cn = DriverManager.getConnection(c.getURL());
Statement st=cn.createStatement();
ResultSet rs=st.executeQuery("SELECT COUNT( * ) AS  `Rows` ,  `quality` FROM  `reel` where status='raw' GROUP BY  `quality` ORDER BY  `quality` ");
%>
<fieldset>
    <legend>Raw Reels:</legend>
<table>
    <tr>
        <th>Quality</th><th>Quantity</th>
    </tr>
        <%
while(rs.next()){
out.print("<tr><td>"+rs.getString(2)+"</td><td>"+rs.getString(1)+"</td></tr>");
}
%>
</table>
</fieldset>
    <%
rs=st.executeQuery("SELECT COUNT( * ) AS  `Rows` , `rulling` ,B.type FROM  reamquant as A,rulling as B where A.rulling=B.id GROUP BY A.rulling ORDER BY  A.rulling");
%>
<fieldset>
    <legend>Raw Reams:</legend>
<table>
    <tr>
        <th>Rulling</th><th>Quantity</th>
    </tr>
        <%
while(rs.next()){
out.print("<tr><td>"+rs.getString(3)+"</td><td>"+rs.getString(2)+"</td></tr>");
}
%>
</table>
</fieldset>
<%
} catch (Exception ex) {
out.println(ex);
}
}else{%>
You are not authorized. Please Login.
        <%}%>
    </body>
</html>
