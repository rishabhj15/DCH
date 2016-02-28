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
String quality=request.getParameter("quality");
String psize=request.getParameter("size");
String rulling=request.getParameter("rulling");
String q=request.getParameter("quantity");
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();

                            ResultSet rs2=st.executeQuery("Select quantity from reamquant where quality='"+quality+"' and psize='"+psize+"' and rulling='"+rulling+"' ");
                            float f1=Float.parseFloat(q);
                            if(rs2.next()){
                                //quant=quant+rs2.getFloat(1);
                            f1=rs2.getFloat(1)+Float.parseFloat(q);
                            java.util.Date d=new java.util.Date();
                            java.sql.Timestamp da1=new java.sql.Timestamp(d.getTime());
                            st.executeUpdate("Update reamquant set quantity='"+f1+"',updated='"+da1+"' where quality='"+quality+"' and psize='"+psize+"' and rulling='"+rulling+"'");
                            }else{
                            PreparedStatement ps2 = cn.prepareStatement("insert into reamquant values(?,?,?,?,?,?)");
                            ResultSet rs3 = st.executeQuery("Select max(id) from reamquant");
                            rs3.next();
                            int mid=rs3.getInt(1);
                            mid=mid+1;
                            java.util.Date d=new java.util.Date();
                            java.sql.Timestamp da=new java.sql.Timestamp(d.getTime());
                            ps2.setInt(1,mid);
                            ps2.setString(2, quality);
                            ps2.setString(3, psize);
                            ps2.setString(4, rulling);
                            ps2.setFloat(5, f1);
                            ps2.setTimestamp(6, da);
                            ps2.executeUpdate();
                            }
response.sendRedirect("home.jsp?q=addStock#fragment-4");
                                cn.close();
                        } catch (Exception ex) {
                            out.println(ex);
                        }
%>
    </body>
</html>
