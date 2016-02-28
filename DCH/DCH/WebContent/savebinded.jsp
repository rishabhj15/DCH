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
String bid=request.getParameter("bid");
/*String bundle=request.getParameter("bundle");
String loose=request.getParameter("loose");
String quality=request.getParameter("quality");
String psize=request.getParameter("psize");
String rulling=request.getParameter("rulling");*/
String notebook=request.getParameter("notebook");
String total=request.getParameter("total");
//String bsize=request.getParameter("size");
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st3=cn.createStatement();
                            //ResultSet rs2=st.executeQuery("Select bundle,loose,quantity from bindquant where notebook='"+notebook+"'");
                            ResultSet rs2=st.executeQuery("Select quantity from bindquant where notebook='"+notebook+"'");
                            //float f1=Float.parseFloat(bundle);
                            //float f2=Float.parseFloat(loose);
                            float f3=Float.parseFloat(total);
                            java.util.Date d=new java.util.Date();
                            java.sql.Date da=new java.sql.Date(d.getTime());
                            //st3.executeUpdate("Update bind set bundle='"+f1+"', loose='"+f2+"',notebookpq="+total+",sta='processed',dat='"+da+"' where id="+bid+" ");
                            st3.executeUpdate("Update bind set notebookpq="+total+",sta='processed',dat='"+da+"' where id="+bid+" ");
                            if(rs2.next()){
                                //quant=quant+rs2.getFloat(1);
                                //f1=rs2.getFloat(1)+f1;
                                //f2=rs2.getFloat(2)+f2;
                                f3=rs2.getFloat(1)+f3;
                            java.util.Date d1=new java.util.Date();
                            java.sql.Timestamp da1=new java.sql.Timestamp(d1.getTime());
                            //st.executeUpdate("Update bindquant set bundle='"+f1+"', loose='"+f2+"',quantity='"+f3+"' where notebook='"+notebook+"'");
                            st.executeUpdate("Update bindquant set quantity='"+f3+"' where notebook='"+notebook+"'");
                            }else{
                            java.util.Date d1=new java.util.Date();
                            java.sql.Timestamp da1=new java.sql.Timestamp(d1.getTime());
                            PreparedStatement ps2 = cn.prepareStatement("insert into bindquant values(?,?,?,?,?,?,?,?,?,?)");
                            ResultSet rs3 = st.executeQuery("Select max(id) from bindquant");
                            rs3.next();
                            int mid;
                            mid=rs3.getInt(1);
                            mid=mid+1;
                            ps2.setInt(1,mid);
                            ps2.setString(2, "Manual Entry");
                            ps2.setString(3, "Manual Entry");
                            ps2.setString(4, "Manual Entry");
                            ps2.setString(5, notebook);
                            ps2.setFloat(6,0);
                            ps2.setFloat(7,0);
                            ps2.setInt(8,1);
                            ps2.setFloat(9,f3);
                            ps2.setTimestamp(10,da1);
                            ps2.executeUpdate();
                            }
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            ResultSet rs1=st1.executeQuery("Select name from notebook where id="+notebook);
                            rs1.next();
                            ResultSet rs3=st2.executeQuery("Select quantity from covtype where id="+rs1.getInt(1));
                            rs3.next();
                            int newq=rs3.getInt(1)-Integer.parseInt(total);

                           st.executeUpdate("Update covtype set quantity="+newq+" where id="+rs1.getInt(1));
                           out.println("<h2 align='center' style='background-color: firebrick; color: white;'>Updated Successfully</h2>");
        cn.close();
                        } catch (Exception ex) {
                            out.print(ex);
                        }

%>
    </body>
</html>
