 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%><%--
    Document   : savestock
    Created on : Sep 29, 2011, 12:31:41 AM
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
String papertype=request.getParameter("papertype");
String quality=request.getParameter("quality");
String size=request.getParameter("size");
String quantity=request.getParameter("quantity");
int q=Integer.parseInt(quantity);
String id[]=request.getParameterValues("id");
String wt[]=request.getParameterValues("w");
java.util.Date d=new java.util.Date();
java.sql.Date da=new java.sql.Date(d.getTime());

try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            ResultSet rs = st.executeQuery("Select max(id) from reel");
                            rs.next();
                            int mid=rs.getInt(1);
                            mid=mid+1;
                            PreparedStatement ps = cn.prepareStatement("Insert into reel values(?,?,?,?,?,?,?,?,?)");
                            for(int i=0;i<q;i++){
                            ps.setInt(1, mid);
                            ps.setString(2, papertype);
                            ps.setString(3, quality);
                            ps.setString(4, size);
                            ps.setString(5, id[i]);
                            ps.setString(6, wt[i]);
                            ps.setDate(7, da);
                            ps.setString(8, "raw");
                            ps.setString(9, "-");
                            ps.executeUpdate();
                            mid++;
                            }
                            response.sendRedirect("home.jsp?q=Success");
                                cn.close();
                        } catch (Exception ex) {
                            out.println(ex);
                        }
%>
    </body>
</html>
