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
String size=request.getParameter("size");
String rulling=request.getParameter("rulling");
String contractor=request.getParameter("contractor");
String quantity=request.getParameter("quantity");
float quant=Float.parseFloat(quantity);

String rid=request.getParameter("rid");



java.util.Date d=new java.util.Date();
java.sql.Date da=new java.sql.Date(d.getTime());
String date=d.toString();
String []dat=date.split(" ");
String findate=dat[5]+"-"+dat[1]+"-"+dat[2];

Connection cn = null;
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            ResultSet rs = st.executeQuery("Select max(id) from ream");
                            rs.next();
                            int mid=rs.getInt(1);
                            mid=mid+1;
                            PreparedStatement ps = cn.prepareStatement("insert into ream values(?,?,?,?,?,?,?,?,?)");
                            PreparedStatement ps1 = cn.prepareStatement("update reel set status='rulled', sdate='"+da+"' where id='"+rid+"'");
                            ps.setInt(1, mid);
                            ps.setString(2, rid);
                            ps.setString(3, size);
                            ps.setString(4, rulling);
                            ps.setDate(5, da);
                            ps.setString(6, "rulled");
                            ps.setString(7, "-");
                            ps.setString(8, contractor);
                            ps.setFloat(9, quant);
                            ps.executeUpdate();
                            ps1.executeUpdate();
                            ResultSet rs1=st.executeQuery("Select quality from reel where id="+rid);
                            String quality=null;
                            if(rs1.next()){
                            quality=rs1.getString(1);
                            }
                            ResultSet rs2=st.executeQuery("Select quantity from reamquant where quality='"+quality+"' and psize='"+size+"' and rulling='"+rulling+"'");
                            if(rs2.next()){
                                quant=quant+rs2.getFloat(1);
                                java.sql.Timestamp da1=new java.sql.Timestamp(d.getTime());
                            st.executeUpdate("Update reamquant set quantity='"+quant+"',updated='"+da1+"' where quality='"+quality+"' and psize='"+size+"' and rulling='"+rulling+"'");
                            }else{
                                java.sql.Timestamp da1=new java.sql.Timestamp(d.getTime());
                            PreparedStatement ps2 = cn.prepareStatement("insert into reamquant values(?,?,?,?,?,?)");
                            ResultSet rs3 = st.executeQuery("Select max(id) from reamquant");
                            rs3.next();
                            mid=rs3.getInt(1);
                            mid=mid+1;
                            ps2.setInt(1,mid);
                            ps2.setString(2, quality);
                            ps2.setString(3, size);
                            ps2.setString(4, rulling);
                            ps2.setFloat(5, quant);
                            ps2.setTimestamp(6, da1);
                            ps2.executeUpdate();
                      
                            }
                            out.print("Updated Successfully");
                            

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
