 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>
 <%--
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
String id=request.getParameter("bindmat");
String quantity=request.getParameter("matq");
int q=Integer.parseInt(quantity);
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            ResultSet rs = st.executeQuery("select avl from bindmat where id="+id);
                            rs.next();
                            int mid=rs.getInt(1);
                            q=mid+q;
                            PreparedStatement ps = cn.prepareStatement("Update bindmat set avl=? where id=? ");



                            ps.setInt(1, q);
                            ps.setString(2,id);

                            ps.executeUpdate();


                            response.sendRedirect("home.jsp?q=addStock#fragment-5");
                                cn.close();
                        } catch (Exception ex) {
                            out.println(ex);
                        }
%>
    </body>
</html>
