<%@page import="session.User"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%--
    Document   : del
    Created on : Nov 2, 2011, 1:37:02 PM
    Author     : Rishabh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles.css" />
    </head>
    <body bgcolor="blue" >
<%
User u=(User)session.getAttribute("user");
if(u!=null){
    String id=request.getParameter("id");
    String bquant=request.getParameter("bquant");
    String lquant=request.getParameter("lquant");
    String tquant=request.getParameter("tquant");
    String bsize=request.getParameter("bsize");
   //out.print(id+" "+bquant+" "+lquant);
    if(id!=null&&bquant!=null&&lquant!=null){
    try {
                            java.util.Date d=new java.util.Date();
                            java.sql.Date da=new java.sql.Date(d.getTime());

                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps=null;
                            Statement st=cn.createStatement();
                            java.util.Date d1=new java.util.Date();
                            java.sql.Timestamp da1=new java.sql.Timestamp(d1.getTime());
                            int i=st.executeUpdate("update bindquant set bundle="+bquant+",bsize='"+bsize+"', loose='"+lquant+"',quantity='"+tquant+"',updated='"+da1+"' where id='"+id+"'");
                            cn.close();
                           // out.print(i);
                            if(i==1){

                            response.sendRedirect("home.jsp?q=viewStock2#fragment-5");
                            }
                            else{
                                out.print("Something went wrong. Review required");
                            }
} catch (Exception ex) {
out.println(ex);
}
}
}else{
response.sendRedirect("index.jsp");
}
%>
    </body>
</html>
