 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%
        String q=request.getParameter("id");
        out.print(""+q+"");
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps = cn.prepareStatement("select * from ream as A,papersize as B,rulling as C,contractor as D where pid="+q+" and A.psize=B.id and A.rulling=C.id and A.contractor=D.id");
                            ResultSet rs = ps.executeQuery();
                            Statement st=cn.createStatement();
                            ResultSet rs1=null;
                            //out.print("<table align='center' id='asform'><tr><th colspan='10'>"+size+" Results Found</th></tr>");
                            //out.print("<tr><th>Sno.</th><th>ID</th><th>Paper Type</th><th>Quality</th><th>Size</th><th>Wt</th><th>Entry</th><th>Status</th><th>Updated</th><th>Action</th></tr>");
                            int i=0;
                            while(rs.next()){
                                i++;
                                /*rs1=st.executeQuery("Select * from size where id="+rs.getString("size"));                                rs1.next();
                            out.print("<a name='"+rs.getString(1)+"'><tr id='r"+rs.getString(1)+"' align='center'><td>"+i+"</td><td>"+rs.getString("rid")+"</td>"+"<td>"+rs.getString("papertype")+"</td>"+"<td>"+rs.getString("quality")+"</td>"+"<td>"+rs1.getString("size")+"</td>"+"<td>"+rs.getString("wt")+"</td>"+"<td>"+rs.getString("dat")+"</td>"+"<td id='sta"+rs.getString(1)+"' >"+rs.getString("status")+"</td>"+"<td id='sdate"+rs.getString(1)+"' >"+rs.getString("sdate")+"</td><td id='action"+rs.getString(1)+"'>");                            if(rs.getString("status").equals("raw")){
                            out.print("<a onclick='reamform("+rs.getInt(1)+")' href='#"+rs.getString(1)+"'>Process</a>");
                            }else{
                            out.print("<a target='_blank' href='reelhistory.jsp?id="+rs.getInt(1)+"'><img src='green.jpg' width='30' height='30' ></a>");
                            }
                            out.print("</td></tr><tr><td colspan='10' align='right' id='"+rs.getInt(1)+"'></td></tr>");
 *                          */
                            
                            out.print("<table><tr>"
                                    + "<tr>"
                                    + "<table><tr>"
                                     + "<th>Date</th><th>Papersize</th><th>Rulling</th><th>Contractor</th><th>Quantity</th></tr>"
                                        + "<tr><td align='center' >"+rs.getString("A.dat")+"</td>"
                                    //+ "<td>"+rs.getString("A.id")+"</td></tr>"
                                        + "<td align='center'>"+rs.getString("B.type")+"</td>"
                                        + "<td align='center'>"+rs.getString("C.type")+"</td>"
                                        + "<td align='center'>"+rs.getString("D.name")+"</td>"
                                        + "<td align='center'>"+rs.getString("A.quantity")+"</td></tr></table></tr></table>");
                            }
                            cn.close();
                        } catch (Exception ex) {
                            out.println(ex);
                        }
        %>
