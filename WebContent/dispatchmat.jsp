<%--
    Document   : savebinded
    Created on : Nov 21, 2011, 4:24:47 PM
    Author     : Rishabh
--%>

<%@page import="mybean.Conf"%>
<%@page import="java.sql.*"%>
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
String bid=request.getParameter("bindmat");
String contr=request.getParameter("contr");
String quantity=request.getParameter("matq");
Connection cn = null;
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st3=cn.createStatement();
                            ResultSet rs2=st.executeQuery("Select avl from bindmat where id="+bid);
                            rs2.next();
                            float f1=Float.parseFloat(quantity);
                            float f2=Float.parseFloat(rs2.getString("avl"))-f1;
                            st3.executeUpdate("Update bindmat set avl='"+f2+"' where id="+bid);
                            java.util.Date d=new java.util.Date();
                            java.sql.Date da=new java.sql.Date(d.getTime());

                            PreparedStatement ps2 = cn.prepareStatement("insert into bindmatreq values(?,?,?,?,?)");
                            ResultSet rs3 = st.executeQuery("Select max(id) from bindmatreq");
                            rs3.next();
                            int mid;
                            mid=rs3.getInt(1);
                            mid=mid+1;
                            ps2.setInt(1,mid);
                            ps2.setString(2, contr);
                            ps2.setString(3, bid);
                            ps2.setDate(4, da);
                            ps2.setFloat(5, f1);
                            ps2.executeUpdate();
                            
                                    response.sendRedirect("home.jsp?q=viewStock1#fragment-6");
                        } catch (Exception ex) {
                            out.print(ex);
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
