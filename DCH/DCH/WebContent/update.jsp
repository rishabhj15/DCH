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
    String tab=request.getParameter("tab");
    int id=Integer.parseInt(request.getParameter("id"));
    String val=null;
    try {

                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps=null;
                            Statement st=cn.createStatement();
                            if(tab.equals("bindmat")){
                                String vals[]=request.getParameterValues("val");
                                ps=cn.prepareStatement("update "+tab+" set name='"+vals[0]+"',rate='"+vals[1]+"' where id="+id);
                                ps.executeUpdate();

                            }else{
                            int i=st.executeUpdate("Delete from "+tab+" where id="+id);
                            out.print(i);

    if(tab.equals("notebook")){
    String vals[]=request.getParameterValues("val");
    ps=cn.prepareStatement("insert into "+tab+" values(?,?,?,?)");
                            if(i!=0){
                            ps.setInt(1, id);
                            ps.setString(2, vals[0]);
                            ps.setString(3, vals[1]);
                            ps.setString(4, "a");
                            ps.executeUpdate();
                            }
    }else if(tab.equals("contractor")){
    String vals[]=request.getParameterValues("val");
    ps=cn.prepareStatement("insert into "+tab+" values(?,?,?,?,?)");
                            if(i!=0){
                            ps.setInt(1, id);
                            ps.setString(2, vals[0]);
                            ps.setString(3, vals[1]);
                            ps.setString(4, vals[2]);
                            ps.setString(5, "a");
                            ps.executeUpdate();
                            }
    }else if(tab.equals("bindqual")){
    String vals[]=request.getParameterValues("val");
    ps=cn.prepareStatement("insert into "+tab+" values(?,?,?,?)");
                            if(i!=0){
                            ps.setInt(1, id);
                            ps.setString(2, vals[0]);
                            ps.setString(3, vals[1]);
                            ps.setString(4, "a");
                            ps.executeUpdate();
                            }
    }else if(tab.equals("user")){
    String vals[]=request.getParameterValues("val");
    ps=cn.prepareStatement("insert into "+tab+" values(?,?,?)");
                            if(i!=0){
                            ps.setInt(1, id);
                            ps.setString(2, "admin");
                            ps.setString(3, vals[0]);
                            ps.executeUpdate();
                            }
    }else if(tab.equals("covtype")){
    String vals=request.getParameter("val");
    String q=request.getParameter("q");
    ps=cn.prepareStatement("insert into "+tab+" values(?,?,?,?)");
                            if(i!=0){
                            ps.setInt(1, id);
                            ps.setString(2, vals);
                            ps.setString(3,q);
                            ps.setString(4, "a");
                            ps.executeUpdate();
                            }
    }else{
    val=request.getParameter("val");
    ps=cn.prepareStatement("insert into "+tab+" values(?,?,?)");
                            if(i!=0){
                            ps.setInt(1, id);
                            ps.setString(2, val);
                            ps.setString(3, "a");
                            ps.executeUpdate();
                            }

    }
    //out.print("<br>"+tab+"<br>"+id+"<br>"+val);
                   
                            }
                            String red="#";
                            if(tab.equals("user")){
                            red="#fragment-9";
                            }else if(tab.equals("quality")){
                                red="#fragment-1";
                            }else if(tab.equals("rulling")){
                                red="#fragment-2";
                            }else if(tab.equals("size")){
                                red="#fragment-3";
                            }else if(tab.equals("papersize")){
                                red="#fragment-4";
                            }else if(tab.equals("notebook")){
                                red="#fragment-5";
                            }else if(tab.equals("covtype")){
                                red="#fragment-6";
                            }else if(tab.equals("contractor")){
                                red="#fragment-7";
                            }else if(tab.equals("bindqual")){
                                red="#fragment-10";
                            }else if(tab.equals("bindmat")){
                                red="#fragment-11";
                            }

                            response.sendRedirect("home.jsp?q=db"+red);

} catch (Exception ex) {
out.println(ex);
}
}
%>
    </body>
</html>
