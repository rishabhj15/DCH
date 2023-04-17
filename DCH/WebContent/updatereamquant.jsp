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
    String reamquant=request.getParameter("reamquant");
    String quality=request.getParameter("quality");
    String psize=request.getParameter("psize");
    String rulling=request.getParameter("rulling");
    if(reamquant!=null&&quality!=null&&psize!=null&&rulling!=null){
    	Connection cn = null;
    try {
                            java.util.Date d=new java.util.Date();
                            java.sql.Timestamp da=new java.sql.Timestamp(d.getTime());

                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps=null;
                            Statement st=cn.createStatement();
                            int i=st.executeUpdate("update reamquant set quantity="+reamquant+", updated='"+da+"' where quality='"+quality+"' and psize="+psize+" and rulling="+rulling);
                            if(i==1){
                            response.sendRedirect("home.jsp?q=viewStock1#fragment-3");
                            }else{out.print("Something went wrong. Review required");}
    
    
} catch (Exception ex) {
out.println(ex);
}finally {
	  try{
			cn.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
  }
}
}else{
response.sendRedirect("index.jsp");
}
%>
    </body>
</html>
