<%--
    Document   : remove
    Created on : Nov 29, 2011, 6:07:56 PM
    Author     : Rishabh
--%>

<%@page import="session.Item"%>
<%@page import="mybean.Conf"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="session.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dispatched Receipt</title>
    </head>
    <body>
<%
            int se=Integer.parseInt(request.getParameter("se"));
            Cart temp=(Cart)session.getAttribute("cart"+se);
            ArrayList al=temp.get();
            if(!al.isEmpty()){
            int i=al.size();
            Connection cn = null;
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Conf c=new Conf();
                cn = DriverManager.getConnection(c.getURL());
                PreparedStatement ps=null;
                Statement st=cn.createStatement();
                ResultSet rs=st.executeQuery("Select max(id) from transact");
                Statement st1=cn.createStatement();
                ResultSet rs1=null;
                Statement st2=cn.createStatement();
                ResultSet rs2=null;
                rs.next();
                int tid=rs.getInt(1);
                tid++;
                java.util.Date d=new java.util.Date();
                java.sql.Date da=new java.sql.Date(d.getTime());
                st.executeUpdate("insert into transact values('"+tid+"','"+da+"','"+se+"','0','0','','')");

            for(int j=0;j<i;j++){
            Item m=(Item)al.get(j);
                rs1=st.executeQuery("Select max(id) from dispatch");
                rs1.next();
                int did=rs1.getInt(1);
                did++;
                st1.executeUpdate("insert into dispatch values('"+did+"','"+tid+"','"+m.getNB()+"','"+m.getB()+"','"+m.getL()+"','"+m.getSize()+"','"+m.getTotal()+"')");
                    if(true){
                rs2=st2.executeQuery("select * from bindquant where notebook="+m.getPro());
                rs2.next();
                int obun=rs2.getInt("bundle");//old bundle
                int oloose=rs2.getInt("loose");//old loose
                int oquant=rs2.getInt("quantity");//old total
                int nbun=obun-Integer.parseInt(m.getB());//new Bundle
                int nloose=oloose-Integer.parseInt(m.getL());//new Bundle
                int nquant=oquant-m.getTotal();//new Total
                java.util.Date dt=new java.util.Date();
                java.sql.Timestamp da1=new java.sql.Timestamp(dt.getTime());
                if(nbun>=0&&nloose>=0&&nquant>=0){
                st2.executeUpdate("update bindquant set bundle='"+nbun+"', loose='"+nloose+"', quantity='"+nquant+"',updated='"+da1+"' where notebook='"+m.getPro()+"'");
                }else{
                out.print("Invalid Inputs");
                }
                }else{

                }
            }
                temp.remove();
                if(tid>=0){
                response.sendRedirect("printreceipt.jsp?id="+tid);}
%>

        <%
}catch(Exception e){
out.print(e);
}finally {
	  try{
			cn.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}
  }

}else{
out.print("<h1>Invalid Operation</h1>");
}

//response.sendRedirect("dispatch.jsp");
%>

    </body>
</html>
