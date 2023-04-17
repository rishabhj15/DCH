<%-- 
    Document   : productlist
    Created on : Jun 17, 2012, 3:38:58 PM
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
        String prod=request.getParameter("product");
        String rull=request.getParameter("rulling");
        String party=request.getParameter("party");
        out.print("<div width=100% style='background-color:#cccfff;'> Results for "+prod+" "+rull+"</div>");
        Connection cn = null;
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            Statement st2= cn.createStatement();
                            ResultSet rs=st1.executeQuery("Select * from stockwithid where product like '%"+prod+"%' and rulling like '%"+rull+"%'");
                            
                    %>

                    <select size="15" onchange="fetchAvailable()" style="width: 400px;" id="lop" accesskey="r" >
        <%                  
                            int i=0;
                            out.print("<optgroup label='All Products'>");
                            while(rs.next()){
                                i++;
                                if(i==1){
                                out.print("<option selected");
                                }else{
                                out.print("<option");
                                }
                                out.print(" value="+rs.getInt(1)+" >"+rs.getString(2)+" "+rs.getString(3)+"</option>");
                            }
                            out.print("</optgroup>");
        }catch(Exception ex){
        out.print(ex);
        }finally {
        	  try{
      			cn.close();
      		}catch(Exception ex){
      			ex.printStackTrace();
      		}
          }
        %>
                    </select>
    </body>
</html>
