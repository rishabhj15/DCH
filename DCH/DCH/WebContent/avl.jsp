 <%@ page import="java.sql.*,session.*"%>
 <%@page import="mybean.*"%>

        <%
        String q=request.getParameter("q");
        Connection cn = null;
        try {
                            Class.forName("com.mysql.jdbc.Driver").newInstance();
                            Conf c=new Conf();
                            cn = DriverManager.getConnection(c.getURL());
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
                            if(rs.next()){
                            out.print("<table><tr><td id='top' valign=top >Bundle:</td><td id='top'> <input tabindex=3 onfocus=colorize('bundle') style='text-align: right' type='text' id='bundle' size='5'>Max:<div id=avb>");
                            out.println(rs.getInt(1));
                            out.print("</div></td><td id='top' valign=top>Loose:</td><td id='top' valign='top'> <input tabindex=4 onfocus=colorize('loose') style='text-align: right;' value='0' type='text' id='loose' size='5'>Max:<div id=avlo>");
                            out.println(rs.getInt(2));
                            out.print("</div></td><td id='top' valign=top>Size:</td><td id='top' valign='top'> <input tabindex=5 onfocus=colorize('size') style='text-align: right;' type='text' id='size' value="+rs.getInt(3)+" size='5'>");

                            out.print("</td><td id='top' valign=top><input tabindex=6 type='button' id='but' onclick='append()' value='Add to Cart' ></td></tr></table>");
                            }else{
                            out.print("0 Available");
                            }
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
        