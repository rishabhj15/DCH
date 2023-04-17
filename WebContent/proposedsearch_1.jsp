 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

<%
String q1=request.getParameter("q1");

out.println("<hr><b>You queried for : </b>"+q1+"<hr>");
Connection cn = null;
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            Statement st2= cn.createStatement();
                            Statement st3= cn.createStatement();
                            ResultSet rs= st.executeQuery("Select * from bind where contractor='"+q1+"' and sta='proposed' order by contractor");
                            ResultSet rs1=null;
                            ResultSet rs2=null;
                            ResultSet rs3=null;
                            out.print("<table align='right' id='asform'><tr><th>Contractor</th><th>Date</th><th>Notebook</th><th>Proposed</th><th align='left' >Bundle&nbsp;&nbsp;&nbsp;&nbsp; Loose &nbsp; Size &nbsp; Total &nbsp; Action</th>");
                            while(rs.next()){
                                rs1=st1.executeQuery("Select B.name,R.type from notebook A,covtype B,rulling R where A.id="+rs.getString("bindquantid")+" and A.name=B.id and A.pno=R.id");
                                rs1.next();
                                rs2=st2.executeQuery("Select * from contractor where id="+rs.getString("contractor"));
                                rs2.next();
                                rs3=st3.executeQuery("Select bsize from bindquant where notebook="+rs.getString("bindquantid"));
                                rs3.next();

                            out.print("<tr id='even1'><td>"+rs2.getString("name")+"</td><td>"+rs.getDate("dat")+"</td><td>"+rs1.getString(1)+" "+rs1.getString(2)+"</td><td align='right' >"+rs.getString("notebookq")+"</td><td id='"+rs.getInt("id")+"' align=left ><form>"
                                    + "<input type=hidden id='quality"+rs.getString(1)+"' value='"+rs.getString("quality")+"'><input type=hidden id='psize"+rs.getString(1)+"' value='"+rs.getString("psize")+"'><input type=hidden id='rulling"+rs.getString(1)+"' value='"+rs.getString("rulling")+"'>"
                                    + "<input type=hidden id='notebook"+rs.getString(1)+"' value='"+rs.getString("bindquantid")+"'><input type=hidden id='bid"+rs.getString(1)+"'  value='"+rs.getString(1)+"'>"
                                    + " &nbsp;<input type='text' tabindex='"+rs.getString(1)+"'  onkeyup='calbun("+rs.getString(1)+")'  size='5' id='bundle"+rs.getInt(1)+"'> &nbsp;"
                                    + "<input type='text' tabindex='"+rs.getString(1)+"'  onkeyup='calbun("+rs.getString(1)+")' size='5' id='loose"+rs.getInt(1)+"'>&nbsp;"
                                    + "<input type='text' tabindex='-1' size='2' id='bs"+rs.getString(1)+"' value='"+rs3.getInt("bsize")+"' readonly onkeyup='showmsg()' >  &nbsp; "
                                    + "<input type='text'  size='5' tabindex='"+rs.getString(1)+"' id='total"+rs.getInt(1)+"'><input type=hidden id=nbid"+rs.getInt(1)+" value='"+rs.getString("bindquantid")+"'><span id='covqu"+rs.getString(1)+"'></span> "
                                    + "| <span id='proceed'>"
                                    + "<input type='button' id='proceed"+rs.getString(1)+"' tabindex='"+rs.getString(1)+"' disabled onclick='submitbinded("+rs.getString(1)+")' value='Proceed'>"
                                    + "</span>"
                                    + "</form></td></tr>");
            }
} catch (Exception ex) {
                            out.println(ex.toString());
                        }

%>
