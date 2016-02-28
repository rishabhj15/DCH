 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

<%
String q1=request.getParameter("q1");
//String q3=request.getParameter("q3");
//String q4=request.getParameter("q4");
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            Statement st= cn.createStatement();
                            Statement st1= cn.createStatement();
                            //ResultSet rs= st.executeQuery("Select bsize,bundle,loose,bsize,quantity from bindquant where notebook="+q1);
                            ResultSet rs= st.executeQuery("Select quantity from bindquant where notebook="+q1);
                            rs.next();
                            //out.print(rs.getInt(1));
                            out.println("<table>");
                                    
//                                    + "<tr><td>Bundle</td><td><input type=text onkeyup='calculatebundle()' id='bns'  name=bundle></td><td>Available:"+rs.getString("bundle")+"</td></tr>"
  //                                              +"<tr><td>Loose</td><td><input type=text onkeyup='calculatebundle()' id='los'  name=loose></td><td>Available:"+rs.getString("loose")+"</td></tr>");

                            //rs.beforeFirst();
/*                            if(rs.next()){
                                out.print("<tr><td>Size</td><td><input value='"+rs.getInt(1)+"' onkeyup='calculatebundle()' readonly onkeyup='showmsg()' id='bs'  type=text name=bs></td><td>Size:"+rs.getString("bsize")+"</td></tr>");}
                            else{
                                out.print("<tr><td>Size</td><td><input value='00' type=text readonly onkeyup='showmsg()' onkeyup='calculatebundle()' id='bs'  name=bs></td><td>Size:0</td></tr>");
                                }*/
                            out.print( "<tr><td>Total</td><td><input type=text name=ts id='ts' ></td><td>Available:"+rs.getString("quantity")+"</td></tr>"
                                                +"<tr><td align='right' colspan=2><input type=submit id='but' value='Add'</td></tr>");
                            cn.close();
} catch (Exception ex) {
                            out.println(ex);
                        }

%>
