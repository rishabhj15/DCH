<%@page import="session.User"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%--
    Document   : del
    Created on : Nov 2, 2011, 1:37:02 PM
    Author     : Rishabh
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
       <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles.css" />
    </head>
    <body bgcolor="blue" >
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
                            String sql="Select * from "+tab+" where id="+id;
                            String red="#";
                            ResultSet rs=st.executeQuery(sql);
                            out.print("<h2 id='cmd'>Edit "+tab.toLowerCase()+"</h2>");
                            while(rs.next()){
                                out.print("<form target='_parent' action='updateparty.jsp?tab="+tab+"' method=post ><table align='center' >");

                                out.print("<tr><td>Name</td><td><input type=text name=name style='padding: 10px;' value='"+rs.getString("name")+"'></td></tr>"
                                        + "<tr><td>Address</td><td><textarea rows=5 cols=25 name=addr>"+rs.getString("addr")+"</textarea></td></tr>"
                                        +"<tr><td>Tin</td><td><input type=text name=tin value='"+rs.getString("tin")+"'></td></tr>"
                                        +"<tr><td>Phones</td><td><input type=text name=pno value='"+rs.getString("pno")+"'></td></tr>"
                                        +"<tr><td>Transport</td><td><textarea rows=5 cols=25 name=trans>"+rs.getString("trans")+"</textarea></td></tr>"
                                        +"<input type=hidden name=id value="+id+">"
                                        + "<tr><td></td><td><input type=submit value=Update id='but'></td></tr></table></form>");

}} catch (Exception ex) {
out.println(ex);
}
}else{%>
You are not authorized. Please Login.
        <%}%>
    </body>
</html>
