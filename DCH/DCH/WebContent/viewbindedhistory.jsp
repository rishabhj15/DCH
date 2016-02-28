<%-- 
    Document   : viewbindedhistory
    Created on : Feb 3, 2013, 2:53:55 PM
    Author     : Rishabh
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="mybean.Conf"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <script type="text/javascript" src="scw.js"></script>
        <script type="text/javascript">
            
            function refreshAll(){
                nbid=document.getElementById("nbid").value;
                prod=document.getElementById("prod").value;
                frm=document.getElementById("frm").value;
                to=document.getElementById("to").value;
               
                window.location.href="viewbindedhistory.jsp?id="+nbid+"&prod="+prod+"&fromd="+frm+"&tod="+to;
            }
        </script>
<%
String nbid=request.getParameter("id");
String prod=request.getParameter("prod");
String fd=request.getParameter("fromd");
String td=request.getParameter("tod");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <input type="hidden" id="nbid" value="<%=nbid%>">
        <input type="hidden" id="prod" value="<%=prod%>">
        <%try {int total=0;
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            ResultSet rs=null;
                            String fromd,tod;
                            if(fd.equals("all")||td.equals("all")){
                                java.util.Date d=new java.util.Date();
                                tod = new SimpleDateFormat("yyyy-MM-dd").format(d);
                                d.setDate(d.getDate() - 30);
                                fromd = new SimpleDateFormat("yyyy-MM-dd").format(d);
                                rs=st.executeQuery("Select * from bind A,papersize B,rulling C, Contractor D, stockwithid E,bindqual F where A.bindquantid="+nbid+" and A.psize=B.id and A.rulling=C.id and A.contractor=D.id and A.bindquantid=E.id and A.bindqualid=F.id order by dat");
                            }else{
                                tod = td;
                                fromd = fd;
                                rs=st.executeQuery("Select * from bind A,papersize B,rulling C, Contractor D, stockwithid E,bindqual F where A.bindquantid="+nbid+" and A.psize=B.id and A.rulling=C.id and A.contractor=D.id and A.bindquantid=E.id and A.bindqualid=F.id and A.dat between '"+fd+"' and '"+td+"' order by dat");
                            }
%>
<h2 style=" background-color: #7bd2f9; color: #e14f1c;  position: fixed; left: 75%; right: 0% " ><%=prod%></h2>
<fieldset>
                                    <legend>Select Period:</legend>
<table>

<tr><td>From</td><td><input onclick='scwShow(this,event);' class="text" id="frm" name="frm" value='<%=fromd%>' /></td><td>To</td><td><input onclick='scwShow(this,event);' class="text" name="to" id="to" value='<%=tod%>' /></td><td><input type="button" onclick="refreshAll()" value="Refresh"></tr>
</table>
</fieldset><br>

<fieldset>
                                    <legend>Inward:</legend>
<table border="1" style="border-collapse: collapse; ">
    <tr><th rowspan="2">SNo.</th><th rowspan="2" >Date</th><th colspan="4">Parent Ream</th><th colspan="5">Rulling Data</th></tr>
    <tr><th>Quality</th><th>Size</th><th>Rulling</th><th>Quantity</th><th>Contractor</th><th>Proposed</th><th>Processed</th><th>Rulling Quality</th></tr>
<%           int i=0;         while(rs.next()){i++;total+=rs.getInt("A.notebookpq");
%>
<tr><td><%=i%></td><td><%=rs.getString("A.dat")%></td><td><%=rs.getString("A.quality")%></td><td><%=rs.getString("B.type")%></td><td><%=rs.getString("C.type")%></td><td><%=rs.getString("A.quantity")%></td><td><%=rs.getString("D.name")%></td><td align="right"><%=rs.getString("A.notebookq")%></td><td align="right"><%=rs.getString("A.notebookpq")%></td><td><%=rs.getString("F.name")+": "+rs.getString("F.rate")%></td></tr>
<%
}%>
<tr><td colspan="8" ></td><td align="right" ><%=total%></td><td colspan="2" ></td></tr>
</table>
</fieldset>
<br>
<%
rs.close();
if(fd.equals("all")||td.equals("all")){
    rs=st.executeQuery("Select * from dispatch A,transact B,party C where A.particular='"+prod+"' and A.tid=B.id and B.party=C.id");
}else{
rs=st.executeQuery("Select * from dispatch A,transact B,party C where A.particular='"+prod+"' and A.tid=B.id and B.party=C.id and B.dat between '"+fd+"' and '"+td+"'");
}
%>
<fieldset>
                                    <legend>Outward:</legend>

<table border="1" style="border-collapse: collapse;">
    <tr><th>Sno</th><th>Date</th><th>Receipt</th><th>Party</th><th>Quantity</th></tr>
    <%i=0;total=0; while(rs.next()){i++;total+=rs.getInt("A.total");%>
    <tr><td><%=i%></td><td><%=rs.getString("B.dat")%></td><td><a target="_blank" href="printreceipt.jsp?id=<%=rs.getString("A.Tid")%>"><%=rs.getString("A.Tid")%></a></td><td><%=rs.getString("C.name")+" "+rs.getString("C.addr")%></td><td><%=rs.getString("A.total")%></td></tr>
    <%}%>
    <tr><td colspan="4" ></td><td><%=total%></td></tr>
</table>
</fieldset>
<%
}catch (Exception ex) {
out.print(ex);
}
%>
    </body>
</html>
