 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%
        String q=request.getParameter("q");
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            Connection cn = DriverManager.getConnection(c.getURL());
                            PreparedStatement ps = cn.prepareStatement(q);
                            ResultSet rs = ps.executeQuery();
                            
/*                            ResultSet rs1=null;
    int size =0;
    if (rs != null)
    {
      rs.beforeFirst();
      rs.last();
      size = rs.getRow();
      rs.beforeFirst();
    }
                            out.print("<table id='asform'><th colspan='10'>"+size+" Results Found</th></tr>");
                            out.print("<tr><th>Sno.</th><th>ID</th><th>Paper Type</th><th>Quality</th><th>Size</th><th>Wt</th><th>Entry</th><th>Status</th><th>Updated</th><th>Action</th></tr>");
                            int i=0;*/
                            rs.next();
                            out.print("<table id='asform'><tr><th>Available</th><td>");
                            out.println(rs.getInt(1));
                            
                            out.print("</td></tr></table>");
                            cn.close();
                        } catch (Exception ex) {
                            out.println(ex);
                        }
        %>
