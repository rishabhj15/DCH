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
    String tab="Party Hindi";
    String id=request.getParameter("id");
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            String sql1="Select * from party where id="+id;
                            String sql="Select * from party_hindi where pid="+id;
                            String red="#";
                            ResultSet rs=st.executeQuery(sql);
                            ResultSet rs1=st1.executeQuery(sql1);
                            out.print("<h2 id='cmd'>Edit "+tab.toLowerCase()+"</h2>");
                            String name = "";
                            String addr = "";
                            
                            while(rs.next()){
								name = rs.getString("name_hindi");
								addr = rs.getString("address_hindi");
							}
                            String name_english = "";
                            String addr_english = "";
                            
                            while(rs1.next()){
								name_english = rs1.getString("name");
								addr_english = rs1.getString("addr");
							}
                            
                            
                            out.print("<form target='_parent' action='updatePartyHindi.jsp?tab="+tab+"' method=post ><table align='center' >");

                            out.print("<tr><th>Name (Hindi)</th><td>"+name_english+"</td><td><input type=text name=name style='padding: 10px;' value='"+name+"'></td></tr>"
                                    + "<tr><th>Address (Hindi)</th><td>"+addr_english+"</td><td><textarea rows=5 cols=25 name=addr>"+addr+"</textarea></td></tr>"
                                    +"<input type=hidden name=id value="+id+">"
                                    + "<tr><td></td><td><input type=submit value=Update id='but'></td></tr></table></form>");

} catch (Exception ex) {
out.println(ex);
}
}else{%>
You are not authorized. Please Login.
        <%}%>
    </body>
</html>
