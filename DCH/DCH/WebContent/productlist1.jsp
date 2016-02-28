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
        String combo=request.getParameter("combo");
        out.print("<div width=100% style='background-color:#cccfff;'> Results for "+combo+"</div>");
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            ResultSet rs=st.executeQuery("Select * from stockwithid where product like '%"+combo+"%' or rulling like '%"+combo+"%' or concat(product,' ',rulling) like '%"+combo+"%'");
        %>
                    
                    <select style="width: 400px; " onchange="fetchAvailable()" multiple size="15" id="lop" accesskey="r" >

        <%
                            int i=0;
                            while(rs.next()){
                                i++;
                                if(i==1){
                                out.print("<option selected");
                                }else{
                                out.print("<option");
                                }
                                out.print(" value="+rs.getInt(1)+" >"+rs.getString(2)+" "+rs.getString(3)+"</option>");
                            }
        }catch(Exception ex){
        out.print(ex);
        }
        %>
        </select>
        
        
        
                    
    </body>
</html>
