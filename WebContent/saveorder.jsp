<%-- 
    Document   : saveorder
    Created on : Jun 23, 2012, 4:12:29 PM
    Author     : Rishabh
--%>

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
String party=request.getParameter("cparty");
String product[]=request.getParameterValues("proid");
String bundle[]=request.getParameterValues("bundle");
String loose[]=request.getParameterValues("loose");
String total[]=request.getParameterValues("total");
int o=0;


int h=0;
Connection cn = null;
        try {
            o=Integer.parseInt(request.getParameter("oid"));
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            Statement st2= cn.createStatement();
                            ResultSet rs=null;
                            ResultSet rs1=null;
                            ResultSet rs2=null;

                            if(o==0){
                            rs=st.executeQuery("SELECT MAX( id ) FROM  `order`");
                            rs.next();
                            h=Integer.parseInt(rs.getString(1));
                            java.util.Date d=new java.util.Date();
                            java.sql.Date da=new java.sql.Date(d.getTime());
                            st1.executeUpdate("insert into `order` values('"+(h+1)+"','"+party+"','"+da+"','0000-00-00','p')");
                            
                            rs2=st1.executeQuery("Select max(id) from `order_list`");
                            rs2.next();
                            int max_item=rs2.getInt(1);
                            max_item++;
                                for(int i=0;i<product.length;i++){
                                    st1.executeUpdate("insert into `order_list` values('"+max_item+"','"+(h+1)+"','"+product[i]+"','0','"+total[i]+"')");
                                    max_item++;
                                }
                            }else{
                            st.executeUpdate("delete from order_list where oid="+o);
                            rs2=st1.executeQuery("Select max(id) from `order_list`");
                            rs2.next();
                            int max_item=rs2.getInt(1);
                            max_item++;
                                for(int i=0;i<product.length;i++){
                                    st1.executeUpdate("insert into `order_list` values('"+max_item+"','"+o+"','"+product[i]+"','0','"+total[i]+"')");
                                    max_item++;
                                }

                            }

                            }catch(Exception ex){
                            out.print(ex);
                            }finally {
                            	  try{
                          			cn.close();
                          		}catch(Exception ex){
                          			ex.printStackTrace();
                          		}
                              }
out.print("<h3>Order saved successfully.</h3>"+o);
session.removeAttribute("ordercart");
response.sendRedirect("home.jsp?q=order");
%>
    </body>
</html>
