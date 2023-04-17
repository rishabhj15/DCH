 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>
    
        <%
        String q=request.getParameter("q");
        
        out.print("<br>");
        Connection cn = null;
        
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps = cn.prepareStatement(q);
                            ResultSet rs = ps.executeQuery();
                            Statement st=cn.createStatement();
                            ResultSet rs1=null;
    int size =0;
    if (rs != null)
    {
      rs.beforeFirst();
      rs.last();
      size = rs.getRow();
      rs.beforeFirst();
    }
                            out.print("<table align='center' id='asform'><tr><th colspan='10'>"+size+" Results Found</th></tr>");
                            out.print("<tr><th>Sno.</th><th>ID</th><th>Paper Type</th><th>Quality</th><th>Size</th><th>Wt</th><th>Entry</th><th>Status</th><th>Updated</th><th>Action</th></tr>");
                            int i=0;
                            while(rs.next()){
                                i++;
                                rs1=st.executeQuery("Select * from size where id="+rs.getString("size"));
                                rs1.next();
                            out.print("<a name='"+rs.getInt(1)+"'><tr id='r"+rs.getString(1)+"' align='center'><td>"+i+"</td><td>"+rs.getString("rid")+"</td>"+"<td>"+rs.getString("papertype")+"</td>"+"<td>"+rs.getString("quality")+"</td>"+"<td>"+rs1.getString("size")+"</td>"+"<td>"+rs.getString("wt")+"</td>"+"<td>"+rs.getString("dat")+"</td>"+"<td id='sta"+rs.getString(1)+"' >"+rs.getString("status")+"</td>"+"<td id='sdate"+rs.getString(1)+"' >"+rs.getString("sdate")+"</td><td id='action"+rs.getString(1)+"'>");
                            if(rs.getString("status").equals("raw")){
                            out.print("<a onclick='reamform("+rs.getInt(1)+")' href='#"+rs.getString(1)+"'>Process</a>");
                            }else{
                            out.print("<a onclick='reelhistory("+rs.getInt(1)+")'  href='#"+rs.getString(1)+"'><img src='green.jpg' width='30' height='30' ></a>");
                            }
                            out.print("</td></tr><tr><td colspan='10' align='right' id='"+rs.getInt(1)+"'></td></tr>");
                            }
                            out.print("</table>");
                        } catch (Exception ex) {
                            out.println(ex);
                        }finally {
                        	  try{
                      			cn.close();
                      		}catch(Exception ex){
                      			ex.printStackTrace();
                      		}
                          }
        %>
