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
String psize=request.getParameter("psize");
String rulling=request.getParameter("rulling");
String contractor=request.getParameter("contr");
String rate=request.getParameter("rate");
String notebook=request.getParameter("notebook");
String notebookq=request.getParameter("notebookq");
String bind=request.getParameter("bind");
String avl=request.getParameter("bavl");
out.print(" "+quality+" "+psize+" "+rulling+" "+contractor+" "+notebook+" "+notebookq+" "+bind+" "+avl+" "+rate);
float quant=Float.parseFloat(bind);
float quantavl=Float.parseFloat(avl);
float quantavlf=quantavl-quant;
out.print(quant);
java.util.Date d=new java.util.Date();
java.sql.Date da= new java.sql.Date(d.getTime());
java.sql.Timestamp da1=new java.sql.Timestamp(d.getTime());

Connection cn = null;
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            ResultSet rs = st.executeQuery("Select max(id) from bind");
                            rs.next();
                            int mid=rs.getInt(1);
                            mid=mid+1;
                            PreparedStatement ps = cn.prepareStatement("insert into bind values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                            PreparedStatement ps1 = cn.prepareStatement("update reamquant set quantity="+quantavlf+",updated='"+da1+"' where quality='"+quality+"' and psize='"+psize+"' and rulling='"+rulling+"'");
                            //out.print("update reamquant set quantity="+quantavlf+",updated="+da+" where quality='"+quality+"' and psize='"+psize+"' and rulling='"+rulling+"'");
                            ps.setInt(1, mid);
                            ps.setString(2, quality);
                            ps.setString(3, psize);
                            ps.setString(4, rulling);
                            ps.setDate(5, da);
                            ps.setString(6, contractor);
                            ps.setFloat(7, quant);
                            ps.setFloat(8, Float.parseFloat(notebookq));
                            ps.setInt(9, 0);
                            ps.setInt(10,0);
                            ps.setString(11,notebook);
                            ps.setString(12,"proposed");
                            ps.setString(13,"0");
                            ps.setString(14,rate);
                            ps.executeUpdate();
                            ps1.executeUpdate();
                            /*ResultSet rs1=st.executeQuery("Select quality from reel where id="+rid);
                            String quality=null;
                            if(rs1.next()){
                            quality=rs1.getString(1);
                            }*/
                           /*ResultSet rs2=st.executeQuery("Select quantity from bindquant where quality='"+quality+"' and psize='"+psize+"' and rulling='"+rulling+"' and notebook='"+notebook+"'");
                            float f1=Float.parseFloat(notebookq);
                            if(rs2.next()){
                                //quant=quant+rs2.getFloat(1);
                                f1=rs2.getFloat(1)+Float.parseFloat(notebookq);
                            st.executeUpdate("Update bindquant set quantity='"+f1+"' where quality='"+quality+"' and psize='"+psize+"' and rulling='"+rulling+"' and notebook='"+notebook+"'");
                            }else{
                            PreparedStatement ps2 = cn.prepareStatement("insert into bindquant values(?,?,?,?,?,?)");
                            ResultSet rs3 = st.executeQuery("Select max(id) from bindquant");
                            rs3.next();
                            mid=rs3.getInt(1);
                            mid=mid+1;
                            ps2.setInt(1,mid);
                            ps2.setString(2, quality);
                            ps2.setString(3, psize);
                            ps2.setString(4, rulling);
                            ps2.setFloat(5, f1);
                            ps2.setString(6, notebook);
                            ps2.executeUpdate();
                            }
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            ResultSet rs1=st1.executeQuery("Select name from notebook where id="+notebook);
                            rs1.next();
                            ResultSet rs3=st2.executeQuery("Select quantity from covtype where id="+rs1.getInt(1));
                            rs3.next();
                            int newq=rs3.getInt(1)-Integer.parseInt(notebookq);
                                                                
                           st.executeUpdate("Update covtype set quantity="+newq+" where id="+rs1.getInt(1));*/
//                           response.sendRedirect("home.jsp?q=viewStock#fragment-2");
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
