<%-- 
    Document   : insertparty
    Created on : Dec 27, 2011, 12:58:39 AM
    Author     : Rishabh
--%>

<%@page import="session.User"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
User u=(User)session.getAttribute("user");
if(u!=null){
    String name=request.getParameter("name");
    String addr=request.getParameter("addr");
    String tin=request.getParameter("tin");
    String pno=request.getParameter("pno");
    String trans=request.getParameter("trans");


try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            String sql="insert into party values(?,?,?,?,?,?,?)";
                            Statement st=cn.createStatement();
                            ResultSet rs=st.executeQuery("Select max(id) from party");
                            rs.next();
                            int id=rs.getInt(1)+1;
                            PreparedStatement ps=cn.prepareStatement(sql);
                            ps.setInt(1, id);
                            ps.setString(2, name);
                            ps.setString(3, addr);
                            ps.setString(4, tin);
                            ps.setString(5, pno);
                            ps.setString(6, trans);
                            ps.setString(7, "a");
                            ps.executeUpdate();
                            response.sendRedirect("home.jsp?q=db#fragment-8");
} catch (Exception ex) {
out.println(ex);
}
}else{%>
You are not authorized. Please Login.
        <%}%>


}%>
