<%-- 
    Document   : service
    Created on : Feb 11, 2012, 6:15:09 PM
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
                    try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Conf c=new Conf();
                Connection cn = DriverManager.getConnection(c.getURL());
                Statement st=cn.createStatement();
                Statement st1=cn.createStatement();
                Statement st2=cn.createStatement();
                PreparedStatement ps=cn.prepareStatement("Insert into bindquant values(?,?,?,?,?,?,?,?,?,?)");
                ResultSet rs1=null;
                ResultSet rs2=null;
                ResultSet rs=st.executeQuery("Select id from notebook where sta='a'");
                        int count=0;
                while(rs.next()){
                    rs2=st2.executeQuery("Select max(id) from bindquant");
                    rs2.next();
                rs1=st1.executeQuery("Select notebook from bindquant where notebook="+rs.getInt(1));
                if(!rs1.next()){
                    
                ps.setInt(1, rs2.getInt(1)+1);
                ps.setString(2, "Manual Entry");
                ps.setString(3, "Manual Entry");
                ps.setString(4, "Manual Entry");
                ps.setInt(5, rs.getInt(1));
                ps.setInt(6,0);
                ps.setInt(7,0);
                ps.setInt(8,0);
                ps.setInt(9,0);

                java.util.Date d1=new java.util.Date();
                java.sql.Timestamp da1=new java.sql.Timestamp(d1.getTime());
                ps.setTimestamp(10,da1);
                if(ps.executeUpdate()>0){
                    count++;
                }
                rs1.close();
                ps.clearParameters();
                }
                
                }
                        out.print(count);
}catch(Exception ex){
out.print(ex);
}
%>
    </body>
</html>
