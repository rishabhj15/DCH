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
            String party=request.getParameter("party");
        
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            Statement st2= cn.createStatement();
                            
                            ResultSet rs2=st2.executeQuery("Select name from party where id = "+party);
                            rs2.next();
                    %>

                    <select size="15" onchange="fetchAvailable()" style="width: 400px;" id="lop"  accesskey="r" >
        <%                  

                            int j=0;
                            out.print("<optgroup label='Frequently Ordered by "+rs2.getString(1) +"'>");
                            ResultSet rs1 = st.executeQuery("SELECT d.particular, s.id, COUNT( * ) FROM dispatch d, transact t, stockwithid s WHERE d.tid = t.id AND t.party = '"+party+"' AND CONCAT( s.product,  ' ', s.rulling ) = d.particular GROUP BY particular ORDER BY COUNT( * ) DESC  LIMIT 0 , 10");
                            while(rs1.next()){
                                j++;
                                if(j==1){
                                out.print("<option selected");
                                }else{
                                out.print("<option");
                                }
                                out.print(" value="+rs1.getInt(2)+"  >"+rs1.getString(1)+" "+rs1.getString(3) +"</option>");
                            }
                            out.print("</optgroup>");

        }catch(Exception ex){
        out.print(ex);
        }
        
        
%>                    
                    </select>
                    </body>
</html>
