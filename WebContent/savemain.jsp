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
String notebook=request.getParameter("notebook");
String total=request.getParameter("ts");
Connection cn = null;
try {
                            java.util.Date d1=new java.util.Date();
                            java.sql.Timestamp da1=new java.sql.Timestamp(d1.getTime());
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            ResultSet rs4=st1.executeQuery("Select pno from notebook where id="+notebook);
                            rs4.next();
                            String rulling=rs4.getString(1);
                            ResultSet rs2=st.executeQuery("Select quantity from bindquant where  notebook='"+notebook+"'");
                            float f3=Float.parseFloat(total);
                            if(rs2.next()){
                            f3=rs2.getFloat(1)+f3;
                            st.executeUpdate("Update bindquant set quantity='"+f3+"',updated='"+da1+"' where notebook='"+notebook+"'");
                            }else{
                            PreparedStatement ps2 = cn.prepareStatement("insert into bindquant values(?,?,?,?,?,?,?,?,?,?)");
                            ResultSet rs3 = st.executeQuery("Select max(id) from bindquant");
                            rs3.next();
                            int mid=rs3.getInt(1);
                            mid=mid+1;
                            ps2.setInt(1,mid);
                            ps2.setString(2, "Manual Entry");
                            ps2.setString(3, "Manual Entry");
                            ps2.setString(4, "Manual Entry");
                            ps2.setString(5, notebook);
                            ps2.setFloat(6, 0);
                            ps2.setFloat(7, 0);
                            ps2.setString(8, "1");
                            ps2.setFloat(9, f3);
                            ps2.setTimestamp(10, da1);
                            ps2.executeUpdate();
                            }
								response.sendRedirect("home.jsp?q=addStock#fragment-3");
                        } catch (Exception ex) {
                            out.println(ex);
                        }finally {
                        	  try{
                      			cn.close();
                      		}catch(Exception ex){
                      			ex.printStackTrace();
                      		}
                          }
%>
    </body>
</html>
