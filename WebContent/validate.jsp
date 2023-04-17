<%--
    Document   : verify
    Created on : Oct 10, 2010, 9:45:32 AM
    Author     : Rishabh
--%>
 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>
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
                    String u = request.getParameter("username");
                    String p = request.getParameter("password");

                    if (u.equals("") || p.equals("") )
                        {
                        out.println("Please Give Username And Password.");
                %>
                <br>Please<a href="index.jsp"> Login.</a>

                <%}else{
                	Connection cn = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps = cn.prepareStatement("SELECT password,id from user where username='"+u+"'");
                            Statement st=cn.createStatement();
                            ResultSet rs = ps.executeQuery();
                            if (rs.next() && p.equals(rs.getString(1))) {
                                String id=rs.getString(2);
                                String un="";
                                User usr = new User(id,un);
                                session.setAttribute("user", usr);
                                response.sendRedirect("home.jsp?q=welcome");

            }else{response.sendRedirect("index.jsp");%>

                <%                    }
                        } catch (Exception ex) {
                            ex.printStackTrace();
                            out.println("<h1>Please Start MySql Server or Load Required Driver.</h1>");
                            out.println(ex);
                        }finally {
                        	  try{
                      			cn.close();
                      		}catch(Exception ex){
                      			ex.printStackTrace();
                      		}
                          }
}%>
    </body>
</html>
