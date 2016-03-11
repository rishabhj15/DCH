<%@page import="session.User"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%--
    Document   : del
    Created on : Nov 2, 2011, 1:37:02 PM
    Author     : Rishabh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles.css" />
    </head>
    <body bgcolor="blue" >
<%
User u=(User)session.getAttribute("user");
if(u!=null){
    //String tab=request.getParameter("tab");
    
    String name=request.getParameter("name");
    String addr=request.getParameter("addr");
    int id=Integer.parseInt(request.getParameter("id"));
    
    try {

                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps=null;
                            Statement st=cn.createStatement();
                            //int i=st.executeUpdate("Delete from "+tab+" where id="+id);
                            //out.print(i);

    
                            ps=cn.prepareStatement("update party_hindi set name_hindi = ? , address_hindi = ? where pid = ?");
                            
                            ps.setString(1, name);
                            ps.setString(2, addr);
                            ps.setInt(3, id);
    if(ps.executeUpdate()==0){
    	ps.close();
    	
    ps=cn.prepareStatement("insert into party_hindi values(?,?,?)");
	
	                            ps.setInt(1, id);
	                            ps.setString(2, name);
	                            ps.setString(3, addr);
	                            ps.executeUpdate();
	                            
	
    }
    //out.print("<br>"+tab+"<br>"+id+"<br>"+val);


                          
                          String red="#fragment-8";
                          
response.sendRedirect("home.jsp?q=db"+red);
} catch (Exception ex) {
out.println(ex);
}
}
%>
    </body>
</html>
