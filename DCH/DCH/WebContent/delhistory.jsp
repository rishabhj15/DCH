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

    try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            Statement st2=cn.createStatement();
                            out.print("<a href=home.jsp?q=history alt='home'>Back</a><br>");

if(tab.length>0){
    for(int i=0;i<tab.length;i++){
    
                if(tab[i].equals("ream")){
                int j=st.executeUpdate("delete from ream where dat <'"+dat+"'");
                int k=st1.executeUpdate("delete from reel where sdate <'"+dat+"' and status='rulled'");
                out.print(j+" records deleted from ream tab.<br>");
                out.print(k+" records deleted from reel tab.<br>");
                }
                else if(tab[i].equals("bind")){
                int j=st.executeUpdate("delete from bind where dat <'"+dat+"' and sta='processed'");
                int k=st.executeUpdate("delete from bindmatreq where dat <'"+dat+"'");
                out.print(j+" records deleted from bind tab.<br>");
                out.print(k+" records deleted from bindmatreq tab.<br>");
                }else if(tab[i].equals("transact")){
                    ResultSet rs=st.executeQuery("Select * from transact where dat<'"+dat+"'");
                    int count = 0;
                    while(rs.next())
                    {
                    int j=st1.executeUpdate("delete from dispatch where tid='"+rs.getInt(1)+"'");
                    count =count+st2.executeUpdate("delete from transact where id="+rs.getInt(1));
                    }
                    out.print(count+" records deleted from transact tab.<br>");
                }
    }

}
    
    } catch (Exception ex) {
out.println(ex);
}
%>
<%--
<%
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            String sql="update "+tab+" set sta='d' where id="+id;
                            String sql1="";
                            String red="#";
                            if(tab.equals("reamquant")){

                            sql="delete from reamquant where id="+id;

                            response.sendRedirect("home.jsp?q=viewStock#fragment-2");
                            }else if(tab.equals("bindquant")){
                            String nbid=request.getParameter("nbid");
                            sql1="update notebook set sta='d' where id="+nbid;
                            sql="delete from bindquant where id="+id;
                            Statement st1=cn.createStatement();
                            st1.executeUpdate(sql1);
                            response.sendRedirect("home.jsp?q=viewStock#fragment-4");
                            }else if(tab.equals("notebook")){
                            sql1="update notebook set sta='d' where id="+id;
                            sql="delete from bindquant where notebook="+id;
                            Statement st1=cn.createStatement();
                            st1.executeUpdate(sql1);
                                red="#fragment-5";
                            }else if(tab.equals("user")){
                            sql="delete from user where id="+id;
                            red="#fragment-9";
                            }else if(tab.equals("quality")){
                                red="#fragment-1";
                            }else if(tab.equals("rulling")){
                                red="#fragment-2";
                            }else if(tab.equals("size")){
                                red="#fragment-3";
                            }else if(tab.equals("papersize")){
                                red="#fragment-4";
                            }else if(tab.equals("covtype")){
                                red="#fragment-6";
                            }else if(tab.equals("contractor")){
                                red="#fragment-7";
                            }else if(tab.equals("user")){
                                red="#fragment-9";
                            }else if(tab.equals("bindqual")){
                                red="#fragment-10";
                            }else if(tab.equals("bindmat")){
                                red="#fragment-11";
                            }else if(tab.equals("party")){
                                red="#fragment-8";
                            }
                            int i=st.executeUpdate(sql);

                            out.print(i);
                            if(i==1){
                               response.sendRedirect("home.jsp?q=db"+red);
                            }

} catch (Exception ex) {
out.println(ex);
}
--%>
<%
}else{%>
You are not authorized. Please Login.
        <%}%>
    </body>
</html>
