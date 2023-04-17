<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
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
    </head>
    <body>
<%
User u=(User)session.getAttribute("user");
if(u!=null){
    String []tab=request.getParameterValues("tab");

    String dat=request.getParameter("bfr");
    
    Connection cn = null;

    try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            out.print("<a href=home.jsp?q=history alt='home'>Back</a><br>");
                            
                            List<String> tabList = Arrays.asList(tab);

if(tabList.size()>0){
    
    
                if(tabList.contains("ream")){
                int j=st.executeUpdate("delete from ream where dat <'"+dat+"'");
                int k=st1.executeUpdate("delete from reel where sdate <'"+dat+"' and status='rulled'");
                out.print(j+" records deleted from ream tab.<br>");
                out.print(k+" records deleted from reel tab.<br>");
                }
                else if(tabList.contains("bind")){
                int j=st.executeUpdate("delete from bind where dat <'"+dat+"' and sta='processed'");
                int k=st.executeUpdate("delete from bindmatreq where dat <'"+dat+"'");
                out.print(j+" records deleted from bind tab.<br>");
                out.print(k+" records deleted from bindmatreq tab.<br>");
                }else if(tabList.contains("transact")){
                	
                	int z = st2.executeUpdate("delete from transact where dat<'"+dat+"'");
                	out.print(z+" records deleted from transact tab.<br>");
                	
                	int z1 = st1.executeUpdate("delete from dispatch where tid not in (select id from transact)");
                	out.print(z1+" records deleted from dispatch tab.<br>");
                    
                }
    }

	}catch (Exception ex) {
		out.println(ex);
	}finally{
		try{
			cn.close();
		}catch(Exception ex){
			out.println(ex);
		}
	}
%>
<%
}else{%>
You are not authorized. Please Login.
        <%}%>
    </body>
</html>
