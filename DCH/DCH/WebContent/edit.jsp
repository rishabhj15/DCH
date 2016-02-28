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
    String id=request.getParameter("id");
try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            String sql="Select * from "+tab+" where id="+id;
                            String red="#";
                            ResultSet rs=st.executeQuery(sql);
                            out.print("<h2 id='cmd'>Edit "+tab.toLowerCase()+"</h2>");
                            while(rs.next()){
                                out.print("<form target='_parent' action='update.jsp?tab="+tab+"' method=post ><table align='center' >");
                                if(tab.equals("notebook")||tab.equals("contractor")||tab.equals("bindqual")||tab.equals("bindmat")){
                                out.print("<tr><td><input type=text name=val value='"+rs.getString(2)+"'></td><td><input type=text name=val value='"+rs.getString(3)+"'></td><td><input type=submit value=Update id='but'></td></tr></table>");
                                }else if(tab.equals("user")){
                                out.print("<tr><td><b>New Password: </b></td><td><input type=text name=val value='"+rs.getString(3)+"'></td><td><input type=submit value=Update id='but'></td></tr></table>");
                                }else{
                                out.print("<tr><td><input type=text name=val value='"+rs.getString(2)+"'></td><td><input type=submit value=Update id='but'></td></tr></table>");
                                red="#fragment-1";
                                }
                                if(tab.equals("contractor")){
                                out.print("<input type='hidden' name=val value='"+rs.getString(4)+"'>");
                                }else if(tab.equals("covtype")){
                                out.print("<input type='hidden' name=q value='"+rs.getString(3)+"'>");
                                out.print(rs.getString(3));
                                }
                            }
                            out.print("<input type='hidden' name='id' value="+id+" ></form>");
//}
                            /*else if(tab.equals("rulling")){
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
                            }*/
                            
                            
                            
                            //   response.sendRedirect("home.jsp?q=db"+red);
                            

} catch (Exception ex) {
out.println(ex);
}
}else{%>
You are not authorized. Please Login.
        <%}%>
    </body>
</html>
