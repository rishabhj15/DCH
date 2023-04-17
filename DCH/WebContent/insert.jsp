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
//if(u!=null){
    String tab=request.getParameter("tab");
    String val=request.getParameter("val");
    
    String name=null;
    String pno=null;
    String rate=null;
    String area=null;
    Connection cn = null;
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            String sql="insert into "+tab+" values(?,?,?)";
                            
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
                            ResultSet rs=st.executeQuery("Select max(id) from "+tab);
                            rs.next();
                            int id=rs.getInt(1)+1;
                            ResultSet rs1=st1.executeQuery("Select max(id) from bindquant");
                            rs1.next();
                            int id1=rs1.getInt(1)+1;
                            String red="#";
                            if(tab.equals("notebook")||tab.equals("covtype")||tab.equals("bindqual")){
                                sql="insert into "+tab+" values(?,?,?,?)";
                            }else if(tab.equals("bindmat")||tab.equals("contractor")){
                                sql="insert into "+tab+" values(?,?,?,?,?)";
                            }
                            PreparedStatement ps=cn.prepareStatement(sql);
                            PreparedStatement ps1=cn.prepareStatement("Insert into bindquant values(?,?,?,?,?,?,?,?,?,?)");
                            ps.setInt(1, id);
                            ps.setString(2, val);
                            ps.setString(3, "a");
                            if(tab.equals("quality")){
                                red="#fragment-1";
                            }else if(tab.equals("rulling")){
                                red="#fragment-2";
                            }else if(tab.equals("size")){
                                red="#fragment-3";
                            }else if(tab.equals("papersize")){
                                red="#fragment-4";
                            }else if(tab.equals("notebook")){
                                sql="insert into "+tab+" values(?,?,?,?)";
                                red="#fragment-5";
                                name=request.getParameter("name");
                                pno=request.getParameter("pno");
                            ps.clearParameters();
                            ps.setInt(1, id);
                            ps.setString(2, name);
                            ps.setString(3, pno);
                            ps.setString(4, "a");
                            ps1.setInt(1, id1);
                            ps1.setString(2, "Manual Entry");
                            ps1.setString(3, "Manual Entry");
                            ps1.setString(4, "Manual Entry");
                            ps1.setInt(5, id);
                            ps1.setInt(6,0);
                            ps1.setInt(7,0);
                            ps1.setInt(8,0);
                            ps1.setInt(9,0);
                            java.util.Date d=new java.util.Date();
                            java.sql.Timestamp da1=new java.sql.Timestamp(d.getTime());
                            ps1.setTimestamp(10,da1);
                            ps1.execute();
                            }else if(tab.equals("covtype")){
                            out.print(id+" "+" "+val+" "+tab);
                            sql="insert into "+tab+" values(?,?,?,?)";

                            ps.clearParameters();
                            ps.setInt(1, id);
                            ps.setString(2, val);
                            ps.setInt(3, 0);
                            ps.setString(4, "a");
                            red="#fragment-6";
                            }else if(tab.equals("bindmat")){
                                red="#fragment-11";
                                sql="insert into "+tab+" values(?,?,?,?,?)";
                                name=request.getParameter("name");
                                pno=request.getParameter("rate");
                            ps.clearParameters();
                            ps.setInt(1, id);
                            ps.setString(2, name);
                            ps.setString(3, pno);
                            ps.setString(4, "0");
                            ps.setString(5, "a");
                            }else if(tab.equals("contractor")){
                            red="#fragment-7";
                            sql="insert into "+tab+" values(?,?,?,?,?)";
                            name=request.getParameter("name");
                            rate=request.getParameter("rate");
                            area=request.getParameter("area");
                            ps.clearParameters();
                            ps.setInt(1, id);
                            ps.setString(2, name);
                            ps.setString(3, rate);
                            ps.setString(4, area);
                            ps.setString(5, "a");
                            }else if(tab.equals("bindqual")){
                                red="#fragment-10";
                                sql="insert into "+tab+" values(?,?,?,?)";
                            ps.clearParameters();
                            name=request.getParameter("name");
                            String r=request.getParameter("rate");
                            ps.setInt(1, id);
                            ps.setString(2, name);
                            ps.setString(3, r);
                            ps.setString(4, "a");
                            }
                            
                            int i=ps.executeUpdate();

                            out.print(i);
                            if(i==1){
                               response.sendRedirect("home.jsp?q=db"+red);
                            }

}
catch (Exception ex) {
out.println(ex);
}finally {
	  try{
			cn.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
  }
%>
    </body>
</html>
