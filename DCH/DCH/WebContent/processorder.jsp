<%--
    Document   : processorder
    Created on : Sep 22, 2012, 7:56:00 PM
    Author     : Rishabh
--%>

<%@page import="session.Item_1"%>
<%@page import="java.util.ArrayList"%>
<%@page import="session.Cart_1"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
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
String pid=request.getParameter("cparty")        ;
String oid=request.getParameter("oid")        ;
String proid[]=request.getParameterValues("proid");
String b_order[]=request.getParameterValues("bundle");
String l_order[]=request.getParameterValues("loose");
String total[]=request.getParameterValues("total");
String bsize[]=request.getParameterValues("bsize");
String parcel=request.getParameter("parcel");
if(parcel.equals("")){
parcel="0";
}
        out.println(oid+"<br>");
        out.println(pid);
        out.println(proid[0]);
        out.println(b_order[0]);
        out.println(l_order[0]);
        out.println(bsize[0]);

 try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            ResultSet rs=null;



            Cart_1 temp=(Cart_1)session.getAttribute("ordercart");
            if(temp!=null){
            int i=proid.length;
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                //rs=st.executeQuery("Select max(id) from transact");
                rs=st.executeQuery("Select max(showid) from transact");				//IDChange
                Statement st1=cn.createStatement();
                ResultSet rs1=null;
                Statement st2=cn.createStatement();
                Statement st3=cn.createStatement();
                Statement st4=cn.createStatement();
                ResultSet rs2=null;
                ResultSet rs3=null;
                rs.next();
                int tid=rs.getInt(1);
                tid++;
                java.util.Date d=new java.util.Date();
                java.sql.Date da=new java.sql.Date(d.getTime());
                int ret = st.executeUpdate("insert into transact values(null,'"+tid+"','"+da+"','"+pid+"',"+parcel+",'0','','')");
                int traid = -1;
                if(ret==1){
                	ResultSet trid = st4.executeQuery("Select max(id) from transact") ;
                	if(trid.next()){
                		traid = trid.getInt(1);
                	}
                }
                if(oid!=null){
                    st.executeUpdate("update `order` set status='d' where id="+oid);
                    st.executeUpdate("delete from order_list where  oid="+oid);
                }

                for(int j=0;j<i;j++){
            
                rs1=st.executeQuery("Select max(id) from dispatch");
                rs1.next();
                int did=rs1.getInt(1);
                did++;
                st1.executeUpdate("insert into dispatch values('"+did+"','"+traid+"',(select concat(product,' ',rulling) from stockwithid where id="+proid[j]+"),'"+b_order[j]+"','"+l_order[j]+"','"+bsize[j]+"','"+((Integer.parseInt(b_order[j])*Integer.parseInt(bsize[j]))+Integer.parseInt(l_order[j]))+"')");
                    if(true){
                rs2=st2.executeQuery("select * from bindquant where notebook="+proid[j]);
                rs2.next();
//                int obun=rs2.getInt("bundle");//old bundle
//                int oloose=rs2.getInt("loose");//old loose
                int oquant=rs2.getInt("quantity");//old total
//                int nbun=obun-Integer.parseInt(b_order[j]);//new Bundle
//                int nloose=oloose-Integer.parseInt(l_order[j]);//new Bundle
                int nquant=oquant-Integer.parseInt(total[j]);//new Total
                java.util.Date dt=new java.util.Date();
                java.sql.Timestamp da1=new java.sql.Timestamp(dt.getTime());
                if(nquant>=0){
//                st2.executeUpdate("update bindquant set bundle='"+nbun+"', loose='"+nloose+"', quantity='"+nquant+"',updated='"+da1+"' where notebook='"+proid[j]+"'");
                st2.executeUpdate("update bindquant set quantity='"+nquant+"',updated='"+da1+"' where notebook='"+proid[j]+"'");
                }else{
                out.print("Invalid Inputs");
                }
                }else{

                }
            }
                temp.remove();
                if(traid>=0){
                response.sendRedirect("printreceipt.jsp?id="+traid);
                }
%>

        <%
}catch(Exception e){
out.print(e);
}

}else{
out.print("<h1>Invalid Operation</h1>");
}

 }catch(Exception ex){
out.println(ex);
 }

%>
    </body>
</html>
