<%-- 
    Document   : updatetransact
    Created on : Jan 27, 2013, 6:15:22 PM
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
<%            String id=request.getParameter("id");
String parcel=request.getParameter("parcel");
String trec=request.getParameter("transrec");
String tn=request.getParameter("transname");
String localtn=request.getParameter("localtransname");
if(parcel.matches("[a-z]*")){
out.print("<span style='color:red;'>Invalid Character<span>");
}else{
            try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            int i=st.executeUpdate("update transact set `tname`='"+tn+"', `treceipt`='"+trec+"', noparcel="+parcel+", `localtrans`='"+localtn+"' where id="+id);
                            out.print(i+" record updated.");
                           // response.sendRedirect("home.jsp?q=print");
}catch (Exception ex) {
out.print(ex);
}}
%>
    </body>
</html>
