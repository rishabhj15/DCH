<%@page import="mybean.Conf"%>
<%@page import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="shortcut icon" type="image/ico" href="http://www.datatables.net/favicon.ico" />

		<title>DataTables example</title>
	</head>
	<body>




<table cellpadding="0" cellspacing="0" border="0" class="display" id="example" width="100%">
                        <thead>
                        <tr id="" ><th>Sno</th><th>Quality</th><th>Paper-size</th><th>Rulling</th><th>Quantity</th><th>Updated</th><th>Action</th></tr>
                        </thead>
                        <tbody>
                            <%String m=request.getParameter("q1");
                            int mi=Integer.parseInt(m);
                            
 try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st=cn.createStatement();
                            Statement st1=cn.createStatement();
ResultSet rs=st.executeQuery("Select A.updated,A.id,A.quality,A.psize,A.rulling,A.quantity,B.type,C.type from reamquant as A,papersize as B,rulling as C where A.psize=B.id and A.rulling=C.id order by A.quality,B.type, C.type");
                    int g=0;
                    int h=0;
                    String t1,t2="";
                    java.util.Date d1=new java.util.Date();
                            java.sql.Timestamp da1=new java.sql.Timestamp(d1.getTime());
                    while(rs.next()){h++;g++;
ResultSet x=st1.executeQuery("SELECT DATEDIFF(now(),'"+rs.getDate("A.updated")+"')");
x.next();
Float f=Float.parseFloat(rs.getString("quantity"));

%>

<tr  <%if(f<mi){%> class="even gradeX" <%}else{%>class="even gradeA"<%}%>   >
                        <td ><%=h%></td >
                        <td ><%=rs.getString("quality")%><input type="hidden" id="<%=g%>s1" value="<%=rs.getString("quality")%>"><input type="hidden" id="<%=g%>s3" value="<%=rs.getString("psize")%>"> <input type="hidden" id="<%=g%>s4" value="<%=rs.getString("A.rulling")%>"></td>
                        <td><%=rs.getString("B.type")%></td>
                        <td><%=rs.getString("C.type")%></td>
                        <td><%=f%></td>
                        <td style=" padding-left:0px; <%if(x.getInt(1)<1){%> color:red;<%}%>"><%=rs.getString("A.updated")+"<br> "+x.getString(1)+" days ago."%></td>
                        <td style=" float: right; vertical-align: top;  " ><a href="reamsearch.jsp?q1=<%=rs.getString("quality")%>&q3=<%=rs.getString("psize")%>&q4=<%=rs.getString("rulling")%>" id="example4" ><img width="20" src="images/proc.png"></a> <a href="editreamquant.jsp?q1=<%=rs.getString("quality")%>&q3=<%=rs.getString("psize")%>&q4=<%=rs.getString("rulling")%>" id="example4" ><img width="20" src="images/edit.png"></a> <a href="del.jsp?tab=reamquant&id=<%=rs.getString("A.id")%>" onclick="return ask()" id="del"><img width="20" src="images/del.png"></a></td>
                    </tr>

                    <%

}}catch(Exception e){

}%>
                        </tbody>
</table>






	</body>
</html>